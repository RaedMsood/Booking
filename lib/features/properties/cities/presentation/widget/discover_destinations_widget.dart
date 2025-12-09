import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/city_model.dart';
import '../pages/cities_page.dart';
import 'city_card_for_home_page_widget.dart';

class DiscoverDestinationsWidget extends StatelessWidget {
  final List<CityModel> cities;

  const DiscoverDestinationsWidget({super.key, required this.cities});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeTextWidget(
                text: S.of(context).discoverOurDestinations,
                colorText: AppColors.mainColorFont,
                fontSize: 13.6.sp,
              ),
              GestureDetector(
                onTap: () {
                  navigateTo(context, const DestinationsPage());
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.8.w, vertical: 2.8.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(40.r),
                    border: Border.all(
                      color: AppColors.greySwatch.shade400.withValues(alpha:.29),
                      width: 1.w,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      2.w.horizontalSpace,
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.4.h),
                        child: AutoSizeTextWidget(
                          text: S.of(context).more,
                          fontSize: 8.8.sp,
                          minFontSize: 6,
                          colorText: AppColors.greySwatch.shade400,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      1.5.w.horizontalSpace,
                      Icon(
                        Directionality.of(context) == TextDirection.rtl
                            ? Icons.keyboard_arrow_left_sharp
                            : Icons.keyboard_arrow_right_sharp,
                        size: 14.4.sp,
                        color: AppColors.greySwatch.shade400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 125.h,
          child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              children: cities.map((item) {
                return Row(
                  children: [
                    CityCardForHomePageWidget(city: item),
                    12.w.horizontalSpace,
                  ],
                );
              }).toList()),
        ),
      ],
    );
  }
}
