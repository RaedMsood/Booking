import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/my_bookings_data.dart';
import 'booking_status_widget.dart';
import 'id_booking_with_copy_widget.dart';
import 'hotel_image_widget.dart';
import 'info_hotel_in_booking_card_widget.dart';
import 'rating_booking_widget.dart';

class MyBookingCardWidget extends StatelessWidget {
  final MyBookingsData bookData;
  final VoidCallback? onTap;

  const MyBookingCardWidget({
    super.key,
    required this.bookData,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w).copyWith(top: 12.h),
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Column(
          children: [
            Row(
              children: [
                BookingStatusWidget(
                  status: bookData.status ?? '',
                  backgroundColor: bookData.backgroundStatusColor ?? '',
                  textColor: bookData.textStatusColor ?? '',
                ),
                SizedBox(width: 8.w),
                IdBookingWithCopyWidget(
                  bookingId: bookData.code ?? '',
                  onCopy: () {
                    Clipboard.setData(ClipboardData(
                      text: bookData.code ?? '',
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(S.of(context).bookingCodeCopied)),
                    );
                  },
                ),
                const Spacer(),
                RatingBookingWidget(rating: bookData.totalRate ?? 0.0),
              ],
            ),
            const Divider(thickness: 0.5, color: Color(0xffF0F0F0)),
            Row(
              children: [
                HotelImageWidget(imageUrl: bookData.image ?? ''),
                SizedBox(width: 12.w),
                InfoHotelInCardBookingWidget(
                  title: bookData.property ?? '',
                  location:
                      '${bookData.address?.city ?? ''} , ${bookData.address?.district ?? ''}',
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
