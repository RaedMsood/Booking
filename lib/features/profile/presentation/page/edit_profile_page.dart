import 'package:booking/core/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../../../properties/cities/presentation/riverpod/cities_riverpod.dart';
import '../../../properties/cities/presentation/widget/city_widget.dart';
import '../../../user/presentation/widgets/birth_date_picker_widget.dart';
import '../../../user/presentation/widgets/gender_selection_widget.dart';
import '../../../user/presentation/widgets/user_page_titles_widget.dart';
import '../state_mangement/riverpod.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  dynamic selectedCity;
  dynamic selectedGender;

  dynamic birthDate;

  @override
  void initState() {
    super.initState();
    selectedCity = ref.read(selectedCityProvider);
    selectedGender = ref.read(genderProvider);
    birthDate = ref.read(birthDateProvider);
    nameController.text = Auth().name;
    emailController.text = Auth().email;
    phoneController.text = Auth().phoneNumber;
    selectedGender = Auth().gender;
    birthDate = Auth().date;
    selectedCity = Auth().city;

    // حفظ القيم الأصلية داخل الـ Notifier
    Future.microtask(() {
      ref.read(editProfileProvider.notifier).initialize(
        name: nameController.text,
        email: emailController.text,
        gender: ref.read(genderProvider),
        birthDate: ref.read(birthDateProvider),
        city: ref.read(selectedCityProvider),
      );
    });

    nameController.addListener(_onFormChanged);
    emailController.addListener(_onFormChanged);
  }

  void _onFormChanged() {
    ref.read(editProfileProvider.notifier).checkIfChanged(
      name: nameController.text,
      email: emailController.text,
      gender: ref.read(genderProvider),
      birthDate: ref.read(birthDateProvider),
      city: ref.read(selectedCityProvider),
    );
  }


  @override
  Widget build(BuildContext context) {
    final isChanged = ref.watch(editProfileProvider);
    final stateUpdateUser = ref.watch(updateNotifierProvider);
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 64.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.h.verticalSpace,
              const UserPageTitlesWidget(
                title: "تعديل البيانات الشخصية",
                subTitle: "قم بتحديث معلوماتك الشخصية",
              ),
              12.verticalSpace,
              _buildNameAndEmail(),
              const BirthDatePickerWidget(),
              12.h.verticalSpace,
              const GenderPickerWidget(),
              const CityWidget(),
              24.h.verticalSpace,
              CheckStateInPostApiDataWidget(
                state: stateUpdateUser,
                functionSuccess: (){},
                messageSuccess: "تم التعديل بنجاح",
                bottonWidget: DefaultButtonWidget(
                  text: "حفظ التعديلات",
                  isLoading: stateUpdateUser.stateData==States.loading,
                  onPressed: !isChanged ? () {
                    print("no");
                  } : () {
                    final isValid = _formKey.currentState!.validate();
                    selectedCity = ref.read(selectedCityProvider);

                    bool hasError = false;
                    if (selectedCity == null) {
                      ref
                          .read(selectedCityErrorProvider.notifier)
                          .state =
                      "يرجى اختيار المحافظة";
                      hasError = true;
                    } else {
                      ref
                          .read(selectedCityErrorProvider.notifier)
                          .state = null;
                    }

                    if (!isValid || hasError) return;

                    FocusManager.instance.primaryFocus?.unfocus();

                    selectedGender = ref.read(genderProvider);
                    birthDate = ref.watch(birthDateProvider);
                    ref.read(updateNotifierProvider.notifier).update(
                      dateOfBirth:birthDate ,

                        phoneNumber:phoneController.text, name: nameController.text,
                        gender: selectedGender,
                        cityId: selectedCity.id);
                    print("تعديل البيانات:");
                    print(nameController.text);
                    print(emailController.text);
                    print(selectedGender);
                    print(selectedCity!.id);
                    print(birthDate);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameAndEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: "الاسم",
          fontSize: 11.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        TextFormFieldWidget(
          controller: nameController,
          hintText: "أدخل اسمك الرباعي",
          fieldValidator: (value) {
            if (value == null || value
                .trim()
                .isEmpty) {
              return "الرجاء إدخال الاسم";
            }
            return null;
          },
          prefix: Padding(
            padding: EdgeInsets.all(11.sp),
            child:
            Icon(Icons.person, size: 20.sp, color: AppColors.primaryColor),
          ),
        ),
        12.verticalSpace,
        AutoSizeTextWidget(
          text: S
              .of(context)
              .phoneNumber,
          fontSize: 11.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        TextFormFieldWidget(
          controller: phoneController,
          type: TextInputType.phone,
          maxLength: 9,
          fieldValidator: (value) {
            if (value == null || value
                .toString()
                .isEmpty) {
              return S
                  .of(context)
                  .pleaseEnterYourPhoneNumberOrEmail;
            }
            final phone = value.trim();
            if (!phone.startsWith('7')) {
              return "رقم الهاتف يجب أن يبدأ بـ 7 (اليمن)";
            }
            if (phone.length < 9) {
              return "رقم الهاتف يجب ألا يقل عن 9 أرقام";
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
        12.h.verticalSpace,
        AutoSizeTextWidget(
          text: "البريد الإلكتروني (اختياري)",
          fontSize: 11.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        TextFormFieldWidget(
          controller: emailController,
          hintText: "أدخل بريدك الإلكتروني",
          type: TextInputType.emailAddress,
          fieldValidator: (value) {
            final email = value?.trim() ?? '';
            if (email.isEmpty) return null;
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(email)) {
              return 'الرجاء إدخال بريد إلكتروني صالح';
            }
            return null;
          },
          prefix: Padding(
            padding: EdgeInsets.all(11.sp),
            child:
            Icon(Icons.email, size: 20.sp, color: AppColors.primaryColor),
          ),
        ),
        12.h.verticalSpace,
      ],
    );
  }
}
