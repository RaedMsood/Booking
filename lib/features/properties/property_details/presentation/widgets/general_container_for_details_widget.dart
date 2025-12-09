import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralContainerForDetailsWidget extends StatelessWidget {
  final Widget child;

  const GeneralContainerForDetailsWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
      color: Colors.white,
      child: child,
    );
  }
}
