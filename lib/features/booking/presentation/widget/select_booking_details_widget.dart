import 'package:booking/features/booking/presentation/widget/select_filed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import 'counter_row_widget.dart';

class SelectBookingDetailsWidget extends StatefulWidget {
  const SelectBookingDetailsWidget({super.key,required this.onTypeSelected,required this.countRoom,required this.countAdult,required this.countChild});
  final void Function(String? type) onTypeSelected;
  final void Function(int? room) countRoom;
  final void Function(int? adult) countAdult;
  final void Function(int? child) countChild;

  @override
  State<SelectBookingDetailsWidget> createState() =>
      _BookingDetailsSectionState();
}

class _BookingDetailsSectionState extends State<SelectBookingDetailsWidget> {
  String _purpose = 'ترفيه';
  int _rooms = 1, _adults = 1, _children = 1;

  void _showOptionsSheet({
    required String title,
    required List<String> options,
    required String current,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((opt) {
            final selected = opt == current;
            return ListTile(
              title: Center(
                child: AutoSizeTextWidget(
                  text: opt,
                  fontSize: 12,
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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: "بيانات الاشخاص في الحجز",
            fontSize: 8.sp,
            fontWeight: FontWeight.w500,
            colorText: Color(0xff001A33),
          ),
          16.verticalSpace,
          SelectFieldWidget(
            label: 'الغرض من الحجز',
            value: _purpose,
            onTap: () => _showOptionsSheet(
              title: 'الغرض من الحجز',
              options: ['ترفية', 'عمل'],
              current: _purpose,
              onSelected: (v) {
                setState(() {
                _purpose = v;
              });
                widget.onTypeSelected(_purpose);

              },
            ),
          ),
         // const SizedBox(height: 12),
          // SelectFieldWidget(
          //   label: 'نوع الأشخاص',
          //   value: _personType,
          //   onTap: () => _showOptionsSheet(
          //     title: 'نوع الأشخاص',
          //     options: ['شباب', 'عائلات', 'أصدقاء', 'زوجين'],
          //     current: _personType,
          //     onSelected: (v) => setState(() => _personType = v),
          //   ),
          // ),
          const SizedBox(height: 16),
          CounterRowWidget(
            label: 'عدد الغرف',
            count: _rooms,
            onIncrement: () {
              setState(() => _rooms++);
              widget.countRoom(_rooms);
            },
            onDecrement: () {
              if (_rooms > 1) setState(() => _rooms--);
              widget.countRoom(_rooms);
            },
          ),
          const SizedBox(height: 12),
          CounterRowWidget(
            label: 'كبار',
            count: _adults,
            onIncrement: () {
              setState(() => _adults++);
              widget.countAdult(_adults);

            },
            onDecrement: () {
              if (_adults > 1) setState(() => _adults--);
              widget.countAdult(_adults);

            },
          ),
          const SizedBox(height: 12),
          CounterRowWidget(
            label: 'اطفال',
            count: _children,
            onIncrement: () {
              setState(() => _children++);
              widget.countChild(_children);

            },
            onDecrement: () {
              if (_children > 0) setState(() => _children--);
              widget.countChild(_children);

            },
          ),
        ],
      ),
    );
  }
}
