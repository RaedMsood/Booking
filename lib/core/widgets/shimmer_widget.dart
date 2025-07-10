import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;
  final Color? baseColor;

  const ShimmerWidget({super.key, required this.child, this.baseColor});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey[100]!,
      highlightColor: Colors.grey[300]!,
      child: child,
    );
  }
}

class ShimmerPlaceholderWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const ShimmerPlaceholderWidget({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
          width: width ?? double.infinity,
          height: height ?? 100.h,
          decoration: BoxDecoration(
            color: AppColors.primarySwatch.shade100,
            borderRadius: BorderRadius.circular(4.r),
          )),
    );
  }
}
