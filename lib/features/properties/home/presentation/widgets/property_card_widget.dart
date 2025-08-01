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
                                  text: property.rating.toString(),
                                  fontSize: 10.5.sp,
                                  colorText: AppColors.secondaryColor,
                                ),
                                1.8.w.horizontalSpace,
                                const RatingBarWidget(
                                  evaluation: 4,
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
                        //   Flexible(
                        //     child: AutoSizeTextWidget(
                        //       text: "${property.city}, ${property.district}",
                        //       fontSize: 10.2.sp,
                        //       colorText: AppColors.fontColor,
                        //       minFontSize: 10,
                        //     ),
                        //   ),
                        //   // Flexible(
                        //   //   child: AutoSizeTextWidget(
                        //   //     text: "${property.city}",
                        //   //     fontSize: 10.5.sp,
                        //   //     colorText: AppColors.greySwatch.shade400,
                        //   //     minFontSize: 10,
                        //   //   ),
                        //   // ),
                        //   SvgPicture.asset(
                        //     AppIcons.favoriteActive,
                        //     color: AppColors.primarySwatch.shade400,
                        //     //  color:Color(0xffda6b6e),
                        //     height: 22.h,
                        //   ),
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
// Widget _buildRawCard() {
//   return Container(
//     decoration: BoxDecoration(
//       color: AppColors.whiteColor,
//       // boxShadow: [
//       //   BoxShadow(
//       //     color: Colors.black.withOpacity(.05),
//       //     blurRadius: 4.r,
//       //   ),
//       // ],
//       borderRadius: BorderRadius.circular(8.r),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // PropertyPhotosWidget(
//         //   image: property.mainImageUrls,
//         //   height: 0.h,
//         // ),
//         SizedBox(
//           height: 180.h,
//           child: PageView.builder(
//             itemCount: property.mainImageUrls.length,
//             itemBuilder: (context, imageIndex) {
//               return OnlineImagesWidget(
//                 imageUrl: property.mainImageUrls[imageIndex],
//                 size: Size(double.infinity, 180.h),
//                 borderRadius: 8.r,
//               );
//             },
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.all(8.sp),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Flexible(
//                     child: AutoSizeTextWidget(
//                       text: property.name,
//                       fontSize: 12.2.sp,
//                       fontWeight: FontWeight.w500,
//                       maxLines: 2,
//                       minFontSize: 12,
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                   6.w.horizontalSpace,
//                   Container(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 8.w, vertical: 2.4.h),
//                     decoration: BoxDecoration(
//                       color: const Color(0xfffef4d4).withOpacity(.8),
//                       borderRadius: BorderRadius.circular(28.r),
//                     ),
//                     child: Row(
//                       children: [
//                         AutoSizeTextWidget(
//                           text: property.rating.toString(),
//                           fontSize: 10.5.sp,
//                           colorText: const Color(0xfffbcc2b),
//                         ),
//                         1.8.w.horizontalSpace,
//                         RatingBarWidget(
//                           evaluation: 4,
//                           length: 1,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               8.h.verticalSpace,
//               Row(
//                 children: [
//                   SvgPicture.asset(
//                     AppIcons.location,
//                     color: AppColors.fontColor,
//                     height: 15.h,
//                   ),
//                   4.w.horizontalSpace,
//                   Flexible(
//                     child: AutoSizeTextWidget(
//                       text: "${property.city}, ${property.district}",
//                       fontSize: 10.5.sp,
//                       colorText: AppColors.fontColor,
//                       minFontSize: 10,
//                     ),
//                   ),
//                 ],
//               ),
//               4.h.verticalSpace,
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildColumnCard() {
//   return Container(
//     // padding: EdgeInsets.all(12.r),
//     decoration: BoxDecoration(
//       color: Colors.white,
//       // boxShadow: [
//       //   BoxShadow(
//       //     color: Colors.black.withOpacity(.05),
//       //     blurRadius: 4.r,
//       //   ),
//       // ],
//       borderRadius: BorderRadius.circular(8.r),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // PropertyPhotosWidget(
//         //   image: property.mainImageUrls,
//         //   height: 100.h,
//         // ),
//         SizedBox(
//           height: 100.h,
//           child: PageView.builder(
//             itemCount: property.mainImageUrls.length,
//             itemBuilder: (context, imageIndex) {
//               return OnlineImagesWidget(
//                 imageUrl: property.mainImageUrls[imageIndex],
//                 size: Size(double.infinity, 100.h),
//                 borderRadius: 8.r,
//               );
//             },
//           ),
//         ),
//         SizedBox(height: 12.h),
//         // AutoSizeTextWidget(
//         //   text: property.name,
//         //   fontSize: 12.2.sp,
//         //   fontWeight: FontWeight.w500,
//         //   maxLines: 2,
//         //   minFontSize: 12,
//         //   textAlign: TextAlign.start,
//         // ),
//         SizedBox(height: 8.h),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.4.h),
//           decoration: BoxDecoration(
//             color: const Color(0xfffef4d4).withOpacity(.8),
//             borderRadius: BorderRadius.circular(28.r),
//           ),
//           child: Row(
//             children: [
//               AutoSizeTextWidget(
//                 text: property.rating.toString(),
//                 fontSize: 10.5.sp,
//                 colorText: const Color(0xfffbcc2b),
//               ),
//               1.8.w.horizontalSpace,
//               RatingBarWidget(
//                 evaluation: 4,
//                 length: 1,
//               ),
//             ],
//           ),
//         ),
//         8.h.verticalSpace,
//         Row(
//           children: [
//             SvgPicture.asset(
//               AppIcons.location,
//               color: AppColors.fontColor,
//               height: 15.h,
//             ),
//             4.w.horizontalSpace,
//             Flexible(
//               child: AutoSizeTextWidget(
//                 text: "${property.city}, ${property.district}",
//                 fontSize: 10.5.sp,
//                 colorText: AppColors.fontColor,
//                 minFontSize: 10,
//               ),
//             ),
//           ],
//         ),
//         4.h.verticalSpace,
//       ],
//     ),
//   );
// }
}
