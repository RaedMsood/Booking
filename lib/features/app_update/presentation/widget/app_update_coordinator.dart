import 'package:flutter/material.dart';

import '../../../../services/app_update/app_update_service.dart';
import '../../../../services/auth/auth.dart';
import '../page/force_update_page.dart';
import 'optional_update_bottom_sheet.dart';

class AppUpdateCoordinator extends StatefulWidget {
  const AppUpdateCoordinator({
    super.key,
    required this.child,
    required this.navigatorKey,
  });

  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<AppUpdateCoordinator> createState() => _AppUpdateCoordinatorState();
}

class _AppUpdateCoordinatorState extends State<AppUpdateCoordinator>
    with WidgetsBindingObserver {
  AppUpdateService get _service => AppUpdateService.I;

  bool _isProcessingPresentation = false;
  bool _isOptionalSheetOpen = false;
  bool _isForceUpdateVisible = false;
  String? _lastOptionalVersionPresented;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _service.addListener(_handleServiceChange);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _service.start();
      _handleServiceChange();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _service.removeListener(_handleServiceChange);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _service.refreshInBackground();
    }
  }

  void _handleServiceChange() {
    if (!mounted || _isProcessingPresentation) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _isProcessingPresentation) return;
      _processPresentation();
    });
  }

  Future<void> _processPresentation() async {
    final navigator = widget.navigatorKey.currentState;
    final navigatorContext = widget.navigatorKey.currentContext;
    final info = _service.currentInfo;

    if (!mounted ||
        navigator == null ||
        navigatorContext == null ||
        !_service.launchFlowCompleted) {
      return;
    }

    _isProcessingPresentation = true;

    try {
      if (info.requiresUpdate) {
        if (_isForceUpdateVisible) return;

        _isForceUpdateVisible = true;
        await navigator.push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => ForceUpdatePage(updateInfo: info),
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
        _isForceUpdateVisible = false;
        return;
      }

      if (!info.hasOptionalUpdate || _isOptionalSheetOpen || _isForceUpdateVisible) {
        return;
      }

      if (_lastOptionalVersionPresented == info.latestVersion) {
        return;
      }

      _isOptionalSheetOpen = true;
      _lastOptionalVersionPresented = info.latestVersion;

      final shouldUpdateNow = await showModalBottomSheet<bool>(
        context: navigatorContext,
        useRootNavigator: true,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => OptionalUpdateBottomSheet(updateInfo: info),
      );

      _isOptionalSheetOpen = false;

      if (shouldUpdateNow != true && info.latestVersion.isNotEmpty) {
        await Auth().cacheSkippedOptionalUpdateVersion(info.latestVersion);
      }

      await _service.refreshUsingActivatedConfig();
    } finally {
      _isProcessingPresentation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}


