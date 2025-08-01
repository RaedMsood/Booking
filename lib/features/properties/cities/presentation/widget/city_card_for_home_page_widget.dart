import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../data/model/city_model.dart';
import '../pages/properties_by_city_page.dart';
import 'city_name_and_flag_widget.dart';

class CityCardForHomePageWidget extends StatelessWidget {
  final CityModel city;

  const CityCardForHomePageWidget(
      {super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          PropertiesByCityPage(cityId: city.id),
        );
      },
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          OnlineImagesWidget(
            imageUrl: city.image,
            size: Size(114.w, 125.h),
            borderRadius: 8.r,
          ),
          Container(
            height: 125.h,
            width: 114.w,
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              gradient: LinearGradient(
                colors: [
                  Colors.black12,
                  Colors.black12,
                  Colors.black12,
                  Colors.black26,
                  Colors.black38,
                  Colors.black45,
                  Colors.black87.withOpacity(.68),
                  Colors.black.withOpacity(.85),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: CityNameAndFlagWidget(
              cityName:city.name.toString() ,
              colorText: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 12.6.sp,
            ),
          ),
        ],
      ),
    );
  }
}
