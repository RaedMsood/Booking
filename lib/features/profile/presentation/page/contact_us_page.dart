import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).contactUs),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                leading: SvgPicture.asset(
                  AppIcons.email,
                ),
                title: AutoSizeTextWidget(
                  text: 'support@NOZAL.com',
                  colorText: const Color(0xff001A33),
                  fontSize: 11.sp,
                ),
                trailing: SvgPicture.asset(
                  AppIcons.arrowLeft,
                ),
                onTap: () {
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                leading: SvgPicture.asset(
                  AppIcons.phone,
                ),
                title: AutoSizeTextWidget(
                  text: '775076388',
                  colorText: const Color(0xff001A33),
                  fontSize: 11.sp,
                ),
                trailing: SvgPicture.asset(
                  AppIcons.arrowLeft,
                ),
                onTap: () {},
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                leading: SvgPicture.asset(
                  AppIcons.whatsapp,
                ),
                title: AutoSizeTextWidget(
                  text: '775076388',
                  colorText: const Color(0xff001A33),
                  fontSize: 11.sp,
                ),
                trailing: SvgPicture.asset(
                  AppIcons.arrowLeft,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
