import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class HotelSummaryCard extends StatelessWidget {
  final String name;
  final String location;
  final String imageUrl;

  const HotelSummaryCard({
    Key? key,
    required this.name,
    required this.location,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.sp),
                    bottomLeft: Radius.circular(12.sp))),
            child: Image.network(
              imageUrl,
              width: 60.w,
              height: 50.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 90.w,
                height: 60.h,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
          4.horizontalSpace,

          // نص الاسم والموقع
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: name,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
                4.verticalSpace,
                Row(
                  children: [
                     SvgPicture.asset(
                      AppIcons.location,
                      height: 12.h,
                      color: Color(0xff757575),

                    ),
                    2.horizontalSpace,
                    Expanded(
                      child: AutoSizeTextWidget(
                        text: location,
                        fontSize: 9,
                        minFontSize: 7,
                        colorText: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // صورة الفندق
        ],
      ),
    );
  }
}
