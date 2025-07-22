import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../pages/home_page.dart';

class AppBarHomeWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHomeWidget({super.key});

  @override
  Size get preferredSize => Size.fromHeight(46.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 44.h,
      centerTitle: true,
      title: AutoSizeTextWidget(
        text: "اهلا رائد مسعود",
        fontSize: 13.sp,
      ),
      actions: [
        ValueListenableBuilder<bool>(
          valueListenable: HomePage.showSearchIconStatic,
          builder: (context, visible, _) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, anim) =>
                  FadeTransition(opacity: anim, child: child),
              child: visible
                  ? InkWellButtonWidget(
                      icon: AppIcons.search,
                      iconColor: Colors.black,
                      height: 15.5.h,
                      onPressed: () {},
                    )
                  : const SizedBox.shrink(),
            );
          },
        ),
        IconButtonWidget(
          icon: AppIcons.notification,
          onPressed: () {},
        ),
        2.8.w.horizontalSpace,
      ],
    );
  }
}
