import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/model/specific_offer_item_model.dart';
import '../riverpod/specific_offers_riverpod.dart';
import '../widget/specific_offers_header_widget.dart';
import '../widget/specific_offers_hotels_chips_widget.dart';
import '../widget/specific_offers_list_widget.dart';
import '../../../properties/property_details/presentation/pages/property_details_page.dart';

class SpecificOffersPage extends ConsumerWidget {
  const SpecificOffersPage({
    super.key,
    required this.offerId,
  });

  final int offerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(specificOfferDetailsProvider(offerId));
    final details = state.data;
    final hotels = details.properties
        .map(
          (property) => SpecificOfferItemModel(
            id: property.id,
            title: property.name,
            imagePath: property.image,
          ),
        )
        .toList();
    final selectedIndex = hotels.indexWhere(
      (item) => item.id == details.selectedPropertyId,
    );

    void openDetails(int propertyId, String image) {
      navigateTo(
        context,
        PropertyDetailsPage(
          propertyId: propertyId,
          images: image.isNotEmpty ? [image] : [],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        children: [
          SpecificOffersHeaderWidget(
            imagePath: details.effectiveBannerImage,
          ),
          Expanded(
            child: Transform.translate(
              offset: Offset(0, -26.h),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.scaffoldColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    8.h.verticalSpace,
                    if (hotels.isNotEmpty)
                      SpecificOffersHotelsChipsWidget(
                        hotels: hotels,
                        selectedIndex: selectedIndex < 0 ? 0 : selectedIndex,
                        onSelect: (index) {
                          ref
                              .read(specificOfferDetailsProvider(offerId).notifier)
                              .selectProperty(hotels[index].id);
                        },
                      ),
                    8.h.verticalSpace,
                    CheckStateInGetApiDataWidget(
                      state: state,
                      widgetOfLoading: const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      refresh: () {
                        ref
                            .read(specificOfferDetailsProvider(offerId).notifier)
                            .refresh();
                      },
                      widgetOfData: SpecificOffersListWidget(
                        offers: details.units,
                        onOfferTap: (offer) {
                          openDetails(offer.propertyId, offer.image);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


