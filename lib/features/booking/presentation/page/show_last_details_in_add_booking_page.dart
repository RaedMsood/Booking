import 'package:booking/core/helpers/flash_bar_helper.dart';
import 'package:booking/core/helpers/navigateTo.dart';
import 'package:booking/core/theme/app_colors.dart';
import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:booking/features/booking/presentation/page/pay_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../widget/audience_in_details_booking_widget.dart';
import '../widget/confrim_booking_details_widget.dart';
import '../widget/deposit_in_last_details_widget.dart';
import '../widget/hotel_summary_card_widget.dart';

class ShowLastDetailsInAddBookingPage extends StatelessWidget {
  const ShowLastDetailsInAddBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AutoSizeTextWidget(
          text: 'حجز الفندق',
        ),
      ),
      body: Column(
        children: [
          HotelSummaryCard(
            name: "فندق ام القرى السياحي",
            location: "هبرة , سعوان",
            imageUrl: '',
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.sp),
            child: Column(
              children: [
                ConfrimBookingDetailsWidget(),
                18.verticalSpace,
                DefaultButtonWidget(
                  text: "دفع العربون",
                  borderRadius: 12.r,
                  onPressed: () {
                    navigateTo(context, PayPage());
                  },
                  withIcon: true,
                  icon: AppIcons.pay,
                ),
                4.verticalSpace,
                AutoSizeTextWidget(
                  text: 'يرجى دفع العربون لتأكيد الحجز',
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  colorText: Color(0xff001A33),
                ),
                12.verticalSpace,
                AudienceInDetailsBookingWidget(),
                12.verticalSpace,
                DepositInLastDetailsWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
