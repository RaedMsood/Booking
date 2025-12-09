import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/flash_bar_helper.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/booking_model/booking_data.dart';
import '../riverpod/booking_riverpod.dart';
import '../widget/desgin_button_in_add_booking_widget.dart';
import '../widget/hotel_summary_card_widget.dart';
import '../widget/range_calender_widget.dart';
import '../widget/select_booking_details_widget.dart';
import 'complete_add_booking_page.dart';

class DetailsOfBookInAddPage extends ConsumerStatefulWidget {
  final String nameProp;
  final String location;
  final String image;
  final int unitId;
  final String totalPrice;

  const DetailsOfBookInAddPage({
    required this.image,
    required this.nameProp,
    required this.location,
    required this.unitId,
    required this.totalPrice,
    super.key,
  });

  @override
  ConsumerState<DetailsOfBookInAddPage> createState() =>
      _DetailsOfBookInAddPageState();
}

class _DetailsOfBookInAddPageState
    extends ConsumerState<DetailsOfBookInAddPage> {
  DateTime? startDate;
  DateTime? endDate;
  String typeBook = S.current.purposeLeisure;
  int rooms = 1, adults = 1, children = 1;

  @override
  Widget build(BuildContext context) {
    var checkBookingState = ref.watch(checkBookingProvider);

    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).hotelBookingTitle),
      body: SafeArea(
        top: false,

        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    6.h.verticalSpace,
                    HotelSummaryCard(
                      name: widget.nameProp,
                      location: widget.location,
                      imageUrl: widget.image,
                    ),
                    RangeCalendarWidget(
                      onRangeSelected: (start, end) {
                        setState(() {
                          startDate = start;
                          endDate = end;
                        });
                      },
                    ),
                    SelectBookingDetailsWidget(countAdult: (adult) {
                      adults = adult!;
                    }, countChild: (child) {
                      children = child!;
                    }, countRoom: (room) {
                      rooms = room!;
                    }, onTypeSelected: (type) {
                      typeBook = type!;
                    }),
                  ],
                ),
              ),
            ),
            CheckStateInPostApiDataWidget(
              state: checkBookingState,
              functionSuccess: () {
                navigateTo(
                    context,
                    CompleteAddBookingPage(
                      nameProp: widget.nameProp,
                      location: widget.location,
                      imageUrl: widget.image,
                      booking: checkBookingState.data,
                    ));
              },
              bottonWidget: DesginButtonInAddBookingWidget(
                button: DefaultButtonWidget(
                    text: S.of(context).next,
                    height: 42.h,
                    width: double.infinity,
                    borderRadius: 15.r,
                    isLoading: checkBookingState.stateData == States.loading,
                    onPressed: () {
                      if (startDate == null || endDate == null) {
                        showFlashBarWarring(
                            context: context,
                            message: S.of(context).validationSelectDate);
                      } else {
                        final bookingData = BookingData(
                          checkIn: DateFormat('yyyy-MM-dd', 'en_US')
                              .format(startDate!)
                              .toString(),
                          checkOut: DateFormat('yyyy-MM-dd', 'en_US')
                              .format(endDate!)
                              .toString(),
                          type: typeBook,
                          unitCount: rooms,
                          childCount: children,
                          adultCount: adults,
                          guests: 4,
                          totalPrice: widget.totalPrice,
                          unitId: widget.unitId,
                        );
                        ref
                            .read(checkBookingProvider.notifier)
                            .checkBookingInHotel(bookingData: bookingData);
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
