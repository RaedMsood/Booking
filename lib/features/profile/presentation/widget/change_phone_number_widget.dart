import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../services/auth/auth.dart';
import '../../../user/presentation/widgets/phone_country_selector_button_widget.dart';
import '../../../user/presentation/widgets/user_country_picker_helper.dart';
import '../state_mangement/riverpod.dart';
import 'verify_phone_change_widget.dart';

class ChangePhoneNumberWidget extends ConsumerStatefulWidget {
  final VoidCallback? phoneNumberOnSuccess;

  const ChangePhoneNumberWidget({super.key, this.phoneNumberOnSuccess});

  @override
  ConsumerState<ChangePhoneNumberWidget> createState() =>
      _ChangePhoneNumberWidgetState();
}

class _ChangePhoneNumberWidgetState
    extends ConsumerState<ChangePhoneNumberWidget> {
  TextEditingController phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String _selectedCountryDialCode = '967';
  String _selectedCountryFlag = '🇾🇪';

  bool get _isNonYemeniNumber => _selectedCountryDialCode != '967';

  String get _normalizedPhoneNumber =>
      phoneNumberController.text.replaceAll(RegExp(r'\D'), '');

  String get _completePhoneNumber =>
      '+$_selectedCountryDialCode$_normalizedPhoneNumber';

  void _showCountryPicker() {
    UserCountryPickerHelper.show(
      context: context,
      onSelected: (selection) {
        setState(() {
          _selectedCountryDialCode = selection.dialCode;
          _selectedCountryFlag = selection.flagEmoji;
        });
      },
    );
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(changePhoneNumberProvider);
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeTextWidget(
              text: S.of(context).phoneNumberCurrent,
              fontSize: 10.2.sp,
              colorText: AppColors.mainColorFont,
            ),
            6.h.verticalSpace,
            Container(
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.scaffoldColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.phone,
                    height: 17.h,
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  10.w.horizontalSpace,
                  AutoSizeTextWidget(
                    text: Auth().phoneNumber,
                    fontSize: 12.6.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            12.h.verticalSpace,
            AutoSizeTextWidget(
              text: S.of(context).phoneNumberNew,
              fontSize: 10.2.sp,
              colorText: AppColors.mainColorFont,
            ),
            6.h.verticalSpace,
            TextFormFieldWidget(
              controller: phoneNumberController,
              type: TextInputType.phone,
              textAlign: TextAlign.left,
              hintText: S.of(context).phonePlaceholder,
              fillColor: AppColors.scaffoldColor,
              maxLength: 15,
              buildCounter: false,
              fieldValidator: (value) {
                final phone = (value ?? '').replaceAll(RegExp(r'\D'), '');
                if (phone.isEmpty) {
                  return S.of(context).pleaseEnterPhoneNumber;
                }
                if (phone.length < 6 || phone.length > 15) {
                  return 'يرجى إدخال رقم هاتف صحيح';
                }
                return null;
              },
              prefix: Padding(
                padding: EdgeInsets.all(11.5.sp),
                child: SvgPicture.asset(
                  AppIcons.phone,
                  height: 13.h,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              suffixIcon: PhoneCountrySelectorButtonWidget(
                flagEmoji: _selectedCountryFlag,
                dialCode: _selectedCountryDialCode,
                onTap: _showCountryPicker,
              ),
            ),
            if (_isNonYemeniNumber) ...[
              8.h.verticalSpace,
              AutoSizeTextWidget(
                text:
                    'إذا كان الرقم ليس يمنيًا، يرجى إدخال رقم مرتبط بالواتساب الخاص بك لأن رمز التحقق OTP سيصل إليه.',
                fontSize: 9.8.sp,
                colorText: AppColors.fontColor2,
                fontWeight: FontWeight.w400,
                maxLines: 3,
              ),
            ],
            14.h.verticalSpace,
            CheckStateInPostApiDataWidget(
              state: state,
              messageSuccess:
                  "${S.of(context).codeHasBeenSendTo} $_completePhoneNumber",
              functionSuccess: () {
                Navigator.of(context).pop();
                showTitledBottomSheet(
                  title: S.of(context).verificationCode,
                  fontSize: 15.6.sp,
                  context: context,
                  page: VerifyPhoneChangeWidget(
                    phoneNumber: _completePhoneNumber,
                    phoneNumberOnSuccess: widget.phoneNumberOnSuccess,
                  ),
                );
              },
              bottonWidget: DefaultButtonWidget(
                text: S.of(context).confirm,
                isLoading: state.stateData == States.loading,
                onPressed: () {
                  final isValid = formKey.currentState!.validate();
                  if (isValid) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    ref
                        .read(changePhoneNumberProvider.notifier)
                        .changePhoneNumber(
                          phoneNumber: _completePhoneNumber,
                        );
                  }
                },
              ),
            ),
            8.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
