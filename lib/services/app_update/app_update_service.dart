import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth/auth.dart';

class AppUpdateInfo {
  const AppUpdateInfo({
    required this.requiresUpdate,
    required this.hasOptionalUpdate,
    required this.minVersion,
    required this.latestVersion,
    required this.currentVersion,
    required this.packageName,
    this.storeUri,
  });

  final bool requiresUpdate;
  final bool hasOptionalUpdate;
  final String minVersion;
  final String latestVersion;
  final String currentVersion;
  final String packageName;
  final Uri? storeUri;

  static const empty = AppUpdateInfo(
    requiresUpdate: false,
    hasOptionalUpdate: false,
    minVersion: '0.0.0',
    latestVersion: '0.0.0',
    currentVersion: '0.0.0+0',
    packageName: '',
  );
}

class AppUpdateService extends ChangeNotifier {
  AppUpdateService._();

  static final AppUpdateService I = AppUpdateService._();

  AppUpdateInfo _currentInfo = AppUpdateInfo.empty;
  bool _launchFlowCompleted = false;
  bool _started = false;
  bool _isRefreshing = false;

  AppUpdateInfo get currentInfo => _currentInfo;
  bool get launchFlowCompleted => _launchFlowCompleted;

  Future<void> start() async {
    if (_started) return;
    _started = true;

    final cachedInfo = await _buildUpdateInfo(fetchRemote: false);
    _setCurrentInfo(cachedInfo);

    unawaited(refreshInBackground());
  }

  void resetLaunchFlow() {
    if (!_launchFlowCompleted) return;
    _launchFlowCompleted = false;
    notifyListeners();
  }

  void markLaunchFlowCompleted() {
    if (_launchFlowCompleted) return;
    _launchFlowCompleted = true;
    notifyListeners();
  }

  Future<void> refreshUsingActivatedConfig() async {
    final info = await _buildUpdateInfo(fetchRemote: false);
    _setCurrentInfo(info);
  }

  Future<void> refreshInBackground() async {
    if (_isRefreshing) return;
    _isRefreshing = true;

    try {
      final info = await _buildUpdateInfo(fetchRemote: true);
      _setCurrentInfo(info);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<AppUpdateInfo> checkForUpdates() async {
    return _buildUpdateInfo(fetchRemote: true);
  }

  Future<AppUpdateInfo> _buildUpdateInfo({required bool fetchRemote}) async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final remoteConfig = FirebaseRemoteConfig.instance;
      final skippedOptionalUpdateVersion =
          await Auth().getSkippedOptionalUpdateVersion();

      await _prepareRemoteConfig(remoteConfig);

      if (fetchRemote) {
        try {
          await remoteConfig.fetchAndActivate();
        } catch (_) {
          // Fall back to the last activated/cached value or the default above.
        }
      }

      final minVersion = remoteConfig.getString('min_version').trim();
      final latestVersion = remoteConfig.getString('latest_version').trim();
      final currentVersion = '${packageInfo.version}+${packageInfo.buildNumber}';
      final comparableCurrentMinVersion =
          minVersion.contains('+') ? currentVersion : packageInfo.version;
      final comparableCurrentLatestVersion =
          latestVersion.contains('+') ? currentVersion : packageInfo.version;

      final requiresUpdate =
          minVersion.isNotEmpty &&
          _compareVersions(comparableCurrentMinVersion, minVersion) < 0;

      final hasOptionalUpdate =
          !requiresUpdate &&
          latestVersion.isNotEmpty &&
          _compareVersions(comparableCurrentLatestVersion, latestVersion) < 0 &&
          latestVersion != skippedOptionalUpdateVersion;

      if (!hasOptionalUpdate && latestVersion != skippedOptionalUpdateVersion) {
        await Auth().clearSkippedOptionalUpdateVersion();
      }

      return AppUpdateInfo(
        requiresUpdate: requiresUpdate,
        hasOptionalUpdate: hasOptionalUpdate,
        minVersion: minVersion,
        latestVersion: latestVersion,
        currentVersion: currentVersion,
        packageName: packageInfo.packageName,
      );
    } catch (_) {
      return AppUpdateInfo.empty;
    }
  }

