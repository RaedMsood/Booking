import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/app_colors.dart';

class DesignForBottomNavigationBarWidget extends StatelessWidget {
  final String icon;
  final bool active;

  final String? activeIcon;
  final String label;
  final Function()? onTap;

  const DesignForBottomNavigationBarWidget({
    super.key,
    required this.icon,
    this.activeIcon,
    required this.label,
    this.active = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        child: Container(
          padding:
              EdgeInsets.only(left: 8.w, right: 8.h, top: 8.h, bottom: 2.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: SvgPicture.asset(
                  active ? activeIcon ?? icon : icon,
                  key: ValueKey<String>(active ? activeIcon ?? icon : icon),
                  color: active ? AppColors.primaryColor : null,
                  height: active ? 21.5.h : 20.h,
                ),
              ),
              2.h.verticalSpace,
              Text(
                label,
                style: TextStyle(
                  color: active
                      ? AppColors.primaryColor
                      : AppColors.greySwatch.shade400,
                  fontSize: 8.4.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'NotoKufi',
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
