import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';

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

  DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  DateTime? get _inclusiveSelectionEnd => _rangeEnd ?? _rangeStart;

  DateTime? get _effectiveCheckout {
    if (_rangeStart == null) return null;
    final inclusiveEnd = _inclusiveSelectionEnd ?? _rangeStart!;
    return _dateOnly(inclusiveEnd).add(const Duration(days: 1));
  }

  int? get _nightCount {
    if (_rangeStart == null || _effectiveCheckout == null) return null;
    return _effectiveCheckout!.difference(_rangeStart!).inDays;
  }


  String? _selectionPreview() {
    if (_rangeStart == null || _effectiveCheckout == null) return null;

    final formatter = DateFormat('d MMMM', 'ar');
    final startText = formatter.format(_rangeStart!);
    final checkoutText = formatter.format(_effectiveCheckout!);
    final nightCountText = _nightCountLabel();

    return nightCountText == null
        ? 'الدخول: $startText  •  المغادرة: $checkoutText'
        : 'الدخول: $startText  •  المغادرة: $checkoutText  •  $nightCountText';
  }

  String? _nightCountLabel() {
    final nights = _nightCount;
    if (nights == null || nights <= 0) return null;

    if (nights == 1) return 'ليلة واحدة';
    if (nights == 2) return 'ليلتان';
    if (nights >= 3 && nights <= 10) return '$nights ليالٍ';
    return '$nights ليلة';
  }

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
                 // 6.verticalSpace,
                  // AutoSizeTextWidget(
                  //   text: _selectionHint(),
                  //   fontSize: 8.7.sp,
                  //   colorText: AppColors.fontColor2,
                  //   maxLines: 2,
                  // ),
                  if (_selectionPreview() != null) ...[
                    8.verticalSpace,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: AutoSizeTextWidget(
                        text: _selectionPreview()!,
                        fontSize: 8.8.sp,
                        colorText: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        maxLines: 2,
                      ),
                    ),
                  ],
                  10.verticalSpace,

                  // عنوان الشهر مع الأسهم
                  Row(
                    children: [
                      AutoSizeTextWidget(
                        text: DateFormat.yMMMM('ar').format(_focusedDay),
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
                    locale: 'ar',
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
                    selectedDayPredicate: (day) {
                      return _rangeStart != null &&
                          _rangeEnd == null &&
                          isSameDay(day, _rangeStart);
                    },

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

                      final normalizedStart = start == null ? null : _dateOnly(start);
                      final normalizedEnd = end == null ? null : _dateOnly(end);

                      setState(() {
                        _rangeStart = normalizedStart;
                        _rangeEnd = normalizedEnd;
                        _focusedDay = focused;
                      });

                      if (normalizedStart == null) {
                        widget.onRangeSelected(null, null);
                        return;
                      }

                      final effectiveCheckout =
                          _dateOnly(normalizedEnd ?? normalizedStart)
                              .add(const Duration(days: 1));
                      widget.onRangeSelected(normalizedStart, effectiveCheckout);
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
                      selectedDecoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
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
