import 'package:booking/core/state/check_state_in_get_api_data_widget.dart';
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
import '../riverpod/my_bookings_riverpod.dart';
import '../widgets/booking_data_card_widget.dart';
import '../widgets/confrim_booking_card_widget.dart';
import '../../../booking/presentation/widget/hotel_summary_card_widget.dart';
import '../widgets/policy_tile_widget.dart';
import 'rate_page.dart';

class MyBookingDetailsPage extends ConsumerWidget {
  final bool isCompletedBook;
  final int bookingId;

  const MyBookingDetailsPage({
    super.key,
    required this.bookingId,
    required this.isCompletedBook,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var stateMyBooking = ref.watch(myBookingDetailsProvider(bookingId));

    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).bookingDetailsTitle),
      body: SafeArea(
        top: false,
        child: CheckStateInGetApiDataWidget(
          state: stateMyBooking,
          refresh: () {
            ref.invalidate(myBookingDetailsProvider(bookingId));
          },
          widgetOfData: SingleChildScrollView(
            child: Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(getIfPropertyRatedProvider(Tuple2(
                    stateMyBooking.data.propertyId, stateMyBooking.data.id)));
                return Column(
                  children: [
                    6.h.verticalSpace,
                    HotelSummaryCard(
                      name: stateMyBooking.data.property!,
                      location:
                          '${stateMyBooking.data.address!.city!} , ${stateMyBooking.data.address!.district!}',
                      imageUrl: stateMyBooking.data.image ?? '',
                    ),
                    14.h.verticalSpace,

                    ConfrimBookingCardWidget(
                      bookingId: stateMyBooking.data.code ?? '',
                      bookingDateString:
                          stateMyBooking.data.bookingAt.toString(),
                      status: stateMyBooking.data.status ?? '',
                    ),
                    14.h.verticalSpace,
                    BookingDataCardWidget(
                      adults: stateMyBooking.data.adultCount ?? 1,
                      children: stateMyBooking.data.childCount ?? 1,
                      startDateString: stateMyBooking.data.checkIn ?? '',
                      endDateString: stateMyBooking.data.checkOut ?? '',
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
                      child:
                          stateMyBooking.data.isRated == true || state == true
                              ? const SizedBox.shrink()
                              : AddYourRatingSection(
                                  bookingId: stateMyBooking.data.id ?? 0,
                                  propertyId: stateMyBooking.data.propertyId!,
                                  rateData: stateMyBooking.data.rateData ?? [],
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
                              propertyId: stateMyBooking.data.propertyId!,
                              images: [stateMyBooking.data.image ?? ''],
                            ),
                          );
                        },
                        withIcon: true,
                        icon: AppIcons.bank,
                      ),
                    ),
                    14.h.verticalSpace,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
