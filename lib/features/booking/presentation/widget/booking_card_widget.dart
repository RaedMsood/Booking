import 'package:booking/features/booking/data/booking_model/booking_model.dart';
import 'package:booking/features/booking/presentation/widget/rating_booking_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'booking_status_widget.dart';
import 'id_booking_with_copy_widget.dart';
import 'image_hotel_widget.dart';
import 'info_hotel_in_booking_card_widget.dart';

class BookingCard extends StatelessWidget {
  final BookingData bookData;
  final VoidCallback? onTap;

  const BookingCard({
    super.key,
    required this.bookData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Column(
          children: [
            Row(
              children: [
                StatusBadge(
                  status: bookData.status ?? '',
                ),
                SizedBox(width: 8.w),
                BookingIdBadge(
                  bookingId: '1-2347373',
                  onCopy: () {
                    Clipboard.setData(const ClipboardData(text: '1-2347373'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم نسخ رقم الحجز')),
                    );
                  },
                ),
                const Spacer(),
                const RatingBadge(rating: 4),
              ],
            ),
            const Divider(thickness: 0.5, color: Color(0xffF0F0F0)),
            Row(
              children: [
                HotelImage(imageUrl: bookData.image ?? ''),
                SizedBox(width: 12.w),
                InfoHotelInCardBookingWidget(
                  title: bookData.property ?? '',
                  location:
                      '${bookData.address!.city!} , ${bookData.address!.district!}',
                  count: bookData.guests ?? 1,
                  price: bookData.totalPrice,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
