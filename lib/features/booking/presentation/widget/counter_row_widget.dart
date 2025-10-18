import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import 'count_display_widget.dart';
import 'counter_button_widget.dart';

class CounterRowWidget extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterRowWidget({
    super.key,
    required this.label,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: label,
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
        6.verticalSpace,
        Row(
          children: [
            Expanded(child: CountDisplayWidget(count: count)),
            8.horizontalSpace,
            CounterButtonWidget(icon: Icons.add, onTap: onIncrement),
            8.horizontalSpace,
            CounterButtonWidget(icon: Icons.remove, onTap: onDecrement),
          ],
        ),
      ],
    );
  }
}
