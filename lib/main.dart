import 'dart:async';
import 'dart:io';
import 'package:booking/features/user/presentation/pages/log_in_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/network/remote_request.dart';
import 'core/state/app_restart_controller.dart';
import 'package:booking/injection.dart' as di;
import 'core/theme/theme.dart';
import 'core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import 'features/user/presentation/pages/sign_up_page.dart';
import 'generated/l10n.dart';
import 'services/auth/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: false,
      splitScreenMode: false,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Locale('ar'),
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
          home: BottomNavigationBarWidget()),
    );
  }
}
