import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../services/app_update/app_update_service.dart';

class ForceUpdatePage extends StatefulWidget {
  const ForceUpdatePage({
    super.key,
    required this.updateInfo,
  });

  final AppUpdateInfo updateInfo;

  @override
  State<ForceUpdatePage> createState() => _ForceUpdatePageState();
}

class _ForceUpdatePageState extends State<ForceUpdatePage> {
  bool _isOpeningStore = false;

  bool get _isArabic => Localizations.localeOf(context).languageCode == 'ar';

  String get _title =>
      _isArabic ? 'يتوفر تحديث جديد للتطبيق' : 'A new app update is available';

  String get _description => _isArabic
      ? 'للإستمرار في استخدام التطبيق يجب تحديثه إلى الإصدار ${widget.updateInfo.minVersion} أو أحدث.'
      : 'To continue using the app, you must update to version ${widget.updateInfo.minVersion} or later.';

  String get _currentVersionText => _isArabic
      ? 'الإصدار الحالي: ${widget.updateInfo.currentVersion}'
      : 'Current version: ${widget.updateInfo.currentVersion}';

  String get _storeHint => Platform.isIOS
      ? (_isArabic ? 'سيتم تحويلك إلى App Store' : 'You will be redirected to the App Store')
      : (_isArabic ? 'سيتم تحويلك إلى Google Play' : 'You will be redirected to Google Play');

  String get _updateNowText => _isArabic ? 'تحديث الآن' : 'Update now';

  String get _storeErrorText => _isArabic
      ? 'تعذر فتح المتجر تلقائياً. يرجى الانتقال إلى المتجر وتحديث التطبيق للمتابعة.'
      : 'Unable to open the store automatically. Please go to the store and update the app to continue.';

  Future<void> _openStore() async {
    if (_isOpeningStore) return;

    setState(() {
      _isOpeningStore = true;
    });

    final opened = await AppUpdateService.I.openStore(
      packageName: widget.updateInfo.packageName,
      allowImmediateAndroidUpdate: false,
    );

    if (!mounted) return;

    setState(() {
      _isOpeningStore = false;
    });

    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _storeErrorText,
            textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  AppImages.logo,
                  width: 110.w,
                  height: 110.w,
                ),
                24.h.verticalSpace,
                AutoSizeTextWidget(
                  text: _title,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  colorText: AppColors.mainColorFont,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  maxFontSize: 22,
                  minFontSize: 14,
                ),
                14.h.verticalSpace,
                AutoSizeTextWidget(
                  text: _description,
                  fontSize: 13.sp,
                  colorText: AppColors.greyColor,
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  maxFontSize: 18,
                  minFontSize: 11,
                ),
                10.h.verticalSpace,
                AutoSizeTextWidget(
                  text: _currentVersionText,
                  fontSize: 11.6.sp,
                  colorText: AppColors.fontColor,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                8.h.verticalSpace,
                AutoSizeTextWidget(
                  text: _storeHint,
                  fontSize: 11.2.sp,
                  colorText: AppColors.fontColor2,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                const Spacer(),
                DefaultButtonWidget(
                  text: _updateNowText,
                  height: 46.h,
                  borderRadius: 12.r,
                  onPressed: _openStore,
                  isLoading: _isOpeningStore,
                ),
                12.h.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}


