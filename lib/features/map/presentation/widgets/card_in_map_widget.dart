import 'package:booking/core/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../../../core/widgets/rating_bar_widget.dart';

class ShimmerCardInMapWidget extends StatelessWidget {
  const ShimmerCardInMapWidget({super.key});

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
                ShimmerWidget(
                  child: SizedBox(
                    height: 95.h,
                    child: OnlineImagesWidget(
                      imageUrl: '',
                      size: Size(double.infinity, 95.h),
                      borderRadius: 16.r,
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
                        child: ShimmerWidget(
                          child: Container(
                            height: 18.h,
                            width: 180.w,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10.r)
                            ),                          ),
                        ),
                      ),
                      6.w.horizontalSpace,
                      ShimmerWidget(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.4.h),
                          decoration: BoxDecoration(
                            color: const Color(0xfffef4d4).withOpacity(.8),
                            borderRadius: BorderRadius.circular(28.r),
                          ),
                          child: Row(
                            children: [

                              1.8.w.horizontalSpace,
                              RatingBarWidget(
                                evaluation: 4,
                                length: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  4.h.verticalSpace,
                  4.w.horizontalSpace,
                  ShimmerWidget(
                    child: Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.r)
                      ),
                      child: Flexible(
                        child: ShimmerWidget(
                          child: AutoSizeTextWidget(
                            text: "          ",
                            fontSize: 10.5.sp,
                            colorText: Color(0xff292D32),
                            fontWeight: FontWeight.w400,
                            minFontSize: 10,
                          ),
                        ),
                      ),
                    ),
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
