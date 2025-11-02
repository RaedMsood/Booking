import 'package:booking/core/helpers/navigateTo.dart';
import 'package:booking/features/user/presentation/pages/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../widget/languge_dialog_widget.dart';
import '../widget/sign_out_dialog_widget.dart';
import '../widget/tile_widget.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback? onLogoutSuccess;

  const SettingsPage({super.key, this.onLogoutSuccess});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).generalSettings),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 14.h,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Material(
                color: Colors.white,
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  dense: true,
                  horizontalTitleGap: 10.w,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 12.w),
                  leading: SvgPicture.asset(
                    AppIcons.translate,
                  ),
                  title: AutoSizeTextWidget(
                    text: S.of(context).language,
                    colorText: const Color(0xff001A33),
                    fontSize: 11.sp,
                  ),
                  trailing: AutoSizeTextWidget(
                    text: Directionality.of(context) == TextDirection.rtl
                        ? 'العربية'
                        : 'English',
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
              ),
            ),
            Visibility(
              visible: Auth().loggedIn,
              replacement: InkWell(
                onTap: (){
                  navigateTo(context, const LogInPage());
                },
                child: Container(
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeTextWidget(
                    text: S.of(context).logIn,
                    colorText: AppColors.primaryColor,
                    fontSize: 12.sp,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              child: TileWidget(
                icon: AppIcons.logOut,
                title: S.of(context).signOut,
                context: context,
                color: const Color(0xffFF4D4F),
                onTap: () {
                  showModalBottomSheetWidget(
                    context: context,
                    backgroundColor: Colors.transparent,
                    page: SignOutDialog(onLogoutSuccess: () {
                      _refresh();
                      widget.onLogoutSuccess?.call();
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
