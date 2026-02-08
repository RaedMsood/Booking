import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/city_model.dart';
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
            ],
          ),
        ),
        SizedBox(
          height: 125.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            itemCount: cities.length + 1,
            itemBuilder: (context, index) {
              if (index < cities.length) {
                return Padding(
                  padding: EdgeInsetsDirectional.only(end: 12.w),
                  child: CityCardForHomePageWidget(city: cities[index]),
                );
              }

              // آخر عنصر: قريباً...
              return Container(
                height: 125.h,
                width: 114.w,
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 6.h,
                ),
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(AppImages.logo),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.grey.shade500,
                ),
                child: AutoSizeTextWidget(
                  text: 'قريباً...',
                  colorText: Colors.white,
                  fontSize: 12.6.sp,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
