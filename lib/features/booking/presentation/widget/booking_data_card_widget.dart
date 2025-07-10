import 'package:booking/features/booking/presentation/widget/section_card_in_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../page/details_info_booking_page.dart';
import 'info_booking_in_details_widget.dart';

class BookingDataCard extends StatelessWidget {
  final int adults;
  final int children;
  final String startDateString;
  final String endDateString;

  const BookingDataCard({
    Key? key,
    required this.adults,
    required this.children,
    required this.startDateString,
    required this.endDateString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionCardInDetailsWidget(
      title: 'بيانات الحجز',
      child: Column(
        children: [
          InfoBookingInDetailsWidget(
            title: 'عدد البالغين',
            icon: Icons.people,
            text: '$adults',
          ),
          SizedBox(height: 9.h),
          InfoBookingInDetailsWidget(
            icon: Icons.child_care,
            text: '$children',
            title: 'عدد الأطفال',
          ),
          SizedBox(height: 9.h),
          InfoBookingInDetailsWidget(

            icon: Icons.calendar_today,
            text: startDateString,
            title: 'تاريخ بداية الحجز',
          ),
          SizedBox(height: 9.h),
          InfoBookingInDetailsWidget(
            icon: Icons.calendar_today,
            text: endDateString,
            title: 'تاريخ نهاية الحجز',
          ),
        ],
      ),
    );
  }
}
