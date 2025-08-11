import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../services/auth/auth.dart';
import '../../../properties/cities/data/model/city_model.dart';
import '../../../properties/cities/presentation/riverpod/cities_riverpod.dart';
import '../../../user/presentation/widgets/birth_date_picker_widget.dart';
import '../../../user/presentation/widgets/user_page_titles_widget.dart';
import '../../data/model/profile_model.dart';
import '../widget/name_email_phone_widget.dart';
import '../widget/update_birth_day_widget.dart';
import '../widget/update_gender_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../properties/cities/presentation/widget/city_widget.dart';
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

  bool _bootstrapping = true;

  ProviderSubscription<DateTime?>? _birthSub;
  ProviderSubscription<dynamic>? _genderSub;
  ProviderSubscription<CityModel?>? _citySub;

  @override
  void initState() {
    super.initState();

    nameController.text = Auth().name;
    emailController.text = Auth().email;
    phoneController.text = Auth().phoneNumber;

    final initialGender = Auth().gender;
    final initialCity = Auth().city;
    final initialBirth = DateTime.tryParse(Auth().date ?? '');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(updateGenderProvider.notifier).state = initialGender;
      ref.read(updateBirthDateProvider.notifier).state = initialBirth;
      ref.read(selectedCityProvider.notifier).state = initialCity;

      ref.read(editProfileControllerProvider.notifier).initialize(
            ProfileModel(
              name: nameController.text,
              email: emailController.text,
              phoneNumber: phoneController.text,
              gender: initialGender,
              birthDate: initialBirth,
              city: initialCity,
            ),
          );

      _birthSub = ref.listenManual<DateTime?>(
        birthDateProvider,
        (prev, next) => _onFormChanged(),
      );
      _genderSub = ref.listenManual<dynamic>(
        updateGenderProvider,
        (prev, next) => _onFormChanged(),
      );
      _citySub = ref.listenManual<CityModel?>(
        selectedCityProvider,
        (prev, next) => _onFormChanged(),
      );

      _bootstrapping = false;
      _onFormChanged();
    });

    nameController.addListener(_onFormChanged);
    emailController.addListener(_onFormChanged);
    phoneController.addListener(_onFormChanged);
  }

  @override
  void dispose() {
    _birthSub?.close();
    _genderSub?.close();
    _citySub?.close();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _onFormChanged() {
    if (_bootstrapping) return;

    final current = ProfileModel(
      name: nameController.text,
      email: emailController.text,
      phoneNumber: phoneController.text,
      gender: ref.read(updateGenderProvider),
      birthDate: ref.read(birthDateProvider),
      city: ref.read(selectedCityProvider),
    );

    ref.read(editProfileControllerProvider.notifier).compute(current);
  }

  @override
  Widget build(BuildContext context) {
    final changes = ref.watch(editProfileControllerProvider);
    final stateUpdateUser = ref.watch(updateNotifierProvider);
    final canSave = changes.hasAny;

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
              NameEmailPhoneSection(
                nameController: nameController,
                phoneController: phoneController,
                emailController: emailController,
              ),
              12.h.verticalSpace,
              UpdateBirthDatePickerWidget(onChanged: (_) => _onFormChanged()),
              12.h.verticalSpace,
              UpdateGenderWidget(
                selectedGenderFromProfile: ref.watch(updateGenderProvider),
                onChanged: (_) => _onFormChanged(),
              ),
              const CityWidget(),
              24.h.verticalSpace,
              CheckStateInPostApiDataWidget(
                state: stateUpdateUser,
                messageSuccess: "تم التعديل بنجاح",
                functionSuccess: () {
                  final latest = ProfileModel(
                    name: nameController.text,
                    email: emailController.text,
                    phoneNumber: phoneController.text,
                    gender: ref.read(updateGenderProvider),
                    birthDate: ref.read(birthDateProvider),
                    city: ref.read(selectedCityProvider),
                  );
                  Auth().updateUserData(
                    // birthDate: ref.read(birthDateProvider),
                    email: emailController.text,
                    phoneNumber: phoneController.text,
                    name: nameController.text,
                    gender: ref.read(updateGenderProvider),
                    city: ref.read(selectedCityProvider),
                  );
                  ref
                      .read(editProfileControllerProvider.notifier)
                      .initialize(latest);
                },
                bottonWidget: DefaultButtonWidget(
                  text: "حفظ التعديلات",
                  isLoading: stateUpdateUser.stateData == States.loading,
                  onPressed: !canSave
                      ? null
                      : () async {
                          if (!_formKey.currentState!.validate()) return;
                          FocusManager.instance.primaryFocus?.unfocus();

                          final controller =
                              ref.read(editProfileControllerProvider.notifier);

                          final current = ProfileModel(
                            name: nameController.text,
                            email: emailController.text,
                            phoneNumber: phoneController.text,
                            gender: ref.read(updateGenderProvider),
                            birthDate: ref.read(birthDateProvider),
                            city: ref.read(selectedCityProvider),
                          );

                          controller.compute(current);
                          final effective = controller.effectiveForPut(current);
                          await ref
                              .read(updateNotifierProvider.notifier)
                              .update(
                                //dateOfBirth: effective.birthDate?.toIso8601String() ?? '',
                                email: effective.email,
                                phoneNumber: effective.phoneNumber,
                                name: effective.name,
                                gender: (effective.gender ?? '').toString(),
                                cityId: effective.city?.id ?? 0,
                              );
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
