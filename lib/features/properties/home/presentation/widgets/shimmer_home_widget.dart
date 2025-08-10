import 'package:booking/core/widgets/shimmer_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ShimmerHomeWidget extends StatelessWidget {
  const ShimmerHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        6.h.verticalSpace,

        SizedBox(
          height: 104.h,
          width: double.infinity,
          child: CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (context, index, realIdx) {
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: ShimmerPlaceholderWidget());
            },
            options: CarouselOptions(
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              reverse: false,
              enableInfiniteScroll: false,
              viewportFraction: 0.93,
              enlargeCenterPage: false,
              padEnds: true,
            ),
          ),
        ),
        4.5.h.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerPlaceholderWidget(
                height: 18.h,
                width: 146.w,
                borderRadius: 4.r,
              ),
              ShimmerPlaceholderWidget(
                height: 20.h,
                width: 58.w,
                borderRadius: 40.r,
              ),
            ],
          ),
        ),
        6.h.verticalSpace,
        SizedBox(
          height: 125.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            itemBuilder: (context, index) {
              return ShimmerPlaceholderWidget(
                height: 125.h,
                width: 114.w,
              );
            },
            separatorBuilder: (context, index) => 12.w.horizontalSpace,
            itemCount: 4,
          ),
        ),
        12.h.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerPlaceholderWidget(
                height: 18.h,
                width: 138.w,
                borderRadius: 4.r,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ShimmerPlaceholderWidget(
                    height: 19.h,
                    width: 21.w,
                    borderRadius: 2.5.r,
                  ),
                  10.w.horizontalSpace,
                  ShimmerPlaceholderWidget(
                    height: 19.h,
                    width: 21.w,
                    borderRadius: 2.5.r,
                  ),
                  2.w.horizontalSpace,
                ],
              ),
            ],
          ),
        ),
        4.h.verticalSpace,
      ],
    );
  }
}
