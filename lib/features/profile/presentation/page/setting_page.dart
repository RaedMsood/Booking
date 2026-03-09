import 'package:booking/core/helpers/navigateTo.dart';
import 'package:booking/features/user/presentation/pages/log_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../state_mangement/currency_riverpod.dart';
import '../widget/change_currency_bottom_sheet.dart';
import '../widget/change_phone_number_widget.dart';
import '../widget/languge_dialog_widget.dart';
import '../widget/logout_or_delete_account_bottom_sheet_widget.dart';
import '../widget/tile_widget.dart';

class SettingsPage extends ConsumerStatefulWidget {
  final VoidCallback? onSuccess;

  const SettingsPage({super.key, this.onSuccess});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var currencyState = ref.watch(currencyProvider);

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
                    showTitledBottomSheet(
                      title: S.of(context).applicationLanguage,
                      context: context,
                      page: const LanguageDialog(),
                    );
                  },
                ),
              ),
            ),
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
                    text: S.of(context).currency,
                    colorText: const Color(0xff001A33),
                    fontSize: 11.sp,
                  ),
                  trailing: AutoSizeTextWidget(
                    text: currencyState.toString(),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w300,
                    colorText: const Color(0xff605A65),
                  ),
                  onTap: () {
                    showTitledBottomSheet(
                      title: S.of(context).changeCurrency,
                      context: context,
                      page: const ChangeCurrencyBottomSheet(),
                    );
                  },
                ),
              ),
            ),

            if(Auth().loggedIn)
            TileWidget(
              icon: AppIcons.phone,
              title: S.of(context).changePhoneNumber,
              context: context,
              fontSize: 10.6.sp,
              heightIcon: 17.h,
              onTap: () {
                showTitledBottomSheet(
                  title: S.of(context).changePhoneNumber,
                  fontSize: 13.sp,
                  context: context,
                  page: ChangePhoneNumberWidget(
                    phoneNumberOnSuccess: () {
                      widget.onSuccess?.call();
                    },
                  ),
                );
              },
            ),
            Visibility(
              visible: Auth().loggedIn,
              replacement: InkWell(
                onTap: () {
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
                    page: LogoutOrDeleteAccountBottomSheetWidget(onSuccess: () {
                      _refresh();
                      widget.onSuccess?.call();
                    }),
                  );
                },
              ),
            ),
            Visibility(
              visible: Auth().loggedIn,
              child: TileWidget(
                icon: AppIcons.trash,
                title: S.of(context).deleteAccount,
                context: context,
                fontSize: 10.6.sp,
                heightIcon: 17.h,
                onTap: () {
                  showModalBottomSheetWidget(
                    context: context,
                    backgroundColor: Colors.transparent,
                    page: LogoutOrDeleteAccountBottomSheetWidget(
                        deleteAccount: true,
                        onSuccess: () {
                          _refresh();
                          widget.onSuccess?.call();
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
