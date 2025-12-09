import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../generated/l10n.dart';
import 'info_booking_in_details_widget.dart';
import 'section_card_in_details_widget.dart';

class BookingDataCardWidget extends StatelessWidget {
  final int adults;
  final int children;
  final String startDateString;
  final String endDateString;

  const BookingDataCardWidget({
    super.key,
    required this.adults,
    required this.children,
    required this.startDateString,
    required this.endDateString,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCardInDetailsWidget(
      title: S.of(context).bookingInfo,
      child: Column(
        children: [
          2.verticalSpace,
          InfoBookingInDetailsWidget(
            title: S.of(context).adultsCount,
            icon: AppIcons.people,
            text: '$adults',
          ),
          SizedBox(height: 9.h),
          InfoBookingInDetailsWidget(
            icon: AppIcons.babyFace,
            text: '$children',
            title: S.of(context).childrenCount,
          ),
          SizedBox(height: 9.h),
          InfoBookingInDetailsWidget(
            icon: AppIcons.date,
            text: startDateString,
            title: S.of(context).checkInDate,
          ),
          SizedBox(height: 9.h),
          InfoBookingInDetailsWidget(
            icon: AppIcons.date,
            text: endDateString,
            title: S.of(context).checkOutDate,
          ),
        ],
      ),
    );
  }
}
