import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../properties/property_details/presentation/pages/property_details_page.dart';
import '../../../properties/units/presentation/pages/unit_details_page.dart';
import '../riverpod/offers_riverpod.dart';
import '../widget/card_of_best_offers_widget.dart';
import 'best_offers_page.dart';

class BestOffers extends ConsumerWidget {
  const BestOffers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getBestOffersProvider);
    final firstPageCount = state.data.perPage > 0
        ? state.data.perPage
        : state.data.data.length;
    final offers = state.data.data.take(firstPageCount).toList();

    if ((state.stateData == States.loading || state.stateData == States.initial) &&
        offers.isEmpty) {
      return const SizedBox.shrink();
    }

    if (offers.isEmpty) {
      return const SizedBox.shrink();
    }

    String formatPrice(num value) {
      if (value == value.toInt()) {
        return value.toInt().toString();
      }
      return value.toString();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeTextWidget(
                text: 'أفضل العروض',
                colorText: AppColors.mainColorFont,
                fontSize: 13.6.sp,
              ),
              6.w.horizontalSpace,
              Text(
                '🔥',
                style: TextStyle(fontSize: 14.sp),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  navigateTo(context, const BestOffersPage(

                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.mainColorFont.withValues(alpha: 0.2),
                      width: 0.9,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  child: Row(
                    children: [
                      AutoSizeTextWidget(
                        text: 'المزيد',
                        colorText: AppColors.mainColorFont.withValues(alpha: 0.9),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 11.sp,
                        color: AppColors.mainColorFont.withValues(alpha: 0.9),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            itemCount: offers.length,
            separatorBuilder: (_, __) => 12.w.horizontalSpace,
            itemBuilder: (context, index) {
              final offer = offers[index];

              void openDetails() {
                navigateTo(
                  context,
                //   PropertyDetailsPage(
                //     propertyId: offer.propertyId,
                //     images: offer.image.isNotEmpty ? [offer.image] : [],
                //   ),
                // );
                    UnitDetailsPage(unitId: offer.id),
                );
              }

              return CardOfBestOffersWidget(
                width: 318.w,
                imageUrl: offer.image,
                title: offer.propertyName.isNotEmpty
                    ? offer.propertyName
                    : offer.name,
                subTitle: offer.name.isNotEmpty ? offer.name : offer.unitType,
                offerText:
                     offer.offerDescription,
                currentPrice: formatPrice(offer.effectivePrice),
                originalPrice: offer.originalPriceBeforeDiscount == null
                    ? null
                    : formatPrice(offer.originalPriceBeforeDiscount!),
                onTap: openDetails,
                onBookNowTap: openDetails,
              );
            },
          ),
        ),
      ],
    );
  }
}
