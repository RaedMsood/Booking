import 'package:booking/core/widgets/buttons/icon_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import 'calendar_month_widget.dart';

class CalendarSheetBodyWidget extends StatelessWidget {
  final DateTime today;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final ValueChanged<DateTime> onDayTap;
  final ScrollController scrollController;

  const CalendarSheetBodyWidget({
    super.key,
    required this.today,
    this.rangeStart,
    this.rangeEnd,
    required this.onDayTap,
    required this.scrollController,
  });

  /// 1. يرجع تاريخ أقرب يوم أحد (Sunday) في أو قبل التاريخ المُعطى
  DateTime getBaseSunday(DateTime today) {
    final offset = today.weekday % 7;
    return today.subtract(Duration(days: offset));
  }

  /// 2. يرجع قائمة بأسماء أيام الأسبوع كاملة حسب الـ locale
  List<String> getFullWeekdays(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final df = DateFormat.EEEE(locale);
    final baseSunday = getBaseSunday(DateTime.now());

    return List.generate(
        7, (i) => df.format(baseSunday.add(Duration(days: i))));
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final weekdays = getFullWeekdays(context);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                12.w.horizontalSpace,
                 AutoSizeTextWidget(text: S.of(context).selectDates),
                const Spacer(),
                IconButtonWidget(
                  icon: AppIcons.close,
                  height: 15.h,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          4.h.verticalSpace,
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: weekdays
                  .map((d) => Expanded(
                          child: Center(
                            child: AutoSizeTextWidget(
                              text: d,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              colorText: AppColors.fontColor,
                            ),
                          )))
                  .toList(),
            ),
          ),
          6.h.verticalSpace,
           Divider(height: 12,color:AppColors.fontColor.withValues(alpha:.25) ,),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: 12,
              itemBuilder: (_, idx) {
                final month = DateTime(now.year, now.month + idx, 1);
                return CalendarMonthWidget(
                  month: month,
                  today: today,
                  rangeStart: rangeStart,
                  rangeEnd: rangeEnd,
                  onDayTap: onDayTap,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
