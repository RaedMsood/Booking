import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';

class InfoBookingInDetailsWidget extends StatelessWidget {
  final IconData? icon;
  final String text;
  final String title;


  const InfoBookingInDetailsWidget({
    Key? key,
    this.icon,
    required this.text,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(icon, size: 14, color: const Color(0xff605A65)),
        4.horizontalSpace,
        AutoSizeTextWidget(
          text: title,
          fontSize: 10,
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
