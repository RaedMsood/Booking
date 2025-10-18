import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';

class RatingBookingWidget extends StatelessWidget {
  final int rating;

  const RatingBookingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
      decoration: BoxDecoration(
          color: const Color(0xffFFF3CD).withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.sp),
          border: Border.all(color: const Color(0xffFFA500).withOpacity(0.3))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeTextWidget(
            text: '$rating',
            fontSize: 8,
            colorText: const Color(0xffFFA500),
            textAlign: TextAlign.center,
          ),
          const Icon(Icons.star, size: 10, color: Color(0xffFFA500)),
        ],
      ),
    );
  }
}
