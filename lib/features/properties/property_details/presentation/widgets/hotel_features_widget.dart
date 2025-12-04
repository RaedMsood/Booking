import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_svg_widget.dart';
import '../../data/models/features_model.dart';

class HotelFeaturesWidget extends StatelessWidget {
  final List<FeaturesModel> features;

  const HotelFeaturesWidget({super.key, required this.features});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        SizedBox(
          height: 75.h,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.scaffoldColor.withOpacity(.8),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: OnlineSvgWidget(
                        imageUrl: features[index].icon,
                        color: const Color(0xff605a65),
                        size: Size(28.w, 20.h),
                        logoWidth: 0,
                      ),
                    ),
                    6.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: features[index].name,
                      fontSize: 9.5.sp,
                      fontWeight: FontWeight.w300,
                      colorText: AppColors.greyColor,
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 8.w),
            itemCount: features.length,
          ),
        ),
        Container(
          height: 75.h,
          width: 44.w,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white,
                Colors.white70,
                Colors.white38,
                Colors.white24,
              ],
              begin: AlignmentGeometry.centerLeft,
              end: AlignmentGeometry.centerRight,
            ),
          ),
        ),
      ],
    );
  }
}
