import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class DayCellWidget extends StatelessWidget {
  final DateTime date;
  final DateTime today;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final ValueChanged<DateTime> onTap;

  const DayCellWidget({
    super.key,
    required this.date,
    required this.today,
    this.rangeStart,
    this.rangeEnd,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final int day = date.day;
    final bool disabled = date.isBefore(today);
    final bool start = rangeStart != null && date.isAtSameMomentAs(rangeStart!);
    final bool end = rangeEnd != null && date.isAtSameMomentAs(rangeEnd!);
    final bool between = rangeStart != null &&
        rangeEnd != null &&
        date.isAfter(rangeStart!) &&
        date.isBefore(rangeEnd!);
    final bool isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    BoxDecoration? decoration;
    TextDecoration? strike = disabled ? TextDecoration.lineThrough : null;
    Color textColor =
        disabled ? AppColors.fontColor.withValues(alpha:.5) : Colors.black87;

    if (start || end) {
      decoration = const BoxDecoration(
          color: AppColors.primaryColor, shape: BoxShape.circle);
      textColor = Colors.white;
      strike = null;
    } else if (between) {
      decoration = BoxDecoration(
        color: Colors.blue.withValues(alpha:0.1),
        shape: BoxShape.circle,
      );
    } else if (isToday) {
      decoration = BoxDecoration(
        border: Border.all(color: Colors.blue.withValues(alpha:0.2)),
        shape: BoxShape.circle,
      );
    }

    return GestureDetector(
      onTap: disabled ? null : () => onTap(date),
      child: Container(
        decoration: decoration,
        child: Center(
          child: Text(
            '$day',
            style: TextStyle(
              color: textColor,
              decoration: strike,
              decorationColor: AppColors.fontColor,
            ),
          ),
        ),
      ),
    );
  }
}
