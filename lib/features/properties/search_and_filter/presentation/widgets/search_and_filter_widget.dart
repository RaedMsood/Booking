import 'package:booking/core/helpers/navigateTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../pages/filter_page.dart';

class SearchAndFilterWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onChanged;

  const SearchAndFilterWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormFieldWidget(
            controller: controller,
            type: TextInputType.text,
            hintText: hintText,
            onChanged: onChanged,
          ),
        ),
        10.w.horizontalSpace,
        InkWell(
          onTap: (){
            navigateTo(context, const FilterPage());
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
             child: SvgPicture.asset(AppIcons.filter),
          ),
        ),
      ],
    );
  }
}
