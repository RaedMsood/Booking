import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/shimmer_widget.dart';
import 'rating_booking_widget.dart';

class ShimmerBookingCardWidget extends StatelessWidget {
  const ShimmerBookingCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          padding: EdgeInsets.all(12.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ShimmerWidget(
                      child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                    width: 60.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: Colors.white,
                    ),
                  )),
                  SizedBox(width: 8.w),
                  ShimmerWidget(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: Colors.white,
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
                    height: 18.h,
                    width: 60.w,
                  )),
                  const Spacer(),
                  const ShimmerWidget(child:  RatingBookingWidget(rating: 0)),
                ],
              ),
              const Divider(thickness: 0.5, color: Color(0xffF0F0F0)),
              Row(
                children: [
                  ShimmerWidget(
                      child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: Colors.white,
                    ),
                    height: 50.h,
                    width: 65.w,
                  )),
                  SizedBox(width: 12.w),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerWidget(
                          child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.sp, vertical: 4.sp),
                        height: 12.h,
                        width: 160.w,
                      )),
                      4.h.verticalSpace,
                      ShimmerWidget(
                          child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.sp, vertical: 4.sp),
                        height: 12.h,
                        width: 80.w,
                      )),
                      4.h.verticalSpace,
                      ShimmerWidget(
                          child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.r),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.sp, vertical: 4.sp),
                        height: 12.h,
                        width: 80.w,
                      )),
                    ],
                  ),
                  // ShimmerWidget(
                  //   child: InfoHotelInCardBookingWidget(
                  //     title: '',
                  //     location:
                  //     ' , ',
                  //     count: 1,
                  //     price:100,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
