import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class RangeCalendarWidget extends StatefulWidget {
  const RangeCalendarWidget({super.key, required this.onRangeSelected});

  final void Function(DateTime? start, DateTime? end) onRangeSelected;

  @override
  State<RangeCalendarWidget> createState() => _RangeCalendarScreenState();
}

class _RangeCalendarScreenState extends State<RangeCalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart, _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 10.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AutoSizeTextWidget(
                    text: "تاريخ حجزك",
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                  10.verticalSpace,
                  // رأس الشهر والسنة مع الأسهم
                  Row(
                    children: [
                      AutoSizeTextWidget(
                        text: DateFormat.yMMMM('ar').format(_focusedDay),
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        colorText: const Color(0xff757575),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => setState(() {
                          _focusedDay = DateTime(
                              _focusedDay.year, _focusedDay.month - 1, 1);
                        }),
                        child: const Icon(
                          Icons.chevron_left,
                          color: Color(0xff757575),
                        ),
                      ),
                      20.horizontalSpace,
                      GestureDetector(
                        onTap: () => setState(() {
                          _focusedDay = DateTime(
                              _focusedDay.year, _focusedDay.month + 1, 1);
                        }),
                        child: const Icon(
                          Icons.chevron_right,
                          color: Color(0xff757575),
                        ),
                      ),
                    ],
                  ),
                  24.verticalSpace,
                  TableCalendar(
                    locale: 'ar',
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    // تفعيل اختيار المدى دفعة واحدة
                    rangeSelectionMode: RangeSelectionMode.enforced,
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,
                    onRangeSelected: (start, end, focused) {
                      setState(() {
                        _rangeStart = start;
                        _rangeEnd = end;
                        _focusedDay = focused;
                      });
                      // نمرّر التاريخين للوالد
                      widget.onRangeSelected(_rangeStart, _rangeEnd);
                    },

                    headerVisible: false,
                    daysOfWeekHeight: 14,
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                          color: Color(0xff333333)),
                      weekendStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                          color: Color(0xff333333)),
                    ),
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: true,
                      rangeStartTextStyle:
                          const TextStyle(fontSize: 10, color: Colors.white),
                      rangeEndTextStyle:
                          const TextStyle(fontSize: 10, color: Colors.white),
                      defaultTextStyle: const TextStyle(
                        fontSize: 10,
                      ),
                      outsideTextStyle: const TextStyle(
                        fontSize: 10, // حجم نص أيام الشهر الأساسية
                      ),
                      weekendTextStyle: const TextStyle(
                        fontSize: 10, // حجم نص عطلة نهاية الأسبوع داخل الشهر
                      ),
                      todayTextStyle: const TextStyle(
                        fontSize: 10, // حجم نص اليوم الحالي
                      ),
                      selectedTextStyle: const TextStyle(
                        fontSize: 10, // حجم نص اليوم المحدّد
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      withinRangeTextStyle: const TextStyle(
                        fontSize: 10, // حجم نصّ الأيام بين البداية والنهاية
                        color: Colors.white,
                      ),
                      holidayTextStyle: const TextStyle(
                        fontSize: 10,
                      ),
                      rangeStartDecoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      rangeEndDecoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      withinRangeDecoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      rangeHighlightColor:
                          AppColors.primaryColor.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
