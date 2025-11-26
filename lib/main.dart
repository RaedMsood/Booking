import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/network/remote_request.dart';
import 'core/notifications/firebase_messaging_service.dart';
import 'core/notifications/notification_bootstrap.dart';
import 'core/state/app_restart_controller.dart';
import 'package:booking/injection.dart' as di;
import 'core/theme/theme.dart';
import 'features/launch_page.dart';
import 'features/profile/presentation/state_mangement/riverpod.dart';
import 'generated/l10n.dart';
import 'services/auth/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await NotificationBootstrap.I.init(debug: kDebugMode);

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    if (kReleaseMode) {
      debugPrint("Flutter Error in Release Mode: ${details.exception}");
    }
  };
  runZonedGuarded(
        () async {
      RemoteRequest.initDio();
      await di.init();
      Auth();
      runApp(const AppRestartController(child: MyApp()));
    },
        (error, stackTrace) {
      debugPrint("Caught error in release mode: $error");
      debugPrint("Stack trace: $stackTrace");
    },
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    FirebaseMessagingService.I.getDeviceToken().then((t) {
      if (t != null) {
        print('Device Token: $t');
        Auth().setFcmToken(t);
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(languageProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: false,
      splitScreenMode: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: locale,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar'),
          Locale('en'),
        ],
        theme: lightTheme,
        home: const LaunchPage(),
      ),
    );
  }
}
// package com.algonest.booking
//
// import io.flutter.embedding.android.FlutterActivity
// class MainActivity: FlutterActivity()
