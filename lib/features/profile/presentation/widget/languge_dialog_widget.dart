import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/state/app_restart_controller.dart';
import '../state_mangement/riverpod.dart';
import 'language_widget.dart';

class LanguageDialog extends ConsumerWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final languageController = ref.read(languageProvider.notifier);
    ref.watch(languageProvider);

    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LanguageWidget(
            language: "العربية",
            value: "ar",
            languageGroupValue: Localizations.localeOf(context).languageCode,
            onPressed: () async {
              const newLanguage = 'ar';
              await languageController.changeLanguage(newLanguage);
              AppRestartController.restartApp(context);
            },
          ),
          6.h.verticalSpace,
          LanguageWidget(
            language: "English",
            value: "en",
            languageGroupValue: Localizations.localeOf(context).languageCode,
            onPressed: () async {
              const newLanguage = 'en';
              await languageController.changeLanguage(newLanguage);
              AppRestartController.restartApp(context);
            },
          ),
        ],
      ),
    );
  }
}
