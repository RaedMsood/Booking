import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../services/auth/auth.dart';
import '../../../map/presentation/riverpod/map_riverpod.dart';
import '../../../map/presentation/widgets/city_widget.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/birth_date_picker_widget.dart';
import '../widgets/design_to_log_in_and_sign_up_widget.dart';
import '../widgets/gender_selection_widget.dart';
import '../widgets/name_and_email_widget.dart';
import '../widgets/user_page_titles_widget.dart';
import 'verify_code_page.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(checkOTPProvider);
    var signUpState = ref.watch(signUpProvider);
    final birthDate = ref.watch(birthDateProvider);
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: DesignToLogInAndSignUpWidget(
        widget: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 64.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                24.h.verticalSpace,
                const UserPageTitlesWidget(
                  title: "إنشاء حساب",
                  subTitle: "إنشاء حسابك الآن لتبدأ رحلتك",
                ),
                NameAndEmailWidget(
                  name: _nameController,
                  email: _emailController,
                ),
                const BirthDatePickerWidget(),
                12.h.verticalSpace,
                const GenderPickerWidget(),
                const CityWidget(),
                20.h.verticalSpace,
                CheckStateInPostApiDataWidget(
                  state: signUpState,
                  hasMessageSuccess: false,
                  functionSuccess: () {
                    Auth().login(signUpState.data);

                    navigateTo(context, Hello());
                  },
                  bottonWidget: DefaultButtonWidget(
                    text: "إنشاء حساب",
                    isLoading: signUpState.stateData == States.loading,
                    onPressed: () {
                      final isValid = formKey.currentState!.validate();
                      final selectedCity = ref.read(selectedCityProvider);

                      bool hasError = false;
                      if (selectedCity == null) {
                        ref.read(selectedCityErrorProvider.notifier).state =
                            "يرجى اختيار المحافظة";
                        hasError = true;
                      } else {
                        ref.read(selectedCityErrorProvider.notifier).state =
                            null;
                      }

                      if (!isValid || hasError) return;

                      FocusManager.instance.primaryFocus?.unfocus();

                      final selectedGender = ref.read(genderProvider);

                      ref.read(signUpProvider.notifier).logInOrSignUp(
                            phoneNumber: state.data.user.phoneNumber,
                            name: _nameController.text,
                            email: _emailController.text,
                            gender: selectedGender.toString(),
                            cityId: selectedCity!.id,
                            dateOfBirth: birthDate,
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
