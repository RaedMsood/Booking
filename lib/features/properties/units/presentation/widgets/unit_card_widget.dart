import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../data/model/units_model.dart';
import '../pages/unit_details_page.dart';
import '../../../../../generated/l10n.dart';
import 'unit_price_widget.dart';

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
    final bedsText = _bedsText(context);
    void openUnitDetails() {
      navigateTo(
        context,
        UnitDetailsPage(unitId: units.id),
      );
    }

    return GestureDetector(
      onTap: openUnitDetails,
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    OnlineImagesWidget(
                      imageUrl: units.image.toString(),
                      fit: BoxFit.cover,
                      size: Size(100.w, 86.h),
                      borderRadius: 50.r,
                      smoothCorners: true,
                    ),
                    10.w.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeTextWidget(
                            text: units.name,
                            maxLines: 2,
                            fontSize: 12.sp,
                            minFontSize: 10,
                            colorText: AppColors.mainColorFont,
                            textAlign: TextAlign.start,
                          ),
                          5.h.verticalSpace,
                          AutoSizeTextWidget(
                            text: _guestsText(),
                            fontSize: 10.sp,
                            maxLines: 1,
                            minFontSize: 8,
                            fontWeight: FontWeight.w400,
                            colorText: const Color(0xff757575),
                            textAlign: TextAlign.start,
                          ),
                          if (units.hasDiscount) ...[
                            6.h.verticalSpace,
                            _UnitOfferBadgeWidget(
                              text: units.offerDescription.isNotEmpty
                                  ? units.offerDescription
                                  : 'عرض خاص',
                            ),
                          ],
                          if (bedsText != null) ...[
                            6.h.verticalSpace,
                            _UnitInfoChip(
                              iconPath: AppIcons.bed,
                              text: bedsText,
                            ),
                          ],
                          8.h.verticalSpace,
                          UnitPriceWidget(
                            currentPrice: units.effectivePrice,
                            originalPrice: units.originalPriceBeforeDiscount,
                            currentFontSize: 12.sp,
                            spacing: 8,
                            currentPriceWeight: FontWeight.bold,
                            currentCurrencyWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                10.h.verticalSpace,
                DefaultButtonWidget(
                  onPressed: openUnitDetails,
                  text: 'احجز الآن',
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UnitInfoChip extends StatelessWidget {
  const _UnitInfoChip({
    required this.iconPath,
    required this.text,
  });

  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: const Color(0xffF6F8FC),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 10.h,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          4.w.horizontalSpace,
          Flexible(
            child: AutoSizeTextWidget(
              text: text,
              fontSize: 8.sp,
              minFontSize: 7,
              maxLines: 1,
              colorText: AppColors.mainColorFont,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

class _UnitOfferBadgeWidget extends StatelessWidget {
  const _UnitOfferBadgeWidget({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: const Color(0xffEAFFF1),
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: const Color(0xffB6FFCE),
          width: 1.2,
        ),

      ),
      alignment: AlignmentGeometry.center,
      child: AutoSizeTextWidget(
        text: text,
        fontSize: 8.sp,
        minFontSize: 8,
        maxLines: 2,
        colorText: const Color(0xff04B440),
        textAlign: TextAlign.center,
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
