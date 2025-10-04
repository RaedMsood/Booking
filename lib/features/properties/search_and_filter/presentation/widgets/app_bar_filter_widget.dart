import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../generated/l10n.dart';

class AppBarFilterWidget extends StatelessWidget  implements PreferredSizeWidget{
  const AppBarFilterWidget({super.key});
  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 71.w,
      toolbarHeight: 56.h,
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.h).copyWith(top: 4.4.h),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const IconButtonWidget(),
        ),
      ),
      title: AutoSizeTextWidget(
        text: S.of(context).filterTitle,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
