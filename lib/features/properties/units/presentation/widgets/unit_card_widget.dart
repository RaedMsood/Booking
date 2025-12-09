import 'dart:ui';

import 'package:booking/core/widgets/price_and_currency_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/units_model.dart';
import '../pages/unit_details_page.dart';

class UnitCardWidget extends StatelessWidget {
  final UnitsModel units;

  const UnitCardWidget({
    super.key,
    required this.units,
  });

  String _guestsText() {
    if (units.maxGuests == 1) {
      return S.current.personOne;
    } else if (units.maxGuests == 2) {
      return S.current.personTwo;
    } else {
      return '${units.maxGuests} ${S.current.personOther}';
    }
  }

  String? _bedsText(BuildContext context) {
    final num single = units.singleBed ;
    final num dbl = units.doubleBed ;

    final parts = <String>[];

    if (dbl > 0) {
      parts.add('${S.of(context).doubleBed} ${dbl.toInt()}');
    }

    if (single > 0) {
      parts.add('${S.of(context).singleBed} ${single.toInt()}');
    }

    if (parts.isEmpty) {
      return null;
    }

    return parts.join(' - ');
  }
  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final bedsText = _bedsText(context);
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          UnitDetailsPage(unitId: units.id),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Card(
          elevation: 0.8,
          shadowColor: AppColors.greySwatch.shade50.withValues(alpha: .04),
          color: AppColors.whiteColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            height: 180.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned.fill(
                  child: OnlineImagesWidget(
                    imageUrl: units.image.toString(),
                    size: Size(double.infinity, 180.h),
                    borderRadius: 0,
                  ),
                ),
                Positioned(
                  top: 8.h,
                  left: isRtl ? 8.w : null,
                  right: isRtl ? null : 8.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.6.h),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: PriceAndCurrencyWidget(
                      price: units.price,
                      fontSize: 9.4.sp,
                      fontSizeSecondText: 8.sp,
                      secondColor: AppColors.primaryColor,
                      fontWeightSecondText: FontWeight.w500,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(14.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 12.w)
                          .copyWith(bottom: 6.h, top: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5.h,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: AutoSizeTextWidget(
                                    text: units.name,
                                    fontSize: 11.sp,
                                    colorText: Colors.white,
                                    minFontSize: 10,
                                  ),
                                ),
                                6.w.horizontalSpace,
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.gender,
                                      height: 10.h,
                                      color:
                                          Colors.white.withValues(alpha: 0.9),
                                    ),
                                    2.w.horizontalSpace,
                                    AutoSizeTextWidget(
                                      text: _guestsText(),
                                      fontSize: 7.6.sp,
                                      minFontSize: 6,
                                      colorText:
                                          Colors.white.withValues(alpha: 0.9),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (bedsText != null)
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.bed,
                                height: 10.8.h,
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                              4.w.horizontalSpace,
                              Flexible(
                                child: AutoSizeTextWidget(
                                  text: bedsText,
                                  fontSize: 8.2.sp,
                                  minFontSize: 7,
                                  colorText:
                                      Colors.white.withValues(alpha: 0.9),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class UnitCardWidget extends StatelessWidget {
//   final UnitsModel units;
//   final String nameProp;
//   final String location;
//   final String image;
//
//   const UnitCardWidget(
//       {super.key,
//       required this.units,
//       required this.location,
//       required this.nameProp,
//       required this.image});
//
//   String _guestsText() {
//     if (units.maxGuests == 1) {
//       return S.current.personOne;
//     } else if (units.maxGuests == 2) {
//       return S.current.personTwo;
//     } else {
//       return '${units.maxGuests} ${S.current.personOther}';
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         navigateTo(
//           context,
//           UnitDetailsPage(
//             unitId: units.id,
//             image: image,
//             location: location,
//             nameProp: nameProp,
//           ),
//         );
//       },
//       child: Card(
//         elevation:  0.8,
//         shadowColor:  AppColors.greySwatch.shade50.withValues(alpha: .04),
//         color:  AppColors.whiteColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.r),
//           // side: BorderSide(color: AppColors.greySwatch.shade200)
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Flexible(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(8.r),
//                     topLeft: Radius.circular(8.r)),
//                 child: OnlineImagesWidget(
//                   imageUrl: units.image.toString(),
//                   size: Size(double.infinity, 120.h),
//                   borderRadius: 0,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 8.w).copyWith(top: 4.h,bottom: 8.h),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//
//                 children: [
//                   AutoSizeTextWidget(
//                     text: _guestsText(),
//                     fontSize: 8.sp,
//                     fontWeight: FontWeight.w400,
//                     colorText: AppColors.greyColor,
//
//                   ),
//                   AutoSizeTextWidget(
//                     text: units.name,
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w400,
//                     maxLines: 2,
//                     minFontSize: 11,
//                     textAlign: TextAlign.start,
//                   ),
//
//
//
//                   3.h.verticalSpace,
//
//
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               SvgPicture.asset(
//                                 AppIcons.gender,
//                                 height: 10.h,
//                                 color: AppColors.greySwatch.shade600,
//                               ),
//                               4.w.horizontalSpace,
//                               AutoSizeTextWidget(
//                                 text: "اسرة مزدوجة 4",
//                                 fontSize: 8.sp,
//                                 fontWeight: FontWeight.w400,
//                                 colorText: AppColors.greyColor,
//                               ),
//                             ],
//                           ),
//                           2.h.verticalSpace,
//                           Row(
//                             children: [
//                               SvgPicture.asset(
//                                 AppIcons.gender,
//                                 height: 10.h,
//                                 color: AppColors.greyColor,
//                               ),
//                               4.w.horizontalSpace,
//                               AutoSizeTextWidget(
//                                 text: "اسرة مفردة 4",
//                                 fontSize: 8.sp,
//                                 fontWeight: FontWeight.w400,
//                                 colorText: AppColors.greyColor,
//
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),],),
//                   3.h.verticalSpace,
//
//                   PriceAndCurrencyWidget(
//                     price: units.price,
//                     fontSize: 12.4.sp,
//                     fontSizeSecondText: 11.5.sp,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       // child: Container(
//       //   margin: EdgeInsets.only(bottom: 14.h),
//       //   decoration: BoxDecoration(
//       //     color: Colors.white,
//       //     borderRadius: BorderRadius.circular(10.r),
//       //     boxShadow: [
//       //       BoxShadow(
//       //         color: Colors.black.withValues(alpha: .02),
//       //         blurRadius: 1.r,
//       //       ),
//       //     ],
//       //   ),
//       //   child: Row(
//       //     crossAxisAlignment: CrossAxisAlignment.center,
//       //     mainAxisSize: MainAxisSize.max,
//       //     children: [
//       //       OnlineImagesWidget(
//       //         imageUrl: units.image.toString(),
//       //         size: Size(88.w, 76.h),
//       //         fit: BoxFit.cover,
//       //         borderRadius: 10.r,
//       //         logoWidth: 34.w,
//       //       ),
//       //       Flexible(
//       //         child: Padding(
//       //           padding: EdgeInsets.symmetric(horizontal: 12.w),
//       //           child: Column(
//       //             crossAxisAlignment: CrossAxisAlignment.start,
//       //             children: [
//       //               6.h.verticalSpace,
//       //               AutoSizeTextWidget(
//       //                 text: units.name,
//       //                 fontSize: 10.8.sp,
//       //                 colorText: AppColors.greySwatch.shade700,
//       //                 fontWeight: FontWeight.w400,
//       //                 maxLines: 2,
//       //               ),
//       //               6.h.verticalSpace,
//       //               Row(
//       //                 children: [
//       //                   SvgPicture.asset(
//       //                     AppIcons.gender,
//       //                     height: 13.5.h,
//       //                     color: Colors.black,
//       //                   ),
//       //                   4.w.horizontalSpace,
//       //                   Flexible(
//       //                     child: AutoSizeTextWidget(
//       //                       text: _guestsText(),
//       //                       fontSize: 9.6.sp,
//       //                       fontWeight: FontWeight.w500,
//       //                     ),
//       //                   ),
//       //                 ],
//       //               ),
//       //               6.h.verticalSpace,
//       //               PriceAndCurrencyWidget(
//       //                 price: units.price,
//       //                 fontSize: 11.6.sp,
//       //                 fontSizeSecondText: 10.5.sp,
//       //               ),
//       //               6.h.verticalSpace,
//       //             ],
//       //           ),
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }
