import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../../../../booking/presentation/page/details_of_book_in_add_page.dart';
import '../../../../user/presentation/pages/log_in_page.dart';
import '../../../property_details/presentation/widgets/general_container_for_details_widget.dart';
import '../../../property_details/presentation/widgets/sliver_app_bar_details_widget.dart';
import '../riverpod/unit_riverpod.dart';
import '../widgets/unit_area_and_beds_sliver_widget.dart';
import '../widgets/unit_details_data_widget.dart';
import '../widgets/unit_features_widget.dart';

class UnitDetailsPage extends ConsumerWidget {
  final int unitId;

  const UnitDetailsPage({super.key, required this.unitId});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getUnitDetailsProvider(unitId));

    return Scaffold(
      body: CheckStateInGetApiDataWidget(
        state: state,
        refresh: () {
          ref.invalidate(getUnitDetailsProvider(unitId));
        },
        widgetOfData: CustomScrollView(
          slivers: [
            SliverAppBarDetailsWidget(
              isFavorite: false,
              images: state.data.images,
              idProperties: state.data.id,
              isUnit: true,
              title: state.data.name,
            ),
            SliverToBoxAdapter(
              child: UnitDetailsDataWidget(
                name: state.data.name,
                description: state.data.description,
                attachments: state.data.attachments,
                maxGuests: state.data.maxGuests,
              ),
            ),
            SliverToBoxAdapter(
              child: GeneralContainerForDetailsWidget(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text: S.of(context).deposit,
                      fontSize: 12.5.sp,
                    ),
                    8.h.verticalSpace,
                    PriceAndCurrencyWidget(
                      price: state.data.deposit.toString(),
                      secondColor: AppColors.greyColor,
                    )
                  ],
                ),
              ),
            ),
            UnitAreaAndBedsSliverWidget(
              singleBed: state.data.singleBed,
              doubleBed: state.data.doubleBed,
              length: state.data.length,
              width: state.data.width,
            ),
            SliverToBoxAdapter(
              child: UnitFeaturesWidget(
                features: state.data.features,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          state.stateData == States.loading || state.stateData == States.error
              ? null
              : ButtonBottomNavigationBarDesignWidget(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeTextWidget(
                            text: S.of(context).grandTotal,
                            fontSize: 11.sp,
                            colorText: AppColors.greyColor,
                            // fontWeight: FontWeight.w400,
                          ),
                          4.h.verticalSpace,
                          PriceAndCurrencyWidget(
                            price: state.data.price.toString(),
                            fontSize: 13.4.sp,
                            secondColor: AppColors.primaryColor,
                            fontWeightSecondText: FontWeight.w500,
                          ),
                        ],
                      ),
                      DefaultButtonWidget(
                        text: S.of(context).bookNow,
                        height: 38.h,
                        width: 160.w,
                        textSize: 12.6.sp,
                        borderRadius: 34.r,
                        onPressed: () {
                          if (!Auth().loggedIn) {
                            navigateTo(context, const LogInPage());
                          } else {
                            navigateTo(
                              context,
                              DetailsOfBookInAddPage(
                                location: state.data.property.location,
                                image: state.data.property.images[0].toString(),
                                nameProp: state.data.property.name,
                                unitId: state.data.id,
                                totalPrice: state.data.price.toString(),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
    );
  }
}
