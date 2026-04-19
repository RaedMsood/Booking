import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/price_and_currency_widget.dart';

class UnitPriceWidget extends StatelessWidget {
  final String currentPrice;
  final String? originalPrice;
  final double? currentFontSize;
  final double? currentCurrencyFontSize;
  final double? originalFontSize;
  final double? originalCurrencyFontSize;
  final Color? currentPriceColor;
  final Color? currentCurrencyColor;
  final Color? originalPriceColor;
  final Color? originalCurrencyColor;
  final FontWeight? currentPriceWeight;
  final FontWeight? currentCurrencyWeight;
  final CrossAxisAlignment crossAxisAlignment;
  final double spacing;

  const UnitPriceWidget({
    super.key,
    required this.currentPrice,
    this.originalPrice,
    this.currentFontSize,
    this.currentCurrencyFontSize,
    this.originalFontSize,
    this.originalCurrencyFontSize,
    this.currentPriceColor,
    this.currentCurrencyColor,
    this.originalPriceColor,
    this.originalCurrencyColor,
    this.currentPriceWeight,
    this.currentCurrencyWeight,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.spacing = 2,
  });

  bool get _hasOriginalPrice =>
      (originalPrice ?? '').trim().isNotEmpty &&
      originalPrice!.trim() != currentPrice.trim();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        PriceAndCurrencyWidget(
          price: currentPrice,
          fontSize: currentFontSize,
          fontSizeSecondText: currentCurrencyFontSize,
          firstColor: currentPriceColor,
          secondColor: currentCurrencyColor,
          fontWeight: currentPriceWeight,
          fontWeightSecondText: currentCurrencyWeight,
        ),
        if (_hasOriginalPrice) ...[
          spacing.h.verticalSpace,
          PriceAndCurrencyWidget(
            price: originalPrice!,
            fontSize: originalFontSize ?? 9.sp,
            fontSizeSecondText: originalCurrencyFontSize ?? 8.sp,
            firstColor: originalPriceColor ?? AppColors.greyColor,
            secondColor: originalCurrencyColor ?? AppColors.greyColor,
            fontWeight: FontWeight.w400,
            fontWeightSecondText: FontWeight.w400,
            decoration: TextDecoration.lineThrough,
          ),
        ],
      ],
    );
  }
}
