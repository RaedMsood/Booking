import 'package:booking/core/helpers/flash_bar_helper.dart';
import 'package:booking/core/helpers/navigateTo.dart';
import 'package:booking/core/widgets/auto_size_text_widget.dart';
import 'package:flutter/material.dart';
import '../widget/desgin_button_in_add_booking_widget.dart';
import '../widget/hotel_summary_card_widget.dart';
import '../widget/range_calender_widget.dart';
import '../widget/select_booking_details_widget.dart';
import 'complete_add_booking_page.dart';

class DetailsOfBookInAddPage extends StatelessWidget {
  const DetailsOfBookInAddPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const HotelSummaryCard(
                    name: "فندق ام القرى السياحي",
                    location: "هبرة , سعوان",
                    imageUrl: '',
                  ),
                  const RangeCalendarWidget(),
                  const SelectBookingDetailsWidget(),
                ],
              ),
            ),
          ),
          DesginButtonInAddBookingWidget(
            onPressed: (){
              navigateTo(context, CompleteAddBookingPage());
            },
          ),
        ],
      ),
    );
  }
}
