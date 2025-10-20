import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class DesginButtonInAddBookingWidget extends StatelessWidget {
  const DesginButtonInAddBookingWidget({super.key,required this.button});

  final Widget? button;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 66.h,
          width: double.infinity,
          color: Colors.white,
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 14.w,vertical: 8.h),
          child:button,)
      ],
    );
  }
}
