import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class PropertyCardShell extends StatelessWidget {
  final bool propertiesByCity;
  final Widget child;

  const PropertyCardShell({
    super.key,
    required this.propertiesByCity,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: propertiesByCity ? 1 : 0.6,
      shadowColor: propertiesByCity
          ? AppColors.greySwatch.shade50.withValues(alpha: .6)
          : AppColors.greySwatch.shade50.withValues(alpha: .04),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: child,
    );
  }
}

