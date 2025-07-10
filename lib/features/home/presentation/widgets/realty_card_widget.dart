import 'package:booking/core/widgets/auto_size_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../../../core/widgets/rating_bar_widget.dart';

class RealtyCardWidget extends StatelessWidget {
  const RealtyCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom:8.h),
      child: Stack(
         alignment: Alignment.bottomLeft,

      children: [

          Column(
            children: [
              Card(
                elevation: 0.8,
                shadowColor: AppColors.greySwatch.shade50.withOpacity(.2),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        OnlineImagesWidget(
                          imageUrl:
                          "https://www.alaraby.co.uk/sites/default/files/media/images/6A56AE3C-62E8-4A83-98CE-D00CE8260D5D.jpg",
                          size: Size(double.infinity, 180.h),
                          borderRadius: 18.r, // لأن Card أصبح مسؤول عن الـ border
                        ),
                        // PositionedDirectional(
                        //   top: 10.h,
                        //   start: 10,
                        //   child: Container(
                        //     padding: EdgeInsets.all(7.sp),
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(28.r),
                        //     ),
                        //     child: InkWell(
                        //       onTap: () {},
                        //       child: SvgPicture.asset(
                        //         AppIcons.favorite,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeTextWidget(
                                text: "فندق أم القرى السياحي",
                                fontSize: 13.sp,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.5.h),
                                decoration: BoxDecoration(
                                   color: const Color(0xfffef4d4).withOpacity(.8),

                                  borderRadius: BorderRadius.circular(28.r),
                                ),
                                child: Row(
                                  children: [
                                    AutoSizeTextWidget(
                                      text: "4",
                                      fontSize: 10.4.sp,
                                      colorText: const Color(0xfffbcc2b),
                                    ),
                                    2.5.w.horizontalSpace,
                                    RatingBarWidget(
                                      evaluation: 4,
                                      length: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          4.h.verticalSpace,
                          Divider(color: AppColors.scaffoldColor,),
                          4.h.verticalSpace,

                          Row(
                            children: [
                              SvgPicture.asset(
                                AppIcons.location,
                                color: AppColors.fontColor,
                                height: 15.h,
                              ),
                              4.w.horizontalSpace,
                              AutoSizeTextWidget(
                                text: "سعوان هبرة",
                                fontSize: 10.5.sp,
                                colorText: AppColors.fontColor,
                              ),


                            ],
                          ),
                          // 2.h.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              Container(
                width: double.infinity,
                height: 15.h,
                color: Colors.transparent,
              ),


            ],
          ),
        Card(
          // margin: EdgeInsets.symmetric(horizontal: 14.w),
          // padding: EdgeInsets.all(7.sp),
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(28.r),
          // ),
          elevation: 0.8,
          margin: EdgeInsets.symmetric(horizontal: 14.w),
          shadowColor: AppColors.greySwatch.shade50.withOpacity(.4),
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(38.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                AppIcons.favorite,
                height: 24.h,
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }
}

