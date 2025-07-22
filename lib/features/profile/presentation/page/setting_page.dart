import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AutoSizeTextWidget(
          text: 'إعدادات التطبيق',
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                leading: SvgPicture.asset(
                  AppIcons.translate,
                ),
                title: AutoSizeTextWidget(
                  text: 'اللغة',
                  colorText: Color(0xff001A33),
                  fontSize: 11.sp,
                ),
                trailing: AutoSizeTextWidget(
                  text: 'العربية',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w300,
                  colorText: Color(0xff605A65),
                ),
                onTap: () {
                  // TODO: افتح اختيار اللغة
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                leading: SvgPicture.asset(
                  AppIcons.currency,
                ),
                title: AutoSizeTextWidget(
                  text: 'العملة',
                  colorText: Color(0xff001A33),
                  fontSize: 11.sp,
                ),
                trailing: AutoSizeTextWidget(
                  text: 'ريال يمني قديم',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w300,
                  colorText: Color(0xff605A65),
                ),
                onTap: () {
                  // TODO: افتح اختيار العملة
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                leading: SvgPicture.asset(
                  AppIcons.logOut,
                ),
                title: AutoSizeTextWidget(
                  text: 'تسجيل الخروج',
                  fontSize: 11.sp,
                  colorText: Color(0xffFF4D4F),
                ),
                trailing: SvgPicture.asset(
                  AppIcons.arrowLeft,
                  color: Color(0xffFF4D4F),
                  height: 16.h,
                ),
                onTap: () {
                  // TODO: نفّذ تسجيل الخروج
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                leading: SvgPicture.asset(
                  AppIcons.trash,
                  height: 18.h,
                ),
                title: AutoSizeTextWidget(
                  text: 'حذف الحساب بشكل نهائي',
                  fontSize: 11.sp,
                  colorText: Color(0xff001A33),
                ),
                trailing: SvgPicture.asset(
                  AppIcons.arrowLeft,
                  height: 16.h,
                ),
                onTap: () {
                  // TODO: نفّذ حذف الحساب
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
