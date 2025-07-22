import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../../../core/widgets/rating_bar_widget.dart';

class CardInMapWidget extends StatelessWidget {
  const CardInMapWidget({super.key});

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
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [

                SizedBox(
                  height: 95.h,
                    child: OnlineImagesWidget(
                      imageUrl: 'https://media.istockphoto.com/id/2110310187/photo/luxury-tropical-pool-villa-at-dusk.jpg?s=1024x1024&w=is&k=20&c=FfMY-QLqiixCQprNhrs5vmHZn1_vHqxKj3CWBRQsJ9M=',
                      size: Size(double.infinity, 95.h),
                      borderRadius: 16.r,
                    ),
                ),

                PositionedDirectional(
                  top: 10.h,
                  start: 10.w,
                  child: Container(
                    padding: EdgeInsets.all(6.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        AppIcons.favorite,
                      ),
                    ),
                  ),
                ),

              ],
            ),
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
                          text: "فندق ام القرى السياحي",
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
                              text: '4',
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
                  4.h.verticalSpace,
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.location,
                        color: Color(0xff292D32),
                        height: 15.h,
                      ),
                      4.w.horizontalSpace,
                      Flexible(
                        child: AutoSizeTextWidget(
                          text: "سعوان , هبرة",
                          fontSize: 10.5.sp,
                          colorText: Color(0xff292D32),
                          fontWeight: FontWeight.w400,
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
