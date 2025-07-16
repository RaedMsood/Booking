import 'package:booking/features/booking/presentation/widget/section_card_in_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../page/details_info_booking_page.dart';
import 'booking_status_widget.dart';
import 'info_item_in_confrim_booking_card_widget.dart';
import 'status_badge_in_details_widget.dart';

class ConfirmBookingCard extends StatelessWidget {
  final String bookingId;
  final String bookingDateString;
  final String statusLabel;
  final Color statusColor;

  const ConfirmBookingCard({
    super.key,
    required this.bookingId,
    required this.bookingDateString,
    required this.statusLabel,
    required this.statusColor,
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
            title:  'رقم الطلب',
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
            title:  'تاريخ الطلب',

            text: bookingDateString,
          ),
          10.verticalSpace,
          StatusBadgeInDetailsWidget(
            label: statusLabel,
            backgroundColor: statusColor.withOpacity(0.1),
            textColor: statusColor,
          ),
        ],
      ),
    );
  }
}
