import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CounterButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const CounterButtonWidget({super.key, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => Container(
    width: 40.w,
    height: 40.h,
    decoration: BoxDecoration(
      color: const Color(0xFFF2F2F2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: IconButton(
      padding: EdgeInsets.zero,
      icon: Icon(
        icon,
        size: 18,
      ),
      onPressed: onTap,
    ),
  );
}
