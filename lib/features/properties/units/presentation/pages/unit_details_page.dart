import 'package:booking/core/state/check_state_in_get_api_data_widget.dart';
import 'package:booking/features/properties/units/presentation/riverpod/unit_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../property_details/presentation/widgets/sliver_app_bar_details_widget.dart';
import '../widgets/unit_details_data_widget.dart';
import '../widgets/unit_features_widget.dart';

class UnitDetailsPage extends ConsumerWidget {
  final int unitId;
  const UnitDetailsPage( {super.key,required this.unitId});

  @override
  Widget build(BuildContext context,ref) {
    var state = ref.watch(getUnitDetailsProvider(unitId));

    return Scaffold(
      body: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfData: CustomScrollView(
          slivers: [
             SliverAppBarDetailsWidget(
              isFavorite: false,
               images: state.data.images,
            ),
            SliverToBoxAdapter(
              child: UnitDetailsDataWidget(
                name: state.data.name,
                description: state.data.description,
                attachments: state.data.attachments,
                maxGuests: state.data.maxGuests,
              ),
            ),
            // SliverToBoxAdapter(
            //   child: DepositWidget(),
            // ),

            SliverToBoxAdapter(
              child: UnitFeaturesWidget(features: state.data.features,),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ButtonBottomNavigationBarDesignWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: "السعر الإجمالي",
                  fontSize: 11.4.sp,
                  colorText: AppColors.greyColor,
                  fontWeight: FontWeight.w400,
                ),
                6.h.verticalSpace,
                Row(
                  children: [
                    AutoSizeTextWidget(
                      text: state.data.price.toString(),
                      fontSize: 14.sp,
                      colorText: AppColors.primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    4.w.horizontalSpace,
                    AutoSizeTextWidget(
                      text: "ريال",
                      fontSize: 11.4.sp,
                      colorText: AppColors.greyColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
            DefaultButtonWidget(
              text: 'حجز الان',
              height: 48.h,
              width: 128.w,
              textSize: 12.sp,
              borderRadius: 34.r,
              onPressed: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
