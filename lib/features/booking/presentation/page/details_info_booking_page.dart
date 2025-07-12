import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../widget/booking_data_card_widget.dart';
import '../widget/confrim_booking_card_widget.dart';
import '../widget/hotel_summary_card_widget.dart';
import '../widget/policy_tile_widget.dart';

class BookingDetailPage extends StatelessWidget {
  final String hotelName;
  final String hotelLocation;
  final String hotelImageUrl;
  final String bookingId;
  final DateTime bookingDate;
  final String bookingStatusLabel;
  final Color bookingStatusColor;
  final int adults;
  final int children;
  final DateTime startDate;
  final DateTime endDate;
  final VoidCallback? onViewFacilityDetails;
  final VoidCallback? onPolicyTap;

  const BookingDetailPage({
    Key? key,
    required this.hotelName,
    required this.hotelLocation,
    required this.hotelImageUrl,
    required this.bookingId,
    required this.bookingDate,
    required this.bookingStatusLabel,
    required this.bookingStatusColor,
    required this.adults,
    required this.children,
    required this.startDate,
    required this.endDate,
    this.onViewFacilityDetails,
    this.onPolicyTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // لتنسيق التاريخ
    final dateFmt = DateFormat('yyyy-MM-dd');
    final timeFmt = DateFormat('HH:mm');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const AutoSizeTextWidget(
          text: 'تفاصيل الحجز',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HotelSummaryCard(
              name: hotelName,
              location: hotelLocation,
              imageUrl: hotelImageUrl,
            ),

            SizedBox(height: 16.h),

            ConfirmBookingCard(
              bookingId: bookingId,
              bookingDateString:
                  '${timeFmt.format(bookingDate)} - ${dateFmt.format(bookingDate)}',
              statusLabel: bookingStatusLabel,
              statusColor: bookingStatusColor,
            ),

            SizedBox(height: 16.h),

            BookingDataCard(
              adults: adults,
              children: children,
              startDateString: dateFmt.format(startDate),
              endDateString: dateFmt.format(endDate),
            ),

            SizedBox(height: 16.h),

            PolicyTileWidget(
              title: 'سياسة الشراء والالغاء',
              onTap: onPolicyTap,
            ),

            SizedBox(height: 24.h),

            // 5. زر عرض تفاصيل المنشأة
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              child: DefaultButtonWidget(text: "استعراض تفاصيل المنشأة"),
            ),

          ],
        ),
      ),
    );
  }
}



