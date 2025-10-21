import 'package:booking/core/helpers/navigateTo.dart';
import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:booking/features/booking/presentation/page/pay_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/booking_model/booking_data.dart';
import '../riverpod/booking_riverpod.dart';
import '../widget/audience_in_details_booking_widget.dart';
import '../widget/confrim_booking_details_widget.dart';
import '../widget/deposit_in_last_details_widget.dart';
import '../widget/hotel_summary_card_widget.dart';

class ShowLastDetailsInAddBookingPage extends StatelessWidget {
  const ShowLastDetailsInAddBookingPage({
    super.key,
    required this.bookingData,
    required this.image,
    required this.nameProp,
    required this.location,
  });

  final BookingData bookingData;
  final String nameProp;
  final String location;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).hotelBookingTitle),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              4.h.verticalSpace,
              HotelSummaryCard(
                name: nameProp,
                location: location,
                imageUrl: image,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.sp),
                child: Column(
                  children: [
                    ConfrimBookingDetailsWidget(
                      unitCount: bookingData.unitCount.toString(),
                      unitName: bookingData.unitName.toString(),
                      bookAt: bookingData.bookingAt.toString(),
                      checkIn: bookingData.checkIn.toString(),
                      checkOut: bookingData.checkOut.toString(),
                      totalPrice:
                          double.tryParse(bookingData.totalPrice.toString()) ??
                              0.0,
                    ),
                    18.verticalSpace,
                    Consumer(
                      builder: (context, ref, child) {
                        return DefaultButtonWidget(
                          text: S.of(context).payDeposit,
                          borderRadius: 12.r,
                          onPressed: () {
                            ref.read(selectedPayMethodProvider.notifier).state =
                                null;
                            ref
                                .read(selectedPayMethodErrorProvider.notifier)
                                .state = null;
                            navigateTo(
                                context, PayPage(bookingData: bookingData));
                          },
                          withIcon: true,
                          icon: AppIcons.pay,
                        );
                      },
                    ),
                    6.verticalSpace,
                    AutoSizeTextWidget(
                      text: S.of(context).payDepositNote,
                      fontSize: 9.8.sp,
                      fontWeight: FontWeight.w300,
                      colorText: const Color(0xff001A33),
                    ),
                    12.verticalSpace,
                    AudienceInDetailsBookingWidget(
                      numChild: bookingData.childCount ?? 0,
                      numGuests: bookingData.guests ?? 0,
                      type: bookingData.type.toString(),
                    ),
                    12.verticalSpace,
                    DepositInLastDetailsWidget(
                      deposit: bookingData.deposit,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
