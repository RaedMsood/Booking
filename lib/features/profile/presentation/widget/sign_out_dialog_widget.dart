import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../state_mangement/riverpod.dart';

class SignOutDialog extends ConsumerWidget {
  final VoidCallback? onLogoutSuccess;

  const SignOutDialog({super.key,this.onLogoutSuccess});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(logoutProvider);
    return Container(
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.r),
          topRight: Radius.circular(14.r),
        ),
        gradient: LinearGradient(
          colors: [
            AppColors.secondarySwatch.shade100,
            AppColors.secondarySwatch.shade50,
            AppColors.whiteColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          8.h.verticalSpace,
          SvgPicture.asset(
            AppIcons.logOut,
            width: 40.w,
          ),
          10.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).signOut,
            fontSize: 14.6.sp,
            // colorText: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          8.h.verticalSpace,
          // S.of(context).doYouReallyWantToSignOut
          AutoSizeTextWidget(
            text:
                "هل تريد حقا تسجيل الخروج. سيتوجب عليك تسجيل الدخول مرة أخرى للوصول إلى بياناتك",
            colorText: AppColors.fontColor,
            fontSize: 11.4.sp,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          18.h.verticalSpace,

          DefaultButtonWidget(
            text: S.of(context).cancel,
            height: 38.h,
            background: const Color(0xffFF4D4F),
            borderRadius: 16.sp,
            textSize: 12.sp,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          10.h.verticalSpace,
          CheckStateInPostApiDataWidget(
            state: state,
            messageSuccess: S.of(context).logoutSuccessfully,
            functionSuccess: () {
              Auth().logout();
              Navigator.of(context).pop();
              onLogoutSuccess?.call();
            },
            bottonWidget: DefaultButtonWidget(
              text: S.of(context).signOut,
              height: 38.h,
              borderRadius: 16.sp,
              textSize: 12.sp,
              background: Colors.transparent,
              textColor: Colors.black,
              border: Border.all(color: Colors.black12),
              isLoading: state.stateData == States.loading,
              onPressed: () {
                ref.read(logoutProvider.notifier).logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
