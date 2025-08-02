import 'package:booking/core/helpers/navigateTo.dart';
import 'package:booking/core/widgets/auto_size_text_widget.dart';
import 'package:booking/features/booking/data/booking_model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/flash_bar_helper.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/widgets/buttons/default_button.dart';
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

  const DetailsOfBookInAddPage({
    required this.image,
    required this.nameProp,
    required this.location,
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
  String typeBook = "ترفية";
  int rooms = 1, adults = 1, children = 1;

  @override
  Widget build(BuildContext context) {
    var checkBookingState = ref.watch(checkBookingProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const AutoSizeTextWidget(
          text: 'حجز الفندق',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                    idBooking: checkBookingState.data,
                  ));
            },
            bottonWidget: DesginButtonInAddBookingWidget(
              button: DefaultButtonWidget(
                  text: "التالي",
                  height: 44.h,
                  width: double.infinity,
                  borderRadius: 15.r,
                  isLoading: checkBookingState.stateData == States.loading,
                  onPressed: () {
                    if (startDate == null || endDate == null) {
                      showFlashBarWarring(
                          context: context,
                          message: "قم بتحديد تاريخ الحجز الخاص بك");
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
                          totalPrice: 100,
                          unitId: 1);
                      ref
                          .read(checkBookingProvider.notifier)
                          .checkBookingInHotel(bookingData: bookingData);
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
