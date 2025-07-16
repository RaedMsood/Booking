import 'package:booking/features/booking/presentation/widget/rating_booking_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'booking_status_widget.dart';
import 'id_booking_with_copy_widget.dart';
import 'image_hotel_widget.dart';
import 'info_hotel_in_booking_card_widget.dart';

class BookingCard extends StatelessWidget {
  final int rating;
  final String bookingId;
  final String statusLabel;
  final Color statusColor;
  final String imageUrl;
  final String title;
  final String locationText;
  final int count;
  final double price;
  final VoidCallback? onCopyBookingId;
  final VoidCallback? onTap;

  const BookingCard({
    Key? key,
    required this.rating,
    required this.bookingId,
    required this.statusLabel,
    required this.statusColor,
    required this.imageUrl,
    required this.title,
    required this.locationText,
    required this.count,
    required this.price,
    this.onCopyBookingId,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.sp),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),


        ),
        child: Column(
          children: [
            // الصف العلوي: الحالة، رقم الحجز، التقييم
            Row(
              children: [
                StatusBadge(
                  label: statusLabel,
                  backgroundColor: Color(0xffFFE2E2),
                  textColor: Color(0xffFFE2E2),
                ),
                SizedBox(width: 8.w),
                BookingIdBadge(
                  bookingId: bookingId,
                  onCopy: onCopyBookingId,
                ),
                Spacer(),
                RatingBadge(rating: rating),
              ],
            ),
            Divider(thickness: 0.5, color: Color(0xffF0F0F0)),
            Row(
              children: [
                HotelImage(imageUrl: imageUrl),
                SizedBox(width: 12.w),
                InfoHotelInCardBookingWidget(
                  title: title,
                  location: locationText,
                  count: count,
                  price: price,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}