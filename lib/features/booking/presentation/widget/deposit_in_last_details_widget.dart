import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../generated/l10n.dart';
import 'general_design_for_booking_widget.dart';

class DepositInLastDetailsWidget extends StatelessWidget {
  const DepositInLastDetailsWidget({super.key, required this.deposit});

  final dynamic deposit;

  @override
  Widget build(BuildContext context) {
    return GeneralDesignForBookingWidget(
      title: S.of(context).depositSectionTitle,
      fontSize: 12.sp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PriceAndCurrencyWidget(
            price: deposit.toString(),
            fontWeight: FontWeight.w400,
            fontSize: 14.6.sp,
          ),
          8.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).hotelPolicyNote,
            fontSize: 12,
            colorText: const Color(0xff757575),
            fontWeight: FontWeight.w400,
          ),
          4.verticalSpace,
        ],
      ),
    );
  }
}
