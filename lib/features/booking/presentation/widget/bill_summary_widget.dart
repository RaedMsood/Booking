import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../properties/units/presentation/widgets/unit_price_widget.dart';
import '../../../my_bookings/presentation/widgets/invoice_widget.dart';

class BookingBillSummaryWidget extends StatelessWidget {
  final dynamic deposit;
  final dynamic totalPrice;
  final dynamic originalPrice;
  final dynamic totalBeforeOffer;
  final dynamic totalAfterOffer;
  final dynamic totalDiscountAmount;

  const BookingBillSummaryWidget({
    super.key,
    required this.deposit,
    required this.totalPrice,
    this.originalPrice,
    this.totalBeforeOffer,
    this.totalAfterOffer,
    this.totalDiscountAmount,
  });

  double _asDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final displayedTotal = _asDouble(totalPrice);
    final depositAmount = _asDouble(deposit);
    final beforeOfferAmount = _asDouble(totalBeforeOffer);
    final afterOfferAmount = _asDouble(totalAfterOffer);
    final discountAmount = _asDouble(totalDiscountAmount);
    final showOfferSummary = beforeOfferAmount > 0 &&
        afterOfferAmount > 0 &&
        discountAmount > 0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  S.of(context).grandTotal,
                  style: TextStyle(
                    color: const Color(0xff605A65),
                    fontSize: 11.4.sp,
                    fontFamily: 'ReadexPro',
                  ),
                ),
              ),
              12.w.horizontalSpace,
              UnitPriceWidget(
                currentPrice: displayedTotal.toString(),
                originalPrice: originalPrice?.toString(),
                crossAxisAlignment: CrossAxisAlignment.end,
                currentFontSize: 12.2.sp,
                currentCurrencyFontSize: 9.8.sp,
                currentPriceColor: const Color(0xff292D32),
                currentCurrencyColor: const Color(0xff292D32),
                currentPriceWeight: FontWeight.w500,
                currentCurrencyWeight: FontWeight.w400,
                originalFontSize: 9.6.sp,
                originalCurrencyFontSize: 8.8.sp,
                originalPriceColor: AppColors.greyColor,
                originalCurrencyColor: AppColors.greyColor,
                spacing: 2,
              ),
            ],
          ),
          if (showOfferSummary) ...[
            8.verticalSpace,
            InvoiceRowWidget(
              label: 'الإجمالي قبل العرض',
              price: beforeOfferAmount.toString(),
              fontSizeLabel: 10.8.sp,
              fontSizePrice: 11.4.sp,
              fontSizeSecondText: 9.sp,
              firstColor: AppColors.greyColor,
              textColor: AppColors.greyColor,
             // isDiscounted: true,
            ),
            8.verticalSpace,
            InvoiceRowWidget(
              label: 'الإجمالي بعد العرض',
              price: afterOfferAmount.toString(),
              fontSizeLabel: 10.8.sp,
              fontSizePrice: 11.6.sp,
              fontSizeSecondText: 9.2.sp,
              firstColor: AppColors.primaryColor,
              textColor: const Color(0xff292D32),
            ),
            8.verticalSpace,
            InvoiceRowWidget(
              label: 'إجمالي الخصم',
              price: discountAmount.toString(),
              fontSizeLabel: 10.8.sp,
              fontSizePrice: 11.6.sp,
              fontSizeSecondText: 9.2.sp,
              firstColor: AppColors.successSwatch.shade700,
              textColor: AppColors.successSwatch.shade700,
            ),
          ],
          4.verticalSpace,
          const Divider(color: Color(0xffF0F0F0)),
          4.verticalSpace,
          InvoiceRowWidget(
            label: S.of(context).depositAmount,
            price: depositAmount.toString(),
            fontSizeLabel: 11.4.sp,
            fontSizePrice: 12.2.sp,
            fontSizeSecondText: 9.8.sp,
            textColor: const Color(0xff292D32),
            firstColor: const Color(0xff605A65),
          ),
          8.verticalSpace,
          InvoiceRowWidget(
            label: S.of(context).remainingAfterDeposit,
            price: (displayedTotal - depositAmount).toString(),
            firstColor: AppColors.primaryColor,
            fontSizeLabel: 11.4.sp,
            fontSizePrice: 12.2.sp,
            fontSizeSecondText: 9.8.sp,
            textColor: const Color(0xff292D32),
          ),
        ]),
      ),
    );
  }
}
