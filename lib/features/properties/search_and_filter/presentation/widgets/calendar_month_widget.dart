import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import 'day_cell_widget.dart';

class CalendarMonthWidget extends StatelessWidget {
  final DateTime month;
  final DateTime today;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final ValueChanged<DateTime> onDayTap;

  const CalendarMonthWidget({
    super.key,
    required this.month,
    required this.today,
    this.rangeStart,
    this.rangeEnd,
    required this.onDayTap,
  });

  String getMonthLabel(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat.yMMMM(locale).format(month);
  }

  List<DateTime?> generateMonthGrid() {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final offset = firstDay.weekday % 7; // الأحد→0
    return [
      for (var i = 0; i < offset; i++) null,
      for (var d = 1; d <= daysInMonth; d++)
        DateTime(month.year, month.month, d),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final grid = generateMonthGrid();
    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: getMonthLabel(context),
            fontSize: 13.sp,
          ),
          8.h.verticalSpace,
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: grid.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 4,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (_, index) {
              final date = grid[index];
              return date == null
                  ? const SizedBox.shrink()
                  : DayCellWidget(
                      date: date,
                      today: today,
                      rangeStart: rangeStart,
                      rangeEnd: rangeEnd,
                      onTap: onDayTap,
                    );
            },
          ),
        ],
      ),
    );
  }
}
