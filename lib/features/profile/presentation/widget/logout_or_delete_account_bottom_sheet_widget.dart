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

class LogoutOrDeleteAccountBottomSheetWidget extends ConsumerWidget {
  final VoidCallback? onSuccess;
  final bool deleteAccount;

  const LogoutOrDeleteAccountBottomSheetWidget({
    super.key,
    this.onSuccess,
    this.deleteAccount = false,
  });

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
            deleteAccount ? AppIcons.trash : AppIcons.logOut,
            width: 40.w,
            color: Colors.redAccent.withValues(alpha: .9),
          ),
          10.h.verticalSpace,
          AutoSizeTextWidget(
            text: deleteAccount
                ? S.of(context).deleteAccount
                : S.of(context).signOut,
            fontSize: 14.6.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: deleteAccount
                ? S.of(context).deleteAccountConfirmation
                : S.of(context).logoutConfirmation,
            colorText: AppColors.fontColor,
            fontSize: 11.4.sp,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          18.h.verticalSpace,
          DefaultButtonWidget(
            text: S.of(context).cancel,
            height: 38.h,
            background: Colors.redAccent.withValues(alpha: .9),
            borderRadius: 16.sp,
            textSize: 12.sp,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          10.h.verticalSpace,
          CheckStateInPostApiDataWidget(
            state: state,
            messageSuccess: deleteAccount
                ? S.of(context).accountDeletedSuccess
                : S.of(context).logoutSuccessfully,
            functionSuccess: () {
              Auth().logout();
              Navigator.of(context).pop();
              onSuccess?.call();
            },
            bottonWidget: DefaultButtonWidget(
              text: deleteAccount
                  ? S.of(context).deleteAccount
                  : S.of(context).signOut,
              height: 38.h,
              borderRadius: 16.sp,
              textSize: 11.8.sp,
              background: Colors.transparent,
              textColor: Colors.black87,
              border: Border.all(color: Colors.black12),
              isLoading: state.stateData == States.loading,
              onPressed: () {
                if (deleteAccount) {
                  ref.read(logoutProvider.notifier).deleteAccount();
                } else {
                  ref.read(logoutProvider.notifier).logout();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
