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
                active ? (activeIcon ?? icon) : icon,
                // إذا رغبت بأن يكون لون الأيقونة أبيض عندما تكون مفعّلة:
                color: active ?AppColors.primaryColor: AppColors.mainColorFont,
                height: active ? 22.h : 20.h,
              ),
            ),
            2.5.h.verticalSpace,
            Text(
              label,
              style: TextStyle(
                color: active
                    ? AppColors.primaryColor
                    :AppColors.mainColorFont,
                fontSize:9.2.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'ReadexPro',
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
