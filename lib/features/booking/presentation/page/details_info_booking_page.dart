import 'package:booking/core/constants/app_icons.dart';
import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:booking/features/booking/presentation/page/rate_page.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../properties/property_details/presentation/pages/property_details_page.dart';
import '../../data/booking_model/booking_model.dart';
import '../riverpod/booking_riverpod.dart';
import '../widget/booking_data_card_widget.dart';
import '../widget/confrim_booking_card_widget.dart';
import '../widget/hotel_summary_card_widget.dart';
import '../widget/policy_tile_widget.dart';
import 'details_of_book_in_add_page.dart';

class BookingDetailPage extends ConsumerWidget {
  final BookingData bookData;
  final bool isCompletedBook;

  const BookingDetailPage(
      {super.key, required this.bookData, required this.isCompletedBook});

  @override
  Widget build(BuildContext context,ref) {
    final state =ref.watch(getIfPropertyRatedProvider(Tuple2(bookData.propertyId,bookData.id)));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title:  AutoSizeTextWidget(
          text: S.of(context).bookingDetailsTitle,
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
              bookingId: bookData.code ?? '',
              bookingDateString: bookData.bookingAt.toString(),
              status: bookData.status ?? '',
            ),
            SizedBox(height: 16.h),
            BookingDataCard(
              adults: bookData.adultCount ?? 1,
              children: bookData.childCount ?? 1,
              startDateString: bookData.checkIn ?? '',
              endDateString: bookData.checkOut ?? '',
            ),
            SizedBox(height: 16.h),
            // PolicyTileWidget(
            //   title: 'سياسة الشراء والالغاء',
            //   onTap: () {},
            // ),
            Visibility(
              visible: isCompletedBook,
              replacement:   PolicyTileWidget(
                title:S.of(context).purchaseAndCancellationPolicy,
                onTap: () {},
              ),
              child: bookData.isRated==true||state==true?SizedBox(): AddYourRatingSection(
                bookingId: bookData.id??0,
                propertyId: bookData.propertyId!,
                rateData: bookData.rateData??[],
              ),

            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: DefaultButtonWidget(
                text: S.of(context).viewVenueDetails,
                onPressed: () {
                  navigateTo(
                    context,
                    PropertyDetailsPage(
                      propertyId: bookData.propertyId!,
                      images: [bookData.image ?? ''],
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