  Future<void> _prepareRemoteConfig(FirebaseRemoteConfig remoteConfig) async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 8),
        minimumFetchInterval:
            kDebugMode ? Duration.zero : const Duration(minutes: 1),
      ),
    );
    await remoteConfig.setDefaults(const {
      'min_version': '0.0.0',
      'latest_version': '0.0.0',
    });
  }

  void _setCurrentInfo(AppUpdateInfo info) {
    final didChange =
        _currentInfo.requiresUpdate != info.requiresUpdate ||
        _currentInfo.hasOptionalUpdate != info.hasOptionalUpdate ||
        _currentInfo.minVersion != info.minVersion ||
        _currentInfo.latestVersion != info.latestVersion ||
        _currentInfo.currentVersion != info.currentVersion ||
        _currentInfo.packageName != info.packageName;

    _currentInfo = info;

    if (didChange) {
      notifyListeners();
    }
  }

  Future<bool> openStore({
    String? packageName,
    bool allowImmediateAndroidUpdate = false,
  }) async {
    final currentPackageName = packageName ??
        (await PackageInfo.fromPlatform()).packageName;

    if (Platform.isAndroid && allowImmediateAndroidUpdate) {
      final openedImmediateUpdate = await _tryImmediateAndroidUpdate();
      if (openedImmediateUpdate) {
        return true;
      }
    }

    final uris = await _resolveStoreUris(currentPackageName);
    for (final uri in uris) {
      try {
        final opened = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
        if (opened) return true;
      } catch (_) {
        // Try the next available store/browser fallback.
      }
    }

    return false;
  }

  Future<bool> _tryImmediateAndroidUpdate() async {
    if (!Platform.isAndroid) return false;

    try {
      final updateInfo = await InAppUpdate.checkForUpdate();
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        await InAppUpdate.performImmediateUpdate();
        return true;
      }
    } catch (_) {
      // Fall back to the Play Store page when immediate updates are unavailable.
    }

    return false;
  }

  Future<List<Uri>> _resolveStoreUris(String packageName) async {
    if (Platform.isAndroid) {
      return <Uri>[
        Uri.parse('market://details?id=$packageName'),
        Uri.parse('https://play.google.com/store/apps/details?id=$packageName'),
      ];
    }

    if (Platform.isIOS) {
      final trackViewUrl = await _lookupIosTrackViewUrl(packageName);
      if (trackViewUrl != null) {
        final uri = Uri.tryParse(trackViewUrl);
        if (uri != null) {
          return <Uri>[uri];
        }
      }
    }

    return const <Uri>[];
  }

  Future<String?> _lookupIosTrackViewUrl(String packageName) async {
    try {
      final response = await Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      ).getUri(
        Uri.https('itunes.apple.com', '/lookup', {
          'bundleId': packageName,
        }),
      );

      final data = response.data;
      if (data is! Map<String, dynamic>) return null;

      final results = data['results'];
      if (results is! List || results.isEmpty) return null;

      final first = results.first;
      if (first is! Map<String, dynamic>) return null;

      final trackViewUrl = first['trackViewUrl'];
      if (trackViewUrl is String && trackViewUrl.trim().isNotEmpty) {
        return trackViewUrl;
      }
    } catch (_) {
      return null;
    }

    return null;
  }

  int _compareVersions(String current, String required) {
    final currentParts = _parseVersion(current);
    final requiredParts = _parseVersion(required);
    final maxLength = currentParts.length > requiredParts.length
        ? currentParts.length
        : requiredParts.length;

    for (var index = 0; index < maxLength; index++) {
      final currentValue = index < currentParts.length ? currentParts[index] : 0;
      final requiredValue =
          index < requiredParts.length ? requiredParts[index] : 0;

      if (currentValue == requiredValue) continue;
      return currentValue < requiredValue ? -1 : 1;
    }

    return 0;
  }

  List<int> _parseVersion(String version) {
    final trimmedVersion = version.trim();
    if (trimmedVersion.isEmpty) return const <int>[0];

    final parts = trimmedVersion.split('+');
    final values = <int>[];

    for (final segment in parts.first.split('.')) {
      values.add(_extractLeadingNumber(segment));
    }

    if (parts.length > 1) {
      values.add(_extractLeadingNumber(parts[1]));
    }

    return values;
  }

  int _extractLeadingNumber(String value) {
    final match = RegExp(r'\d+').firstMatch(value);
    return int.tryParse(match?.group(0) ?? '') ?? 0;
  }
}


