import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../widget/languge_dialog_widget.dart';
import '../widget/sign_out_dialog_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).generalSettings),
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
                  text: S.of(context).language,
                  colorText: const Color(0xff001A33),
                  fontSize: 11.sp,
                ),
                trailing: AutoSizeTextWidget(
                  text: 'العربية',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w300,
                  colorText: const Color(0xff605A65),
                ),
                onTap: () {
                  showModalBottomSheetWidget(
                    context: context,
                    page: const LanguageDialog(),
                  );
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                leading: SvgPicture.asset(
                  AppIcons.logOut,
                ),
                title: AutoSizeTextWidget(
                  text: S.of(context).signOut,
                  fontSize: 11.sp,
                  colorText: const Color(0xffFF4D4F),
                ),
                trailing: SvgPicture.asset(
                  AppIcons.arrowLeft,
                  color: const Color(0xffFF4D4F),
                  height: 16.h,
                ),
                onTap: () {
                  showModalBottomSheetWidget(
                    context: context,
                    page: const SignOutDialog(),
                  );
                },
              ),
              // ListTile(
              //   contentPadding: EdgeInsets.symmetric(
              //     horizontal: 16.w,
              //   ),
              //   leading: SvgPicture.asset(
              //     AppIcons.trash,
              //     height: 18.h,
              //   ),
              //   title: AutoSizeTextWidget(
              //     text: S.of(context).deleteAccount,
              //     fontSize: 11.sp,
              //     colorText: Color(0xff001A33),
              //   ),
              //   trailing: SvgPicture.asset(
              //     AppIcons.arrowLeft,
              //     height: 16.h,
              //   ),
              //   onTap: () {
              //     // TODO: نفّذ حذف الحساب
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
