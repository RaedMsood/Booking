import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
import 'counter_row_widget.dart';

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
  int _selectedNights = 0;
  bool _isCalendarVisible = false;

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

  int _clampNights(int nights, {DateTime? start}) {
    final normalizedLastDay = _dateOnly(_lastDay);
    final maxNights = start == null
        ? normalizedLastDay.difference(_today).inDays + 1
        : normalizedLastDay.difference(_dateOnly(start)).inDays + 1;

    if (maxNights <= 0) return 1;
    if (nights < 1) return 1;
    if (nights > maxNights) return maxNights;
    return nights;
  }

  DateTime _rangeEndFor(DateTime start, int nights) {
    return _dateOnly(start).add(Duration(days: nights - 1));
  }

  void _applyManualRange(
    DateTime start,
    DateTime end, {
    DateTime? focusedDay,
  }) {
    final normalizedStart = _dateOnly(start);
    final normalizedEnd = _dateOnly(end);
    final calculatedNights =
        normalizedEnd.difference(normalizedStart).inDays + 1;
    final effectiveNights = _clampNights(
      calculatedNights,
      start: normalizedStart,
    );

    setState(() {
      _rangeStart = normalizedStart;
      _rangeEnd = _rangeEndFor(normalizedStart, effectiveNights);
      _selectedNights = effectiveNights;
      _focusedDay = _dateOnly(focusedDay ?? end);
    });

    _emitSelection();
  }

  void _emitSelection() {
    if (_rangeStart == null || _rangeEnd == null) {
      widget.onRangeSelected(null, null);
      return;
    }

    widget.onRangeSelected(
      _rangeStart,
      _dateOnly(_rangeEnd!).add(const Duration(days: 1)),
    );
  }

  void _selectStartDate(DateTime day, {DateTime? focusedDay}) {
    final normalizedStart = _dateOnly(day);
    final effectiveNights = _clampNights(_selectedNights, start: normalizedStart);
    final normalizedEnd = _rangeEndFor(normalizedStart, effectiveNights);

    setState(() {
      _rangeStart = normalizedStart;
      _rangeEnd = normalizedEnd;
      _selectedNights = effectiveNights;
      _focusedDay = _dateOnly(focusedDay ?? day);
    });

    _emitSelection();
  }

  void _changeNights(int delta) {
    final nextNights = _clampNights(
      _selectedNights + delta,
      start: _rangeStart,
    );

    if (nextNights == _selectedNights) return;

    setState(() {
      if (!_isCalendarVisible && delta > 0) {
        _isCalendarVisible = true;
      }
      _selectedNights = nextNights;
      if (_rangeStart != null) {
        _rangeEnd = _rangeEndFor(_rangeStart!, _selectedNights);
      }
    });

    if (_rangeStart != null) {
      _emitSelection();
    }
  }

  void _showCalendar() {
    if (_isCalendarVisible) return;

    setState(() {
      _isCalendarVisible = true;
    });
  }

  void _resetSelection() {
    setState(() {
      _rangeStart = null;
      _rangeEnd = null;
      _selectedNights = 1;
      _isCalendarVisible = false;
    });

    widget.onRangeSelected(null, null);
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
    final selectionPreview = _selectionPreview();
    final showCalendar = _isCalendarVisible || selectionPreview != null;

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
                  Row(
                    children: [
                      Expanded(
                        child: AutoSizeTextWidget(
                          text: S.of(context).yourBookingDate,
                          fontWeight: FontWeight.w500,
                          fontSize: 9.5.sp,
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        child: selectionPreview == null
                            ? const SizedBox.shrink()
                            : Tooltip(
                                key: const ValueKey('calendar-reset-button'),
                                message: S.of(context).calendarClear,
                                child: Semantics(
                                  button: true,
                                  label: S.of(context).calendarClear,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12.r),
                                      onTap: _resetSelection,
                                      child: Ink(
                                        width: 34.w,
                                        height: 34.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          border: Border.all(
                                            color: AppColors.primaryColor
                                                .withValues(alpha: 0.14),
                                          ),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              AppColors.primaryColor
                                                  .withValues(alpha: 0.09),
                                              AppColors.primaryColor
                                                  .withValues(alpha: 0.03),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primaryColor
                                                  .withValues(alpha: 0.08),
                                              blurRadius: 10,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.restart_alt_rounded,
                                            size: 16.sp,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                 // 6.verticalSpace,
                  // AutoSizeTextWidget(
                  //   text: _selectionHint(),
                  //   fontSize: 8.7.sp,
                  //   colorText: AppColors.fontColor2,
                  //   maxLines: 2,
                  // ),
                  if (selectionPreview != null) ...[
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
                        text: selectionPreview,
                        fontSize: 8.8.sp,
                        colorText: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                        maxLines: 2,
                      ),
                    ),
                  ],
                  12.verticalSpace,
                  CounterRowWidget(
                    label: S.of(context).nights,
                    count: _selectedNights,
                    countSuffix: S.of(context).nights,
                    onIncrement: () => _changeNights(1),
                    onDecrement: () => _changeNights(-1),
                  ),
                  6.verticalSpace,
                  AnimatedSize(
                    duration: const Duration(milliseconds: 260),
                    curve: Curves.easeInOutCubic,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      child: showCalendar
                          ? Column(
                              key: const ValueKey('booking-calendar-visible'),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                10.verticalSpace,
                                AutoSizeTextWidget(
                                  text:
                                      'اختر تاريخ الدخول، ثم يمكنك الضغط على تاريخ لاحق لتحديث عدد الليالي تلقائياً',
                                  fontSize: 8.3.sp,
                                  colorText: AppColors.fontColor2,
                                  maxLines: 2,
                                ),
                                14.verticalSpace,
                                Row(
                                  children: [
                                    AutoSizeTextWidget(
                                      text: DateFormat.yMMMM('ar')
                                          .format(_focusedDay),
                                      fontSize: 11.5.sp,
                                      fontWeight: FontWeight.w300,
                                      colorText: const Color(0xff757575),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        _calendarPageController?.previousPage(
                                          duration:
                                              const Duration(milliseconds: 250),
                                          curve: Curves.easeOut,
                                        );
                                      },
                                      child: const Icon(
                                        Icons.chevron_left,
                                        color: Color(0xff757575),
                                      ),
                                    ),
                                    20.horizontalSpace,
                                    GestureDetector(
                                      onTap: () {
                                        _calendarPageController?.nextPage(
                                          duration:
                                              const Duration(milliseconds: 250),
                                          curve: Curves.easeOut,
                                        );
                                      },
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
                                  firstDay: _minMonthStart,
                                  lastDay: _lastDay,
                                  focusedDay: _focusedDay,
                                  onCalendarCreated: (controller) {
                                    _calendarPageController = controller;
                                  },
                                  rangeSelectionMode:
                                      RangeSelectionMode.toggledOn,
                                  rangeStartDay: _rangeStart,
                                  rangeEndDay: _rangeEnd,
                                  selectedDayPredicate: (day) {
                                    return _rangeStart != null &&
                                        _rangeEnd != null &&
                                        isSameDay(_rangeStart, _rangeEnd) &&
                                        isSameDay(day, _rangeStart);
                                  },
                                  enabledDayPredicate: (day) {
                                    final d =
                                        DateTime(day.year, day.month, day.day);
                                    return !d.isBefore(_today);
                                  },
                                  onDaySelected: (selectedDay, focusedDay) {
                                    final normalizedSelectedDay =
                                        _dateOnly(selectedDay);
                                    if (normalizedSelectedDay.isBefore(_today)) {
                                      return;
                                    }

                                    if (_rangeStart != null &&
                                        normalizedSelectedDay
                                            .isAfter(_rangeStart!)) {
                                      _applyManualRange(
                                        _rangeStart!,
                                        normalizedSelectedDay,
                                        focusedDay: focusedDay,
                                      );
                                      return;
                                    }

                                    _selectStartDate(
                                      normalizedSelectedDay,
                                      focusedDay: focusedDay,
                                    );
                                  },
                                  headerVisible: false,
                                  daysOfWeekHeight: 14.h,
                                  calendarBuilders: CalendarBuilders(
                                    disabledBuilder:
                                        (context, day, focusedDay) {
                                      return Center(
                                        child: Text(
                                          '${day.day}',
                                          style: TextStyle(
                                            fontSize: 8.sp,
                                            color: const Color(0xFFBDBDBD),
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationThickness: 0.8,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  daysOfWeekStyle: DaysOfWeekStyle(
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
                                    rangeStartTextStyle: TextStyle(
                                      fontSize: 8.sp,
                                      color: Colors.white,
                                    ),
                                    rangeEndTextStyle: TextStyle(
                                      fontSize: 8.sp,
                                      color: Colors.white,
                                    ),
                                    defaultTextStyle:
                                        TextStyle(fontSize: 8.sp),
                                    outsideTextStyle:
                                        TextStyle(fontSize: 8.sp),
                                    weekendTextStyle:
                                        TextStyle(fontSize: 8.sp),
                                    todayTextStyle:
                                        TextStyle(fontSize: 8.sp),
                                    selectedTextStyle: TextStyle(
                                      fontSize: 8.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    selectedDecoration: const BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    withinRangeTextStyle: TextStyle(
                                      fontSize: 8.sp,
                                      color: Colors.white,
                                    ),
                                    holidayTextStyle:
                                        TextStyle(fontSize: 8.sp),
                                    rangeStartDecoration:
                                        const BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    rangeEndDecoration: const BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                    todayDecoration: BoxDecoration(
                                      color: AppColors.primaryColor
                                          .withValues(alpha: 0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    withinRangeDecoration: BoxDecoration(
                                      color: AppColors.primaryColor
                                          .withValues(alpha: 0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    rangeHighlightColor: AppColors.primaryColor
                                        .withValues(alpha: 0.1),
                                  ),
                                ),
                              ],
                            )
                          : Semantics(
                              key: const ValueKey('booking-calendar-hidden'),
                              button: true,
                              label: 'إظهار التقويم',
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(14.r),
                                    onTap: _showCalendar,
                                    child: Ink(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 12.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor
                                            .withValues(alpha: 0.045),
                                        borderRadius:
                                            BorderRadius.circular(14.r),
                                        border: Border.all(
                                          color: AppColors.primaryColor
                                              .withValues(alpha: 0.09),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 32.w,
                                            height: 32.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor
                                                  .withValues(alpha: 0.08),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Icon(
                                              Icons.calendar_month_rounded,
                                              size: 16.sp,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          10.horizontalSpace,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeTextWidget(
                                                  text: 'اضغط لإظهار التقويم',
                                                  fontSize: 8.6.sp,
                                                  fontWeight: FontWeight.w500,
                                                  colorText:
                                                      AppColors.primaryColor,
                                                  maxLines: 1,
                                                ),
                                                2.verticalSpace,
                                                AutoSizeTextWidget(
                                                  text:
                                                      'أو زد عدد الليالي وسيظهر تلقائياً بكل سلاسة',
                                                  fontSize: 7.7.sp,
                                                  colorText:
                                                      AppColors.fontColor2,
                                                  maxLines: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          8.horizontalSpace,
                                          Container(
                                            width: 28.w,
                                            height: 28.h,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(9.r),
                                              border: Border.all(
                                                color: AppColors.primaryColor
                                                    .withValues(alpha: 0.08),
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 15.sp,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
