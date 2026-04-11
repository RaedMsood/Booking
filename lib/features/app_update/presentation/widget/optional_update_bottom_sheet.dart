import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../services/app_update/app_update_service.dart';

class OptionalUpdateBottomSheet extends StatefulWidget {
  const OptionalUpdateBottomSheet({
    super.key,
    required this.updateInfo,
  });

  final AppUpdateInfo updateInfo;

  @override
  State<OptionalUpdateBottomSheet> createState() =>
      _OptionalUpdateBottomSheetState();
}

class _OptionalUpdateBottomSheetState extends State<OptionalUpdateBottomSheet> {
  bool _isOpeningStore = false;

  bool get _isArabic => Localizations.localeOf(context).languageCode == 'ar';

  String get _title =>
      _isArabic ? 'يتوفر إصدار أحدث للتطبيق' : 'A newer version is available';

  String get _description => _isArabic
      ? 'يوجد تحديث جديد للإصدار ${widget.updateInfo.latestVersion}. يمكنك التحديث الآن للاستفادة من أحدث التحسينات، أو المتابعة حالياً والتحديث لاحقاً.'
      : 'Version ${widget.updateInfo.latestVersion} is now available. Update now to get the latest improvements, or continue for now and update later.';

  String get _updateNowText => _isArabic ? 'تحديث الآن' : 'Update now';

  String get _laterText => _isArabic ? 'لاحقاً' : 'Later';

  String get _storeErrorText => _isArabic
      ? 'تعذر فتح صفحة التحديث. حاول مرة أخرى.'
      : 'Unable to open the update page. Please try again.';

  Future<void> _updateNow() async {
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

    if (opened) {
      Navigator.of(context).pop(true);
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _storeErrorText,
          textDirection: _isArabic ? TextDirection.rtl : TextDirection.ltr,
        ),
      ),
    );
  }

  void _later() {
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.greySwatch.shade300,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
            18.h.verticalSpace,
            Image.asset(
              AppImages.logo,
              width: 64.w,
              height: 64.w,
            ),
            16.h.verticalSpace,
            AutoSizeTextWidget(
              text: _title,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              colorText: AppColors.mainColorFont,
              textAlign: TextAlign.center,
              maxLines: 2,
              maxFontSize: 20,
              minFontSize: 13,
            ),
            10.h.verticalSpace,
            AutoSizeTextWidget(
              text: _description,
              fontSize: 12.4.sp,
              colorText: AppColors.greyColor,
              textAlign: TextAlign.center,
              maxLines: 4,
              maxFontSize: 16,
              minFontSize: 10,
            ),
            20.h.verticalSpace,
            DefaultButtonWidget(
              text: _updateNowText,
              height: 46.h,
              borderRadius: 12.r,
              onPressed: _updateNow,
              isLoading: _isOpeningStore,
            ),
            10.h.verticalSpace,
            DefaultButtonWidget(
              text: _laterText,
              height: 46.h,
              borderRadius: 12.r,
              background: AppColors.whiteColor,
              textColor: AppColors.mainColorFont,
              border: Border.all(
                color: AppColors.greySwatch.shade300,
              ),
              onPressed: _later,
            ),
          ],
        ),
      ),
    );
  }
}

