import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonBottomNavigationBarDesignWidget extends StatelessWidget {
  final Widget child;

  const ButtonBottomNavigationBarDesignWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 8.h, bottom: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 4.r,
          ),
        ],
      ),
      child: child,
    );
  }
}
