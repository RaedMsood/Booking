import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';

class RatingBadge extends StatelessWidget {
  final int rating;
  const RatingBadge({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
      decoration: BoxDecoration(
        color: Color(0xffFFF3CD),
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeTextWidget(
            text: '$rating',
            fontSize: 8,
            colorText: Color(0xffFFA500),
          ),
          const Icon(Icons.star, size: 10, color: Color(0xffFFA500)),

        ],
      ),
    );
  }
}