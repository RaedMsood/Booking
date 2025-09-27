import 'package:booking/core/helpers/navigateTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/text_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../pages/filter_page.dart';
import '../riverpod/search_and_filter_riverpod.dart';

class SearchAndFilterWidget extends StatelessWidget {
  final SearchAndFilterPropertiesNotifier controller;

  const SearchAndFilterWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormFieldWidget(
            controller: controller.searchController,
            type: TextInputType.text,
            hintText: S.of(context).searchHotelPlaceholder,
            onChanged: (value) {
              controller.search();
            },
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
