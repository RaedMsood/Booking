import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/constants/app_icons.dart';

class NameEmailPhoneSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  const NameEmailPhoneSection({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: S.of(context).fullName,
          fontSize: 11.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        TextFormFieldWidget(
          controller: nameController,
          hintText: S.of(context).fullNamePlaceholder,
          fieldValidator: (value) {
            if (value == null || value.trim().isEmpty) {
              return S.of(context).nameRequired;
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
          text: S.of(context).phoneNumber,
          fontSize: 11.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        TextFormFieldWidget(
          controller: phoneController,
          type: TextInputType.phone,
          maxLength: 9,
          enable: false,
          buildCounter: false,
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
            child: SvgPicture.asset(AppIcons.phone, height: 14.h),
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
          text: S.of(context).emailOptional,
          fontSize: 11.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        TextFormFieldWidget(
          controller: emailController,
          hintText: S.of(context).emailPlaceholder,
          type: TextInputType.emailAddress,
          fieldValidator: (value) {
            final email = value?.trim() ?? '';
            if (email.isEmpty) return null;
            final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegex.hasMatch(email)) {
              return S.of(context).invalidEmail;
            }
            return null;
          },
          prefix: Padding(
            padding: EdgeInsets.all(11.sp),
            child:
                Icon(Icons.email, size: 20.sp, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}
