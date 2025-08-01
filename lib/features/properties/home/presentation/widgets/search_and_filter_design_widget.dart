import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../riverpod/home_riverpod.dart';

class SearchAndFilterDesignWidget extends StatelessWidget {
  final SearchAndFilterPropertiesNotifier controller;

  const SearchAndFilterDesignWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormFieldWidget(
            controller: controller.searchController,
            type: TextInputType.text,
            hintText: "البحث عن فندق",
            onChanged: (value) {
              controller.search();
            },
          ),
        ),
        10.w.horizontalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: SvgPicture.asset(AppIcons.filter),
        ),
      ],
    );
  }
}
