import 'package:booking/core/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../riverpod/cities_riverpod.dart';
import '../widget/city_name_and_flag_widget.dart';
import 'properties_by_city_page.dart';

class DestinationsPage extends ConsumerWidget {
  const DestinationsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getAllCitiesProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: AutoSizeTextWidget(
          text: "الوجهات",
          fontSize: 15.5.sp,
        ),
        leadingWidth: 67.w,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h).copyWith(top: 4.4.h),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const IconButtonWidget(),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.centerLeft,
            colors: [
              AppColors.primarySwatch.shade100.withOpacity(.99),
              AppColors.primarySwatch.shade50.withOpacity(.7),
              AppColors.scaffoldColor,
              AppColors.whiteColor,
              AppColors.scaffoldColor,
            ],
          ),
        ),
        child: SafeArea(
          child: CheckStateInGetApiDataWidget(
            state: state,
            widgetOfLoading: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 16.w,
              padding: EdgeInsets.all(14.sp),
              itemCount: 6,
              itemBuilder: (context, index) {
                final cardHeight = index == 0 ? 190.h : 220.h;

                return ShimmerPlaceholderWidget(
                  height: cardHeight,
                  width: double.infinity,
                );
              },
            ),
            widgetOfData: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 16.w,
              padding: EdgeInsets.all(14.sp),
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final cardHeight = index == 0 ? 190.h : 220.h;

                return GestureDetector(
                  onTap: () {
                    navigateTo(
                      context,
                      PropertiesByCityPage(cityId: state.data[index].id),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      OnlineImagesWidget(
                        imageUrl: state.data[index].image,
                        size: Size(double.infinity, cardHeight),
                        borderRadius: 8.r,
                      ),
                      Container(
                        height: cardHeight,
                        width: double.infinity,
                        padding: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black12,
                              Colors.black12,
                              Colors.black26,
                              Colors.black54,
                              Colors.black.withOpacity(.8),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: CityNameAndFlagWidget(
                          cityName: state.data[index].name.toString(),
                          fontWeight: FontWeight.w400,
                          colorText: Colors.white,
                          fontSize: 12.4.sp,
                          space: 4,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
