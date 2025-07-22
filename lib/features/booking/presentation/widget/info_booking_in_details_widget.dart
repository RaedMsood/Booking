import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class InfoBookingInDetailsWidget extends StatelessWidget {
  final String? icon;
  final String text;
  final String title;

  const InfoBookingInDetailsWidget(
      {Key? key, this.icon, required this.text, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SvgPicture.asset(icon!, color: const Color(0xff605A65),width: 18.w,height: 18.h,),
        8.horizontalSpace,
        AutoSizeTextWidget(
          text: title,
          fontSize: 9.sp,
          colorText: const Color(0xff605A65),
          fontWeight: FontWeight.w500,
        ),
        const Spacer(),
        AutoSizeTextWidget(
          text: text,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          colorText: const Color(0xff292D32),
        ),
      ],
    );
  }
}
