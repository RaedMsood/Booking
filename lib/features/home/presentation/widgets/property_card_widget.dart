import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/rating_bar_widget.dart';
import '../../data/model/property_model.dart';
import 'property_photos_widget.dart';

class PropertyCardWidget extends StatelessWidget {
  final PropertyModel property;

  const PropertyCardWidget({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Card(
        elevation: 0.8,
        shadowColor: AppColors.greySwatch.shade50.withOpacity(.2),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertyPhotosWidget(image: property.mainImageUrls,),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: AutoSizeTextWidget(
                          text: property.name,
                          fontSize: 12.2.sp,
                          fontWeight: FontWeight.w500,
                          maxLines: 2,
                          minFontSize: 12,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      6.w.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.4.h),
                        decoration: BoxDecoration(
                          color: const Color(0xfffef4d4).withOpacity(.8),
                          borderRadius: BorderRadius.circular(28.r),
                        ),
                        child: Row(
                          children: [
                            AutoSizeTextWidget(
                              text: property.rating.toString(),
                              fontSize: 10.5.sp,
                              colorText: const Color(0xfffbcc2b),
                            ),
                            1.8.w.horizontalSpace,
                            RatingBarWidget(
                              evaluation: 4,
                              length: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  8.h.verticalSpace,
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.location,
                        color: AppColors.fontColor,
                        height: 15.h,
                      ),
                      4.w.horizontalSpace,
                      Flexible(
                        child: AutoSizeTextWidget(
                          text: "${property.city}, ${property.district}",
                          fontSize: 10.5.sp,
                          colorText: AppColors.fontColor,
                          minFontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  4.h.verticalSpace,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}