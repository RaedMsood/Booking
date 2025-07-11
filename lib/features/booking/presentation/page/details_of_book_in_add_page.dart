import 'package:booking/core/helpers/flash_bar_helper.dart';
import 'package:booking/core/widgets/auto_size_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/buttons/default_button.dart';
import '../widget/hotel_summary_card_widget.dart';
import '../widget/range_calender_widget.dart';
import '../widget/select_booking_details_widget.dart';

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
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  height: 70.h,
                  width: double.infinity,
                  color: Colors.white,
                  ),
              Padding(
                padding:  EdgeInsets.all(14.0.sp),
                child: DefaultButtonWidget(
                  text: "التالي",
                  height: 44.h,
                  width: double.infinity,
                  borderRadius:15.r ,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
