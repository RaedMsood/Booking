import 'package:booking/features/booking/presentation/widget/section_card_in_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'info_item_in_confrim_booking_card_widget.dart';
import 'status_badge_in_details_widget.dart';

class ConfirmBookingCard extends StatelessWidget {
  final String bookingId;
  final String bookingDateString;
  final String status;

  const ConfirmBookingCard({
    super.key,
    required this.bookingId,
    required this.bookingDateString,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCardInDetailsWidget(
      title: 'تأكيد الحجز',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoItemInConfrimBookingCardWidget(
            title: 'رقم الحجز',
            icon: Icons.copy,
            text: bookingId,
            onTap: () {
              Clipboard.setData(ClipboardData(text: bookingId));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم نسخ رقم الطلب')),
              );
            },
          ),
          10.verticalSpace,
          InfoItemInConfrimBookingCardWidget(
            title: 'تاريخ الحجز',
            text: bookingDateString,
          ),
          10.verticalSpace,
          StatusBadgeInDetailsWidget(
            status: status,
          ),
        ],
      ),
    );
  }
}
