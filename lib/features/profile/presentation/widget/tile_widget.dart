import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class TileWidget extends StatelessWidget {
  const TileWidget(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.context,
      required this.title});

  final String icon;
  final String title;
  final BuildContext context;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(
        icon,
        color: const Color(0xff001A33),
        height: 18.h,
        width: 18.w,
      ),
      title: AutoSizeTextWidget(
        text: title,
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        colorText: const Color(0xff001A33),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.black),
      onTap: onTap,
    );
  }
}
