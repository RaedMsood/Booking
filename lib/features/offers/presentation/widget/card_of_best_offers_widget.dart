import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../../properties/units/presentation/widgets/unit_price_widget.dart';

class CardOfBestOffersWidget extends StatelessWidget {
  const CardOfBestOffersWidget({
    super.key,
    this.imageUrl = '',
    this.title = '',
    this.subTitle = '',
    this.offerText = '',
    this.bookNowText = '',
    this.onTap,
    this.onBookNowTap,
    this.width,
    this.margin,
    this.height,
    this.isAllBestOffers = false,
    this.currentPrice = '450',
    this.originalPrice = '40000',
  });

  final String imageUrl;
  final String title;
  final String subTitle;
  final String offerText;
  final bool isAllBestOffers;
  final String bookNowText;
  final String currentPrice;
  final String? originalPrice;
  final VoidCallback? onTap;
  final VoidCallback? onBookNowTap;
  final double? width;
  final double? height;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height??100.h,
      width: width,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                    child: OnlineImagesWidget(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      size: Size(100.w, 80.h),
                      borderRadius: 50.r,
                      smoothCorners: true,

                    ),
                  ),
                  10.w.verticalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeTextWidget(
                        text: title,
                        maxLines: 2,
                        fontSize: 12.sp,
                        colorText: AppColors.mainColorFont,
                        textAlign: TextAlign.center,
                      ),
                      5.h.verticalSpace,
                      AutoSizeTextWidget(
                        text: subTitle,
                        fontSize: 10.sp,
                        maxLines: 1,
                        fontWeight: FontWeight.w400,
                        colorText: Color(0xff757575),
                        textAlign: TextAlign.center,
                      ),
                      5.h.verticalSpace,
                      _OfferBadgeWidget(text: offerText),
                      5.h.verticalSpace,
                      UnitPriceWidget(
                        currentPrice: currentPrice,
                        currentFontSize: 12.sp,
                        spacing: 8,
                        originalPrice: originalPrice,
                        currentPriceWeight: FontWeight.bold,
                        currentCurrencyWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: isAllBestOffers==true,
                child: Column(
                  children: [
                    8.h.verticalSpace,
                    DefaultButtonWidget(
                      onPressed: onBookNowTap,
                      text: 'احجز الآن',
                      height: 30.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _OfferBadgeWidget extends StatelessWidget {
  const _OfferBadgeWidget({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final borderColor = Color(0xffB6FFCE);

    return Container(
      height: 16.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xffEAFFF1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: borderColor,
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          AutoSizeTextWidget(
            text: text,
            fontSize: 8.sp,
            minFontSize: 8,
            maxLines: 1,
            colorText: Color(0xff04B440),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
