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

/// الصفحة الرئيسية
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
            // 1. ملخص الفندق
            HotelSummaryCard(
              name: hotelName,
              location: hotelLocation,
              imageUrl: hotelImageUrl,
            ),

            SizedBox(height: 16.h),

            // 2. تأكيد الحجز
            ConfirmBookingCard(
              bookingId: bookingId,
              bookingDateString:
                  '${timeFmt.format(bookingDate)} - ${dateFmt.format(bookingDate)}',
              statusLabel: bookingStatusLabel,
              statusColor: bookingStatusColor,
            ),

            SizedBox(height: 16.h),

            // 3. بيانات الحجز
            BookingDataCard(
              adults: adults,
              children: children,
              startDateString: dateFmt.format(startDate),
              endDateString: dateFmt.format(endDate),
            ),

            SizedBox(height: 16.h),

            // 4. سياسة الشراء والإلغاء
            PolicyTile(
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


/// 4. تودجت سطر في الـ SectionCard
/// بطاقة عامة بكل Section: عنوان + محتوى

/// شارة حالة بأي لون
class StatusBadgeInDetailsWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadgeInDetailsWidget({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AutoSizeTextWidget(
          text: 'حالة الطلب',
          fontSize: 10,
          colorText: Color(0xff605A65),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: AutoSizeTextWidget(
            text: label,
            fontSize: 10,
            colorText: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// 5. التاج قابل للفتح (سياسة الشراء والإلغاء)
class PolicyTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const PolicyTile({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            Spacer(),

            const Icon(Icons.add, size: 20),
          ],
        ),
      ),
    );
  }
}

