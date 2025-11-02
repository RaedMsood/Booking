import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonBottomNavigationBarDesignWidget extends StatelessWidget {
  final Widget child;

  const ButtonBottomNavigationBarDesignWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 2.r,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
