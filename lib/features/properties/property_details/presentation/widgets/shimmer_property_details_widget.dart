import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/shimmer_widget.dart';
import 'general_container_for_details_widget.dart';
import 'sliver_app_bar_details_widget.dart';

class ShimmerPropertyDetailsWidget extends StatelessWidget {
  final List<String> images;

  const ShimmerPropertyDetailsWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBarDetailsWidget(
          images: images,
          isLoading: true,
          idProperties: 1,
          title: "",
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
            padding: EdgeInsets.symmetric(vertical: 8.h),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: ShimmerPlaceholderWidget(
                              height: 18.h,
                              width: 180.w,
                            ),
                          ),
                          ShimmerPlaceholderWidget(
                            height: 20.h,
                            width: 100.w,
                          ),
                        ],
                      ),
                      10.h.verticalSpace,
                      ShimmerPlaceholderWidget(
                        height: 12.h,
                      ),
                      4.h.verticalSpace,
                      ShimmerPlaceholderWidget(
                        height: 12.h,
                        width: 260.w,
                      ),
                      4.h.verticalSpace,
                      ShimmerPlaceholderWidget(
                        height: 12.h,
                        width: 180.w,
                      ),
                    ],
                  ),
                ),
                8.h.verticalSpace,
                SizedBox(
                  height: 75.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                    itemBuilder: (context, index) {
                      return ShimmerPlaceholderWidget(width: 90.w);
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 8.w),
                    itemCount: 4,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ShimmerPlaceholderWidget(
                    height: 20.h,
                  ),
                ),
                48.w.horizontalSpace,
                Expanded(
                  child: ShimmerPlaceholderWidget(
                    height: 20.h,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: GeneralContainerForDetailsWidget(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: ShimmerPlaceholderWidget(
                          height: 17.h,
                          width: 180.w,
                        ),
                      ),
                      ShimmerPlaceholderWidget(
                        height: 15.h,
                        width: 100.w,
                      ),
                    ],
                  ),
                  10.h.verticalSpace,
                  Row(
                    children: [
                      ShimmerPlaceholderWidget(
                        height: 12.h,
                        width: 80.w,
                      ),
                      4.w.horizontalSpace,
                      ShimmerPlaceholderWidget(
                        height: 12.h,
                        width: 80.w,
                      ),
                      4.w.horizontalSpace,
                      ShimmerPlaceholderWidget(
                        height: 12.h,
                        width: 80.w,
                      ),
                    ],
                  ),
                  10.h.verticalSpace,
                  ShimmerPlaceholderWidget(
                    height: 160.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
