import 'package:booking/core/constants/app_icons.dart';
import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/booking_model/booking_model.dart';
import '../widget/booking_data_card_widget.dart';
import '../widget/confrim_booking_card_widget.dart';
import '../widget/hotel_summary_card_widget.dart';
import '../widget/policy_tile_widget.dart';
import 'details_of_book_in_add_page.dart';

class BookingDetailPage extends StatelessWidget {
  final BookingData bookData;

  const BookingDetailPage({
    Key? key,
    required this.bookData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('yyyy-MM-dd', 'en');
    final timeFmt = DateFormat('HH:mm', 'en');
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
              name: bookData.property!,
              location:
                  '${bookData.address!.city!} , ${bookData.address!.district!}',
              imageUrl: bookData.image ?? '',
            ),
            SizedBox(height: 16.h),
            ConfirmBookingCard(
              bookingId: '1-2347373',
              // bookingDateString:
              //     '${timeFmt.format(bookingDate)} - ${dateFmt.format(bookingDate)}',
              bookingDateString: "08:17 - 2025-07-01",
              status: bookData.status ?? '',
            ),
            SizedBox(height: 16.h),
            BookingDataCard(
              adults: bookData.adultCount ?? 1,
              children: bookData.childCount ?? 1,
              // endDateString:dateFmt.format(bookData.checkIn as DateTime)?? " 2025-07-01",
              // startDateString:dateFmt.format(bookData.checkOut as DateTime) ??" 2025-07-01",
              startDateString: " 2025-07-01",
              endDateString: " 2025-07-01",
            ),
            SizedBox(height: 16.h),
            PolicyTileWidget(
              title: 'سياسة الشراء والالغاء',
              onTap: () {},
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: DefaultButtonWidget(
                text: "استعراض تفاصيل المنشأة",
                onPressed: () {
                  navigateTo(
                    context,
                    DetailsOfBookInAddPage(
                      location:
                          '${bookData.address!.city!} , ${bookData.address!.district!}',
                      image: bookData.image ?? '',
                      nameProp: bookData.property!,
                    ),
                  );
                },
                withIcon: true,
                icon: AppIcons.bank,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

