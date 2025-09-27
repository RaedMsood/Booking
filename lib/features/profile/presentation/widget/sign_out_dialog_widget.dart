import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../state_mangement/riverpod.dart';

class SignOutDialog extends ConsumerWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(logoutProvider);
    return Padding(
      padding: EdgeInsets.all(14.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          14.h.verticalSpace,
          SvgPicture.asset(
            AppIcons.logout,
            width: 90.w,
          ),
          16.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).signOut,
            fontSize: 16.sp,
            colorText: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).doYouReallyWantToSignOut,
            colorText: AppColors.fontColor,
            fontSize: 12.5.sp,
            textAlign: TextAlign.center,
          ),
          18.h.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: CheckStateInPostApiDataWidget(
                  state: state,
                  messageSuccess: S.of(context).logoutSuccessfully,
                  functionSuccess: () {
                    Auth().logout();
                    ref.read(activeIndexProvider.notifier).state = 0;
                    navigateAndFinish(
                        context, const BottomNavigationBarWidget());
                  },
                  bottonWidget: DefaultButtonWidget(
                    text: S.of(context).signOut,
                    height: 38.h,
                    borderRadius: 12.sp,
                    textSize: 12.sp,
                    background: Colors.transparent,
                    textColor: AppColors.primaryColor,
                    border: Border.all(color: AppColors.primaryColor),
                    isLoading: state.stateData == States.loading,
                    onPressed: () {
                      ref.read(logoutProvider.notifier).logout();
                    },
                  ),
                ),
              ),
              14.w.horizontalSpace,
              Expanded(
                child: DefaultButtonWidget(
                  text: S.of(context).cancel,
                  height: 38.h,
                  borderRadius: 12.sp,
                  textSize: 12.sp,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
