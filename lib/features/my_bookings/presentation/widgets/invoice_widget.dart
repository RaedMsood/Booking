import 'package:booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/invoice_model.dart';
import 'section_card_in_details_widget.dart';

class InvoiceWidget extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceWidget({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    return SectionCardInDetailsWidget(
      title: S.of(context).invoice,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InvoiceRowWidget(
            label: S.of(context).grandTotal,
            price: invoice.totalPrice.toString(),
          ),
          4.verticalSpace,
          const Divider(color: Color(0xffF0F0F0)),
          4.verticalSpace,
          InvoiceRowWidget(
            label: S.of(context).depositAmount,
            price: invoice.deposit.toString(),
          ),
          8.verticalSpace,
          InvoiceRowWidget(
            label: S.of(context).remainingAfterDeposit,
            price: invoice.remainingBalance.toString(),
            firstColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}

class InvoiceRowWidget extends StatelessWidget {
  final String label;
  final String price;
  final Color? firstColor;
  final Color? textColor;
  final double? fontSizeLabel;
  final double? fontSizePrice;
  final double? fontSizeSecondText;

  const InvoiceRowWidget({
    super.key,
    required this.label,
    required this.price,
    this.firstColor,
    this.textColor,
    this.fontSizeLabel,
    this.fontSizePrice,
    this.fontSizeSecondText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeTextWidget(
          text: label,
          fontSize: fontSizeLabel ?? 10.sp,
          colorText: textColor ?? const Color(0xff605A65),
        ),
        PriceAndCurrencyWidget(
          price: price,
          firstColor: firstColor ?? const Color(0xff292D32),
          fontSize:fontSizePrice?? 10.8.sp,
          secondColor: firstColor ?? const Color(0xff292D32),
          fontWeightSecondText: FontWeight.w400,
          fontSizeSecondText:fontSizeSecondText?? 9.sp,
        ),
      ],
    );
  }
}
