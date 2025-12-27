import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../profile/presentation/state_mangement/riverpod.dart';

class RangeCalendarWidget extends ConsumerStatefulWidget {
  const RangeCalendarWidget({
    super.key,
    required this.onRangeSelected,
  });

  final void Function(DateTime? start, DateTime? end) onRangeSelected;

  @override
  ConsumerState<RangeCalendarWidget> createState() =>
      _RangeCalendarScreenState();
}

class _RangeCalendarScreenState extends ConsumerState<RangeCalendarWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart, _rangeEnd;

  DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  PageController? _calendarPageController;

  // أصغر شهر مسموح به = بداية الشهر الحالي
  DateTime get _minMonthStart => DateTime(_today.year, _today.month, 1);

  // حد علوي مرن (عدّله لو تحب)
  final DateTime _lastDay = DateTime.utc(2030, 12, 31);

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(languageProvider);

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
                  AutoSizeTextWidget(
                    text: S.of(context).yourBookingDate,
                    fontWeight: FontWeight.w500,
                    fontSize: 9.5.sp,
                  ),
                  10.verticalSpace,

                  // عنوان الشهر مع الأسهم
                  Row(
                    children: [
                      AutoSizeTextWidget(
                        text: DateFormat.yMMMM('$locale').format(_focusedDay),
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w300,
                        colorText: const Color(0xff757575),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          // امنع الرجوع حسب شرطك (مثلاً _atMinMonth) أو اعتمد على firstDay
                          _calendarPageController?.previousPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          );
                        },
                        child: const Icon(Icons.chevron_left,
                            color: Color(0xff757575)),
                      ),
                      20.horizontalSpace,
                      GestureDetector(
                        onTap: () {
                          _calendarPageController?.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOut,
                          );
                        },
                        child: const Icon(Icons.chevron_right,
                            color: Color(0xff757575)),
                      ),
                    ],
                  ),
                  24.verticalSpace,

                  TableCalendar(
                    locale: '$locale',
                    firstDay: _minMonthStart,
                    lastDay: _lastDay,
                    focusedDay: _focusedDay,

                    onCalendarCreated: (controller) {
                      _calendarPageController = controller;
                    },
                    // اختيار مدى (Range)
                    rangeSelectionMode: RangeSelectionMode.enforced,
                    rangeStartDay: _rangeStart,
                    rangeEndDay: _rangeEnd,

                    // منع اختيار الأيام الماضية
                    enabledDayPredicate: (day) {
                      final d = DateTime(day.year, day.month, day.day);
                      return !d.isBefore(_today);
                    },

                    onRangeSelected: (start, end, focused) {
                      // حارس إضافي لو حصلت حالة غريبة من الـ callback
                      if ((start != null && start.isBefore(_today)) ||
                          (end != null && end.isBefore(_today))) {
                        return;
                      }
                      setState(() {
                        _rangeStart = start;
                        _rangeEnd = end;
                        _focusedDay = focused;
                      });
                      widget.onRangeSelected(_rangeStart, _rangeEnd);
                    },

                    headerVisible: false,
                    daysOfWeekHeight: 14.h,

                    // تخصيص شكل الأيام المعطّلة (الماضية) بخط فوق الرقم
                    calendarBuilders: CalendarBuilders(
                      disabledBuilder: (context, day, focusedDay) {
                        return Center(
                          child: Text(
                            '${day.day}',
                            style:  TextStyle(
                              fontSize: 8.sp,
                              color: const Color(0xFFBDBDBD),
                              decoration: TextDecoration.lineThrough,
                              // خط فوق الرقم
                              decorationThickness: 0.8,
                            ),
                          ),
                        );
                      },
                    ),

                    daysOfWeekStyle:  DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 8.sp,
                        color: const Color(0xff333333),
                      ),
                      weekendStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 8.sp,
                        color: const Color(0xff333333),
                      ),
                    ),

                    onPageChanged: (focusedDay) {
                      setState(() => _focusedDay = focusedDay);
                    },
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: true,
                      rangeStartTextStyle:
                           TextStyle(fontSize: 8.sp, color: Colors.white),
                      rangeEndTextStyle:
                           TextStyle(fontSize: 8.sp, color: Colors.white),
                      defaultTextStyle:  TextStyle(fontSize: 8.sp),
                      outsideTextStyle:  TextStyle(fontSize: 8.sp),
                      weekendTextStyle:  TextStyle(fontSize: 8.sp),
                      todayTextStyle:  TextStyle(fontSize: 8.sp),
                      selectedTextStyle:  TextStyle(
                        fontSize: 8.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      withinRangeTextStyle:  TextStyle(
                        fontSize: 8.sp,
                        color: Colors.white,
                      ),
                      holidayTextStyle:  TextStyle(fontSize: 8.sp),
                      rangeStartDecoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      rangeEndDecoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha:0.5),
                        shape: BoxShape.circle,
                      ),
                      withinRangeDecoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha:0.5),
                        shape: BoxShape.circle,
                      ),
                      rangeHighlightColor:
                          AppColors.primaryColor.withValues(alpha:0.1),
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
