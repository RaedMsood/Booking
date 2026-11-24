import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../../properties/home/data/model/property_data_model.dart';
import '../../../properties/property_details/presentation/pages/property_details_page.dart';

class ChatHotelCardWidget extends StatelessWidget {
  final PropertyDataModel property;

  const ChatHotelCardWidget({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = property.mainImageUrls.isNotEmpty;
    final firstImage = hasImage ? property.mainImageUrls.first : '';

    return Container(
      width: 220.w,
      margin: EdgeInsets.only(left: 12.w, top: 8.h, bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColors.greySwatch.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: () {
            navigateTo(
              context,
              PropertyDetailsPage(
                propertyId: property.id,
                images: property.mainImageUrls,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image with Rating Badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.r),
                      topRight: Radius.circular(14.r),
                    ),
                    child: SizedBox(
                      height: 110.h,
                      width: double.infinity,
                      child: hasImage
                          ? OnlineImagesWidget(
                              imageUrl: firstImage,
                              fit: BoxFit.cover,
                              borderRadius: 0,
                            )
                          : Container(
                              color: AppColors.greySwatch.shade200,
                              child: Icon(
                                Icons.hotel,
                                size: 36.sp,
                                color: AppColors.greyColor,
                              ),
                            ),
                    ),
                  ),
                  // Rating Badge
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: AppColors.secondaryColor,
                            size: 14.sp,
                          ),
                          SizedBox(width: 3.w),
                          AutoSizeTextWidget(
                            text: property.rating.toString(),
                            fontSize: 10.sp,
                            colorText: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Property Type Badge
                  if (property.type.isNotEmpty)
                    Positioned(
                      top: 8.h,
                      left: 8.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: AutoSizeTextWidget(
                          text: property.type,
                          fontSize: 9.5.sp,
                          colorText: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              // Content Info
              Padding(
                padding: EdgeInsets.all(10.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text: property.name,
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.bold,
                      maxLines: 1,
                      colorText: AppColors.mainColorFont,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 13.sp,
                          color: AppColors.fontColor,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: AutoSizeTextWidget(
                            text: '${property.city} - ${property.district}',
                            fontSize: 10.5.sp,
                            colorText: AppColors.fontColor,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeTextWidget(
                          text: 'عرض الغرف والتفاصيل',
                          fontSize: 10.5.sp,
                          colorText: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 11.sp,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
