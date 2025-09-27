import 'package:booking/core/helpers/navigateTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/rating_bar_widget.dart';
import '../../../property_details/presentation/pages/property_details_page.dart';
import '../../data/model/property_data_model.dart';
import 'property_photos_widget.dart';

class PropertyCardWidget extends StatelessWidget {
  final PropertyDataModel property;
  final int viewType;
  final bool propertiesByCity;

  const PropertyCardWidget({
    super.key,
    required this.property,
    this.viewType = 2,
    this.propertiesByCity = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          PropertyDetailsPage(
            propertyId: property.id,
            images: property.mainImageUrls,
          ),
        );
      },
      child: Card(
        elevation: propertiesByCity ? 1 : 0.6,
        shadowColor: propertiesByCity
            ? AppColors.greySwatch.shade50.withOpacity(.6)
            : AppColors.greySwatch.shade50.withOpacity(.04),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PropertyPhotosWidget(
              image: property.mainImageUrls,
              height: 120.h,
              idProperties: property.id,
              isFavorite: property.isFavorite,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: AutoSizeTextWidget(
                              text: property.name,
                              fontSize: 12.sp,
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
                                  text: property.rating.toStringAsFixed(1),
                                  fontSize: 10.5.sp,
                                  colorText: AppColors.secondaryColor,
                                ),
                                1.8.w.horizontalSpace,
                                RatingBarWidget(
                                  evaluation: property.rating.toDouble() ?? 0.0,
                                  length: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    4.h.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.location,
                                color: AppColors.fontColor,
                                height: 14.h,
                              ),
                              4.w.horizontalSpace,
                              Flexible(
                                child: AutoSizeTextWidget(
                                  text:
                                      "${property.city}, ${property.district}",
                                  fontSize: 10.4.sp,
                                  colorText: AppColors.fontColor,
                                  minFontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
