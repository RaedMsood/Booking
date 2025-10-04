import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import 'draggable_score_bar_widget.dart';

class RatingRowWidget extends StatelessWidget {
  final String title;
  final double value;
  final ValueChanged<double> onChanged;

  const RatingRowWidget({super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: title,
          fontSize: 11.sp,
          colorText:const Color(0xff605A65),
          fontWeight: FontWeight.w400,
        ),
        SizedBox(height: 8.h),
        DraggableScoreBarWidget(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
