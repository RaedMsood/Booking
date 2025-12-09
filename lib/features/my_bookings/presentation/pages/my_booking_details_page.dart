import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../properties/property_details/presentation/pages/property_details_page.dart';
import '../../../booking/presentation/riverpod/booking_riverpod.dart';
import '../../../properties/units/data/model/units_model.dart';
import '../../data/model/invoice_model.dart';
import '../riverpod/my_bookings_riverpod.dart';
import '../widgets/booking_data_card_widget.dart';
import '../widgets/confrim_booking_card_widget.dart';
import '../widgets/invoice_widget.dart';
import '../widgets/policy_tile_widget.dart';
import '../widgets/section_card_in_details_widget.dart';
import '../widgets/unit_card_for_my_booking_details_widget.dart';
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
      appBar: SecondaryAppBarWidget(
        title: S.of(context).bookingDetailsTitle,
        fromHeight: 50.h,
      ),
      body: SafeArea(
        top: false,
        child: CheckStateInGetApiDataWidget(
          state: stateMyBooking,
          refresh: () {
            ref.invalidate(myBookingDetailsProvider(bookingId));
          },
          widgetOfData: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(getIfPropertyRatedProvider(Tuple2(
                    stateMyBooking.data.propertyId, stateMyBooking.data.id)));
                return Column(
                  children: [
                    UnitCardForMyBookingDetailsWidget(
                      units: stateMyBooking.data.unit ?? UnitsModel.empty(),
                    ),
                    ConfrimBookingCardWidget(
                      bookingId: stateMyBooking.data.code ?? '',
                      bookingDateString:
                          stateMyBooking.data.bookingAt.toString(),
                      status: stateMyBooking.data.status ?? '',
                    ),
                    8.h.verticalSpace,
                    BookingDataCardWidget(
                      adults: stateMyBooking.data.adultCount ?? 1,
                      children: stateMyBooking.data.childCount ?? 1,
                      startDateString: stateMyBooking.data.checkIn ?? '',
                      endDateString: stateMyBooking.data.checkOut ?? '',
                    ),
                    8.h.verticalSpace,
                    // PolicyTileWidget(
                    //   title: 'سياسة الشراء والالغاء',
                    //   onTap: () {},
                    // ),
                    SectionCardInDetailsWidget(
                      title: S.of(context).paymentMethod,
                      child: Row(
                        children: [
                          OnlineImagesWidget(
                            imageUrl: stateMyBooking.data.paymentMethods!.image
                                .toString(),
                            size: Size(56.w, 40.h),
                            logoWidth: 20.w,
                          ),
                          10.w.horizontalSpace,
                          Flexible(
                            child: AutoSizeTextWidget(
                              text: stateMyBooking.data.paymentMethods!.name
                                  .toString(),
                              fontSize: 10.4.sp,
                              colorText: const Color(0xff605A65),
                            ),
                          ),
                        ],
                      ),
                    ),
                    8.h.verticalSpace,
                    InvoiceWidget(
                      invoice:
                          stateMyBooking.data.invoice ?? InvoiceModel.empty(),
                    ),
                    8.h.verticalSpace,
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
                    12.h.verticalSpace,

                    DefaultButtonWidget(
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
                    6.h.verticalSpace,
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
