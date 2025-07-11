import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/text_form_field.dart';

class SearchForACityWidget extends StatelessWidget {
  final TextEditingController search;

  final ValueChanged onChanged;

  const SearchForACityWidget({
    super.key,
    required this.search,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: TextFormFieldWidget(
        controller: search,
        type: TextInputType.text,
        hintText: "البحث عن محافظة",
        onChanged: onChanged,
        prefix: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: SvgPicture.asset(
            AppIcons.search,
            height: 14.h,
            color: AppColors.fontColor2,
          ),
        ),
      ),
    );
  }
}
