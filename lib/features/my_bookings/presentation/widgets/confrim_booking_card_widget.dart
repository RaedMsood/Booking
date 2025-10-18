import 'package:booking/features/my_bookings/presentation/widgets/section_card_in_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/l10n.dart';
import '../../../booking/presentation/widget/info_item_in_confrim_booking_card_widget.dart';
import 'status_badge_in_details_widget.dart';

class ConfrimBookingCardWidget extends StatelessWidget {
  final String bookingId;
  final String bookingDateString;
  final String status;

  const ConfrimBookingCardWidget({
    super.key,
    required this.bookingId,
    required this.bookingDateString,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SectionCardInDetailsWidget(
      title: S.of(context).bookingConfirmation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoItemInConfrimBookingCardWidget(
            title: S.of(context).bookingCodeLabel,
            icon: Icons.copy,
            text: bookingId,
            onTap: () {
              Clipboard.setData(ClipboardData(text: bookingId));
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(S.of(context).bookingCodeCopied)),
              );
            },
          ),
          10.verticalSpace,
          InfoItemInConfrimBookingCardWidget(
            title: S.of(context).bookingDateLabel,
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
