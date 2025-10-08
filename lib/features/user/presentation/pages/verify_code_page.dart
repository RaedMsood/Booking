import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/resend_code_widget.dart';
import '../widgets/verify_pinput_widget.dart';
import 'sign_up_page.dart';

class VerifyCodePage extends ConsumerWidget {
  final String phoneNumberOrEmail;

  VerifyCodePage({
    super.key,
    required this.phoneNumberOrEmail,
  });

  final formKey = GlobalKey<FormState>();

  TextEditingController verifyController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    var checkOTPState = ref.watch(checkOTPProvider);

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(14.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: S.of(context).verificationCode,
              fontSize: 14.5.sp,
              fontWeight: FontWeight.w600,
            ),
            6.h.verticalSpace,
            AutoSizeTextWidget(
              text: "${S.of(context).codeHasBeenSendTo} $phoneNumberOrEmail",
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              colorText: AppColors.fontColor,
            ),
            24.h.verticalSpace,
            VerifyPinputWidget(
              verifyController: verifyController,
            ),
            24.h.verticalSpace,
            ResendCodeWidget(
              phoneNumberOrEmail: phoneNumberOrEmail,
            ),
            24.h.verticalSpace,
            CheckStateInPostApiDataWidget(
              state: checkOTPState,
              hasMessageSuccess: false,
              functionSuccess: () async {
                if (checkOTPState.data.status == true) {
                  Auth().login(checkOTPState.data);

                  navigateTo(context, const BottomNavigationBarWidget());
                } else {
                  navigateTo(context, const SignUpPage());
                }
              },
              bottonWidget: DefaultButtonWidget(
                text: S.of(context).confirm,
                isLoading: checkOTPState.stateData == States.loading,
                onPressed: () async {
                  final isValid = formKey.currentState!.validate();
                  if (isValid) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    ref.read(checkOTPProvider.notifier).checkOTP(
                          phoneNumber: phoneNumberOrEmail,
                          otp: verifyController.text,
                          deviceToken: await Auth().getFcmToken(),
                        );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


