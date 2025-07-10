import 'package:booking/core/helpers/flash_bar_helper.dart';
import 'package:booking/core/theme/app_colors.dart';
import 'package:booking/core/widgets/auto_size_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../widget/hotel_summary_card_widget.dart';
import 'details_info_booking_page.dart';

class DetailsOfBookInAddPage extends StatelessWidget {
  const DetailsOfBookInAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RangeCalendarScreen(),
    );
  }
}

class RangeCalendarScreen extends StatefulWidget {
  const RangeCalendarScreen({super.key});

  @override
  State<RangeCalendarScreen> createState() => _RangeCalendarScreenState();
}

class _RangeCalendarScreenState extends State<RangeCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart, _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const AutoSizeTextWidget(
          text: 'حجز الفندق',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HotelSummaryCard(
                name: "فندق ام القرى السياحي",
                location: "هبرة , سعوان",
                imageUrl: '',
              ),
              Container(
                margin: const EdgeInsets.all(16),
                padding: EdgeInsets.symmetric(vertical: 14.sp, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
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
                          colorText: Color(0xff757575),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => setState(() {
                            _focusedDay = DateTime(
                                _focusedDay.year, _focusedDay.month - 1, 1);
                          }),
                          child: Icon(
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
                          child: Icon(
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
                            TextStyle(fontSize: 10, color: Colors.white),
                        rangeEndTextStyle:
                            TextStyle(fontSize: 10, color: Colors.white),
                        defaultTextStyle: TextStyle(
                          fontSize: 10, // حجم نص أيام الشهر الأساسية
                        ),
                        outsideTextStyle: TextStyle(
                          fontSize: 10, // حجم نص أيام الشهر الأساسية
                        ),
                        weekendTextStyle: TextStyle(
                          fontSize: 10, // حجم نص عطلة نهاية الأسبوع داخل الشهر
                        ),
                        todayTextStyle: TextStyle(
                          fontSize: 10, // حجم نص اليوم الحالي
                        ),
                        selectedTextStyle: TextStyle(
                          fontSize: 10, // حجم نص اليوم المحدّد
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        withinRangeTextStyle: TextStyle(
                          fontSize: 10, // حجم نصّ الأيام بين البداية والنهاية
                          color: Colors.white,
                        ),
                        holidayTextStyle: TextStyle(
                          fontSize: 10,
                        ),
                        rangeStartDecoration: BoxDecoration(
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
                        // withinRangeTextStyle: const TextStyle(color: Colors.white),
                      ),
                      // calendarBuilders: CalendarBuilders(
                      //   dowBuilder: (context, day) {
                      //     final text = DateFormat.E('ar').format(day);
                      //     return Center(
                      //       child: AutoSizeTextWidget(
                      //         text: text,
                      //       ),
                      //     );
                      //   },
                      // ),
                    ),
                  ],
                ),
              ),
              BookingDetailsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

/// الحاوية العامة لجزئية الحجز
class BookingSectionContainer extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const BookingSectionContainer({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AutoSizeTextWidget(
            text: title,
            fontSize: 8,
            fontWeight: FontWeight.w500,
            colorText: Color(0xff001A33),
          ),
          16.verticalSpace,
          ...children,
        ],
      ),
    );
  }
}

/// حقل اختيار (dropdown) مخصّص
class SelectField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const SelectField({
    Key? key,
    required this.label,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AutoSizeTextWidget(
              text: label, fontSize: 10, fontWeight: FontWeight.w400),
          const SizedBox(height: 4),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AutoSizeTextWidget(
                        text: value, fontSize: 10, fontWeight: FontWeight.w400),
                  ),
                  const Icon(Icons.keyboard_arrow_left, color: Colors.black54),
                ],
              ),
            ),
          ),
        ],
      );
}

/// صف عدّاد (– + العدد)
class CounterRow extends StatelessWidget {
  final String label;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterRow({
    Key? key,
    required this.label,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(text: label,
            fontSize: 10, fontWeight: FontWeight.w400),
        Row(
          children: [
            Expanded(child: CountDisplay(count: count)),
            8.horizontalSpace,
            CounterButton(icon: Icons.add, onTap: onIncrement),
            8.horizontalSpace,
            CounterButton(icon: Icons.remove, onTap: onDecrement),

          ],
        ),
      ],
    );
  }
}

/// الزرّ الدائري للمعدّل (– أو +)
class CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CounterButton({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(icon,size: 18,),
          onPressed: onTap,
        ),
      );
}

/// عرض العدد الحالي
class CountDisplay extends StatelessWidget {
  final int count;

  const CountDisplay({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(

        height: 40.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: AutoSizeTextWidget(
         text:  '$count',
          fontSize: 12, fontWeight: FontWeight.w400,
        ),
      );
}

/// الكلاس الرئيسي الذي يحافظ على الحالة ويستخدم الكلاسات أعلاه
class BookingDetailsSection extends StatefulWidget {
  const BookingDetailsSection({Key? key}) : super(key: key);

  @override
  State<BookingDetailsSection> createState() => _BookingDetailsSectionState();
}

class _BookingDetailsSectionState extends State<BookingDetailsSection> {
  String _purpose = 'ترفيه';
  String _personType = 'شباب';
  int _rooms = 1, _adults = 1, _children = 1;

  void _showOptionsSheet({
    required String title,
    required List<String> options,
    required String current,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((opt) {
            final selected = opt == current;
            return ListTile(
              title: Center(
                child: Text(
                  opt,
                  style: TextStyle(
                      fontWeight:
                          selected ? FontWeight.bold : FontWeight.normal),
                ),
              ),
              onTap: () {
                onSelected(opt);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BookingSectionContainer(
      title: 'بيانات الأشخاص في الحجز',
      children: [
        SelectField(
          label: 'الغرض من الحجز',
          value: _purpose,
          onTap: () => _showOptionsSheet(
            title: 'الغرض من الحجز',
            options: ['ترفيه', 'عمل', 'عائلة', 'رجال أعمال'],
            current: _purpose,
            onSelected: (v) => setState(() => _purpose = v),
          ),
        ),
        const SizedBox(height: 12),
        SelectField(
          label: 'نوع الأشخاص',
          value: _personType,
          onTap: () => _showOptionsSheet(
            title: 'نوع الأشخاص',
            options: ['شباب', 'عائلات', 'أصدقاء', 'زوجين'],
            current: _personType,
            onSelected: (v) => setState(() => _personType = v),
          ),
        ),
        const SizedBox(height: 16),
        CounterRow(
          label: 'عدد الغرف',
          count: _rooms,
          onIncrement: () => setState(() => _rooms++),
          onDecrement: () {
            if (_rooms > 1) setState(() => _rooms--);
          },
        ),
        const SizedBox(height: 12),
        CounterRow(
          label: 'كبار',
          count: _adults,
          onIncrement: () => setState(() => _adults++),
          onDecrement: () {
            if (_adults > 1) setState(() => _adults--);
          },
        ),
        const SizedBox(height: 12),
        CounterRow(
          label: 'صغار',
          count: _children,
          onIncrement: () => setState(() => _children++),
          onDecrement: () {
            if (_children > 0) setState(() => _children--);
          },
        ),
      ],
    );
  }
}
