import 'package:booking/core/theme/app_colors.dart';
import 'package:booking/core/widgets/auto_size_text_widget.dart';
import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../generated/l10n.dart';
import 'calendar_sheet_body_widget.dart';

Future<DateTimeRange?> showCalendarRangePickerBottomSheet(
  BuildContext context, {
  DateTimeRange? initialRange,
}) =>
    showModalBottomSheet<DateTimeRange?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => SafeArea(
        top: false,
        child: CalendarRangePickerSheetWidget(
          initialRange: initialRange,
        ),
      ),
    );

class CalendarRangePickerSheetWidget extends StatefulWidget {
  final DateTimeRange? initialRange;

  const CalendarRangePickerSheetWidget({
    super.key,
    this.initialRange,
  });

  @override
  State<CalendarRangePickerSheetWidget> createState() =>
      _CalendarRangePickerSheetWidgetState();
}

class _CalendarRangePickerSheetWidgetState extends State<CalendarRangePickerSheetWidget> {
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late final DateTime _today;

  @override
  void initState() {
    super.initState();
    // نحفظ اليوم عند منتصف الليل حتى لا يُعتبر قبل اليوم نفسه
    final now = DateTime.now();
    _today = DateTime(now.year, now.month, now.day);

    if (widget.initialRange != null) {
      _rangeStart = widget.initialRange!.start;
      _rangeEnd = widget.initialRange!.end;
    }
  }

  bool get _canConfirm => _rangeStart != null && _rangeEnd != null;

  void _onDayTap(DateTime date) {
    if (date.isBefore(_today)) return; // لا نسمح بأيام قبل اليوم
    setState(() {
      if (_rangeStart == null || _rangeEnd != null) {
        // نبدأ اختيار جديد
        _rangeStart = date;
        _rangeEnd = null;
      } else {
        // نحدد النهاية أو نصحح البداية
        if (date.isBefore(_rangeStart!)) {
          _rangeStart = date;
        } else {
          _rangeEnd = date;
        }
      }
    });
  }

  String _formatRangeText() {
    if (_rangeStart == null) return '';
    final locale = Localizations.localeOf(context).toString();
    final dFmt = DateFormat.d(locale);
    final mFmt = DateFormat.MMMM(locale);

    final start = _rangeStart!;
    final end = _rangeEnd ?? _rangeStart!;
    final nights = (_rangeEnd != null) ? end.difference(start).inDays : 0;

    final startText = '${dFmt.format(start)} ${mFmt.format(start)}';
    final endText = '${dFmt.format(end)} ${mFmt.format(end)}';

    return _rangeEnd == null
        ? '${S.of(context).from} $startText'
        : '$startText - $endText (${nights.toString()} ${S.of(context).nights})';
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (_, scrollController) => Material(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CalendarSheetBodyWidget(
              scrollController: scrollController,
              today: _today,
              onDayTap: _onDayTap,
              rangeEnd: _rangeEnd,
              rangeStart: _rangeStart,
            ),
            Container(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greySwatch.shade100,
                    blurRadius: 10,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Column(
                children: [
                  if (_rangeStart != null)
                    AutoSizeTextWidget(
                      text: _formatRangeText(),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  const SizedBox(height: 12),
                  DefaultButtonWidget(
                    text: S.of(context).confirm,
                    borderRadius: 8.r,
                    height: 40.h,
                    background: _canConfirm
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withValues(alpha:.3),
                    onPressed: _canConfirm
                        ? () => Navigator.pop(
                              context,
                              DateTimeRange(
                                  start: _rangeStart!, end: _rangeEnd!),
                            )
                        : null,
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
