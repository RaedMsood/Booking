import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../../../properties/cities/data/model/city_model.dart';
import '../../../properties/cities/presentation/riverpod/cities_riverpod.dart';
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
  final VoidCallback? onSuccess;

  const EditProfilePage({super.key, this.onSuccess});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  bool _bootstrapping = true;

  ProviderSubscription<DateTime?>? _birthSub;
  ProviderSubscription<dynamic>? _genderSub;
  ProviderSubscription<CityModel?>? _citySub;

  @override
  void initState() {
    super.initState();

    nameController.text = Auth().name;
    emailController.text = Auth().email;

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
              gender: initialGender,
              birthDate: initialBirth,
              city: initialCity,
            ),
          );

      _birthSub = ref.listenManual<DateTime?>(
        updateBirthDateProvider,
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
  }

  @override
  void dispose() {
    _birthSub?.close();
    _genderSub?.close();
    _citySub?.close();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _onFormChanged() {
    if (_bootstrapping) return;

    final current = ProfileModel(
      name: nameController.text,
      email: emailController.text,
      gender: ref.read(updateGenderProvider),
      birthDate: ref.read(updateBirthDateProvider),
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
      appBar: const SecondaryAppBarWidget(title: ''),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                6.h.verticalSpace,
                UserPageTitlesWidget(
                  title: S.of(context).editPersonalInfoTitle,
                  subTitle: S.of(context).editPersonalInfoSubtitle,
                ),
                12.verticalSpace,
                NameEmailPhoneSection(
                  nameController: nameController,
                  emailController: emailController,
                ),
                12.h.verticalSpace,
                const UpdateBirthDatePickerWidget(),
                12.h.verticalSpace,
                UpdateGenderWidget(
                  selectedGenderFromProfile: ref.watch(updateGenderProvider),
                  onChanged: (_) => _onFormChanged(),
                ),
                const CityWidget(),
                18.h.verticalSpace,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ButtonBottomNavigationBarDesignWidget(
        child: CheckStateInPostApiDataWidget(
          state: stateUpdateUser,
          messageSuccess: S.of(context).profileUpdatedSuccess,
          functionSuccess: () {
            final latest = ProfileModel(
              name: nameController.text,
              email: emailController.text,
              gender: ref.read(updateGenderProvider),
              birthDate: ref.read(updateBirthDateProvider),
              city: ref.read(selectedCityProvider),
            );
            Auth().updateUserData(
              birthDay: ref.read(updateBirthDateProvider).toString(),
              email: emailController.text,
              name: nameController.text,
              gender: ref.read(updateGenderProvider),
              city: ref.read(selectedCityProvider),
            );
            ref.read(editProfileControllerProvider.notifier).initialize(latest);
            widget.onSuccess?.call();
          },
          bottonWidget: Opacity(
            opacity: canSave ? 1 : 0.4,
            child: DefaultButtonWidget(
              text: S.of(context).saveChanges,
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
                        gender: ref.read(updateGenderProvider),
                        birthDate: ref.read(updateBirthDateProvider),
                        city: ref.read(selectedCityProvider),
                      );

                      controller.compute(current);
                      final effective = controller.effectiveForPut(current);
                      await ref.read(updateNotifierProvider.notifier).update(
                            dateOfBirth: effective.birthDate,
                            email: effective.email,
                            name: effective.name,
                            gender: (effective.gender ?? '').toString(),
                            cityId: effective.city?.id ?? 0,
                          );
                    },
            ),
          ),
        ),
      ),
    );
  }
}
