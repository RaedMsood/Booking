import 'dart:io';

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
}

class AppUpdateService {
  AppUpdateService._();

  static final AppUpdateService I = AppUpdateService._();

  Future<AppUpdateInfo> checkForUpdates() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final remoteConfig = FirebaseRemoteConfig.instance;
      final skippedOptionalUpdateVersion =
          await Auth().getSkippedOptionalUpdateVersion();

      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 8),
          minimumFetchInterval:
              kDebugMode ? Duration.zero : const Duration(hours: 1),
        ),
      );
      await remoteConfig.setDefaults(const {
        'min_version': '0.0.0',
        'latest_version': '0.0.0',
      });

      try {
        await remoteConfig.fetchAndActivate();
      } catch (_) {
        // Fall back to the last activated/cached value or the default above.
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
      return const AppUpdateInfo(
        requiresUpdate: false,
        hasOptionalUpdate: false,
        minVersion: '0.0.0',
        latestVersion: '0.0.0',
        currentVersion: '0.0.0+0',
        packageName: '',
      );
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

    final uri = await _resolveStoreUri(currentPackageName);
    if (uri == null) return false;

    if (await canLaunchUrl(uri)) {
      return launchUrl(uri, mode: LaunchMode.externalApplication);
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

  Future<Uri?> _resolveStoreUri(String packageName) async {
    if (Platform.isAndroid) {
      final nativeUri = Uri.parse('market://details?id=$packageName');
      if (await canLaunchUrl(nativeUri)) {
        return nativeUri;
      }

      return Uri.parse(
        'https://play.google.com/store/apps/details?id=$packageName',
      );
    }

    if (Platform.isIOS) {
      final trackViewUrl = await _lookupIosTrackViewUrl(packageName);
      if (trackViewUrl != null) {
        return Uri.tryParse(trackViewUrl);
      }
    }

    return null;
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


