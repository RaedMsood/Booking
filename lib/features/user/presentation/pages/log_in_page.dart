import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/continue_with_google_or_facebook_widget.dart';
import '../widgets/design_to_log_in_and_sign_up_widget.dart';
import '../widgets/user_page_titles_widget.dart';
import 'verify_code_page.dart';

class LogInPage extends ConsumerStatefulWidget {
  const LogInPage({super.key});

  @override
  ConsumerState<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends ConsumerState<LogInPage> {
  TextEditingController phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(userProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: DesignToLogInAndSignUpWidget(
          widget: SingleChildScrollView(
            padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 120.h),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserPageTitlesWidget(
                    title: S.of(context).logIn,
                    subTitle: "مرحبًا! مرحبًا بك من جديد، لقد افتقدناك",
                  ),
                  12.h.verticalSpace,
                  AutoSizeTextWidget(
                    text: S.of(context).phoneNumber,
                    fontSize: 11.sp,
                    colorText: Colors.black87,
                  ),
                  6.h.verticalSpace,
                  TextFormFieldWidget(
                    controller: phoneNumberController,
                    type: TextInputType.phone,
                    maxLength: 9,
                    fieldValidator: (value) {
                      if (value == null || value.toString().isEmpty) {
                        return S.of(context).phoneRequired;
                      }
                      final phone = value.trim();
                      if (!phone.startsWith('7')) {
                        return S.of(context).phoneMustStartWith7;
                      }
                      if (phone.length < 9) {
                        return S.of(context).phoneMustBe9Digits;
                      }
                      return null;
                    },
                    prefix: Padding(
                      padding: EdgeInsets.all(11.sp),
                      child: SvgPicture.asset(
                        AppIcons.phone,
                        height: 14.h,
                      ),
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(
                          left: 12.w, right: 12.w, top: 12.h, bottom: 8.h),
                      child: AutoSizeTextWidget(
                        text: "967+",
                        colorText: AppColors.primaryColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  16.h.verticalSpace,
                  CheckStateInPostApiDataWidget(
                    state: state,
                    hasMessageSuccess: false,
                    functionSuccess: () {
                      showTitledBottomSheet(
                          title: S.of(context).verificationCode,
                          fontSize: 14.sp,
                          context: context,
                          page: VerifyCodePage(
                            phoneNumber: phoneNumberController.text,
                          ));
                    },
                    bottonWidget: DefaultButtonWidget(
                      text: S.of(context).logIn,
                      isLoading: state.stateData == States.loading,
                      onPressed: () {
                        final isValid = formKey.currentState!.validate();

                        if (isValid) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          ref.read(userProvider.notifier).logIn(
                                phoneNumber: phoneNumberController.text,
                              );
                        }
                      },
                    ),
                  ),
                  16.h.verticalSpace,

                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: AutoSizeTextWidget(
                        text: S.of(context).continueAsGuest,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        colorText: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  16.h.verticalSpace,

                  /// Class Continue To Google Or Facebook Widget
                  const ContinueWithGoogleOrFacebookWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
