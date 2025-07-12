import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/text_form_field.dart';


class SearchAndFilterDesignWidget extends StatelessWidget {
  SearchAndFilterDesignWidget({super.key});

  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        children: [
          Expanded(
            child: TextFormFieldWidget(
              controller: phoneNumberController,
              type: TextInputType.text,
              hintText: "البحث عن الفنادق",
            ),
          ),

          8.w.horizontalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: SvgPicture.asset(AppIcons.filter),
          ),
        ],
      ),
    );
  }
}

