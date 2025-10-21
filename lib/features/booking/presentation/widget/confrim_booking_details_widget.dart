import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/extension/string.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../generated/l10n.dart';
import 'general_design_for_booking_widget.dart';

class ConfrimBookingDetailsWidget extends StatelessWidget {
  const ConfrimBookingDetailsWidget({
    super.key,
    required this.checkOut,
    required this.unitCount,
    required this.unitName,
    required this.totalPrice,
    required this.bookAt,
    required this.checkIn,
  });

  final double? totalPrice;
  final String bookAt;
  final String unitCount;
  final String unitName;

  final String checkIn;
  final String checkOut;

  @override
  Widget build(BuildContext context) {
    return GeneralDesignForBookingWidget(
      title: S.of(context).confirmationSectionTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PriceAndCurrencyWidget(
            price: totalPrice.toString() ,
            fontWeight: FontWeight.w400,
            fontSize: 14.6.sp,
          ),
          const Divider(
            thickness: 1,
            color: Color(0xffF0F0F0),
          ),
          6.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.date,
                height: 17.h,
                color: const Color(0xff605A65),
              ),
              10.horizontalSpace,
              Flexible(
                child: AutoSizeTextWidget(
                  text: '${S.of(context).bookingDateLabel} ${formatDate(bookAt)} ',
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w400,
                  colorText: const Color(0xff757575),
                ),
              ),
            ],
          ),
          6.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.buliding,
                height: 17.h,
                color: const Color(0xff605A65),
              ),
              10.horizontalSpace,
              Flexible(
                child: AutoSizeTextWidget(
                  text: '$unitCount $unitName',
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w400,
                  colorText: const Color(0xff757575),
                ),
              ),
            ],
          ),
          6.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.clock,
                height: 17.h,
                color: const Color(0xff605A65),
              ),
              10.horizontalSpace,
              Flexible(
                child: AutoSizeTextWidget(
                  text:
                      '${S.of(context).from} $checkIn ${S.of(context).to} $checkOut',
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w400,
                  colorText: const Color(0xff757575),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
