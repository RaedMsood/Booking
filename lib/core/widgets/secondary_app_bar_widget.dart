import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auto_size_text_widget.dart';
import 'buttons/icon_button_widget.dart';

class SecondaryAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final bool? centerTitle;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? backgroundColor;
  final double? fromHeight;

  const SecondaryAppBarWidget({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.fontWeight,
    this.fontSize,
    this.backgroundColor,
    this.fromHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(fromHeight ?? 58.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      surfaceTintColor: backgroundColor ?? Colors.transparent,
      elevation: 0.0,
      titleSpacing: 0,
      toolbarHeight: fromHeight ?? 52.h,
      centerTitle: centerTitle,
      title: AutoSizeTextWidget(
        text: title.toString(),
        fontSize: fontSize ?? 13.2.sp,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
      leadingWidth: 67.w,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.h).copyWith(top: 4.2.h),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const IconButtonWidget(),
        ),
      ),
    );
  }
}
