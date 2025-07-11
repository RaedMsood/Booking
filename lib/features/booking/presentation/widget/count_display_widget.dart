import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';

class CountDisplayWidget extends StatelessWidget {
  final int count;

  const CountDisplayWidget({super.key, required this.count});

  @override
  Widget build(BuildContext context) => Container(
    height: 40.h,
    decoration: BoxDecoration(
      color: const Color(0xFFF2F2F2),
      borderRadius: BorderRadius.circular(8),
    ),
    alignment: Alignment.center,
    child: AutoSizeTextWidget(
      text: '$count',
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );
}