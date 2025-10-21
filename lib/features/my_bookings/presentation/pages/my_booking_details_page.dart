import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../properties/property_details/presentation/pages/property_details_page.dart';
import '../../../booking/presentation/riverpod/booking_riverpod.dart';
import '../../data/model/my_bookings_data.dart';
import '../widgets/booking_data_card_widget.dart';
import '../widgets/confrim_booking_card_widget.dart';
import '../../../booking/presentation/widget/hotel_summary_card_widget.dart';
import '../widgets/policy_tile_widget.dart';
import 'rate_page.dart';

class MyBookingDetailsPage extends ConsumerWidget {
  final MyBookingsData bookData;
  final bool isCompletedBook;

  const MyBookingDetailsPage(
      {super.key, required this.bookData, required this.isCompletedBook});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(
        getIfPropertyRatedProvider(Tuple2(bookData.propertyId, bookData.id)));
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).bookingDetailsTitle),
      body: SingleChildScrollView(
        child: Column(
          children: [
            6.h.verticalSpace,
            HotelSummaryCard(
              name: bookData.property!,
              location:
                  '${bookData.address!.city!} , ${bookData.address!.district!}',
              imageUrl: bookData.image ?? '',
            ),
            14.h.verticalSpace,

            ConfrimBookingCardWidget(
              bookingId: bookData.code ?? '',
              bookingDateString: bookData.bookingAt.toString(),
              status: bookData.status ?? '',
            ),
            14.h.verticalSpace,
            BookingDataCardWidget(
              adults: bookData.adultCount ?? 1,
              children: bookData.childCount ?? 1,
              startDateString: bookData.checkIn ?? '',
              endDateString: bookData.checkOut ?? '',
            ),
            14.h.verticalSpace,
            // PolicyTileWidget(
            //   title: 'سياسة الشراء والالغاء',
            //   onTap: () {},
            // ),
            Visibility(
              visible: isCompletedBook,
              replacement: PolicyTileWidget(
                title: S.of(context).purchaseAndCancellationPolicy,
                onTap: () {},
              ),
              child: bookData.isRated == true || state == true
                  ? const SizedBox()
                  : AddYourRatingSection(
                      bookingId: bookData.id ?? 0,
                      propertyId: bookData.propertyId!,
                      rateData: bookData.rateData ?? [],
                    ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: DefaultButtonWidget(
                text: S.of(context).viewVenueDetails,
                textSize: 11.6.sp,
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
