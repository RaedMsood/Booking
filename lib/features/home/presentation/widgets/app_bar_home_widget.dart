import 'package:booking/core/widgets/auto_size_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_icons.dart';

class AppBarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHomeWidget({super.key});

  @override
  Size get preferredSize => Size.fromHeight(48.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 48.h,
      centerTitle: true,
      title: AutoSizeTextWidget(text: "اهلا رائد مسعود",fontSize: 13.sp,),
      actions: [
        14.w.horizontalSpace,
        SvgPicture.asset(AppIcons.notification),
        14.w.horizontalSpace,
      ],
    );
  }
}
