import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.context,
    required this.title,
    this.fontSize,
    this.color,
    this.heightIcon,
  });

  final String icon;
  final String title;
  final BuildContext context;
  final GestureTapCallback onTap;
  final double? fontSize;
  final Color? color;
  final double? heightIcon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.r),
      child: Material(
        color: Colors.white,
        child: ListTile(
          onTap: onTap,
          title: AutoSizeTextWidget(
            text: title,
            fontSize: fontSize ?? 11.sp,
            colorText: color ?? Colors.black,
          ),
          leading: SvgPicture.asset(
            icon,
            color: color ?? Colors.black,
            height: heightIcon,
          ),
          trailing: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: SvgPicture.asset(
              Directionality.of(context) == TextDirection.rtl
                  ? AppIcons.arrowLeft
                  : AppIcons.arrowRight,
              color: color ?? Colors.black,
              height: 15.h,
            ),
          ),
          titleAlignment: ListTileTitleAlignment.center,
          dense: true,
          horizontalTitleGap: 10.w,
          contentPadding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 12.w),
        ),
      ),
    );
  }
}
