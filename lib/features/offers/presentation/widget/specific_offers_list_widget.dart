import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/specific_offer_model.dart';
import 'card_of_best_offers_widget.dart';

class SpecificOffersListWidget extends StatelessWidget {
  const SpecificOffersListWidget({
    super.key,
    required this.offers,
    required this.onOfferTap,
  });

  final List<SpecificOfferModel> offers;
  final ValueChanged<SpecificOfferModel> onOfferTap;

  String _formatPrice(num value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: offers.isEmpty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 12.h),
              children: [
                SizedBox(height: 120.h),
                Center(
                  child: Text(
                    'لا توجد وحدات متاحة لهذا العرض حالياً',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )
          : ListView.builder(
              padding: EdgeInsets.only(bottom: 12.h),
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0.w,
                    vertical: 8.0.h,
                  ),
                  child: CardOfBestOffersWidget(
                    isAllBestOffers: true,
                    height: 140.h,
                    imageUrl: offer.image,
                    title: offer.propertyName.isNotEmpty
                        ? offer.propertyName
                        : offer.name,
                    subTitle: offer.name.isNotEmpty ? offer.name : offer.unitType,
                    offerText:  offer.offerDescription,
                    currentPrice: _formatPrice(offer.effectivePrice),
                    originalPrice: offer.originalPriceBeforeDiscount == null
                        ? null
                        : _formatPrice(offer.originalPriceBeforeDiscount!),
                    onTap: () => onOfferTap(offer),
                    onBookNowTap: () => onOfferTap(offer),
                  ),
                );
              },
            ),
    );
  }
}

