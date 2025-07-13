import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../../generated/l10n.dart';


class AppBarTopTrendsWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Color backgroundColor;
  // final Animation<double>? textOffsetAnimation; // حركة النص
  // final Animation<double>? containerOffsetAnimation; // حركة الكونتينر
  // final Animation<double>? containerWidthAnimation; // توسيع الكونتينر
  // final bool showText;

  const AppBarTopTrendsWidget({
    super.key,
    required this.backgroundColor,
    // this.textOffsetAnimation,
    // this.containerOffsetAnimation,
    // this.containerWidthAnimation,
    // required this.showText,
  });

  @override
  Size get preferredSize => Size.fromHeight(42.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      surfaceTintColor: AppColors.primaryColor,
      elevation: 0,
      titleSpacing: 0,
      leadingWidth: 40.w,
      // pinned: true,
      // floating: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      title: AutoSizeTextWidget(
        text:"dE",
        fontSize: 13.sp,
        colorText: Colors.white,
      ),
      // title: AnimatedBuilder(
      //   animation: textOffsetAnimation ?? AlwaysStoppedAnimation(0),
      //   builder: (context, child) {
      //     return Opacity(
      //       opacity: showText ? 1.0 : 0.0, // إخفاء النص تدريجيًا
      //       child: Transform.translate(
      //         offset: Offset(textOffsetAnimation?.value ?? 0, 0),
      //         // تحريك النص
      //         child: AnimatedContainer(
      //           duration: const Duration(milliseconds: 400),
      //          height: 26.h,
      //           child: AutoSizeTextWidget(
      //             text: S.of(context).topTrends,
      //             fontSize: 12.4.sp,
      //             colorText: Colors.white,
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),

      leading: IconButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const CircleBorder()),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Localizations.localeOf(context).languageCode == "ar"
              ? Icons.arrow_back_ios_rounded
              : Icons.arrow_forward_ios_rounded,
          color: Colors.white,
          size: 18.r,
        ),
      ),
      actions: [
        InkWellButtonWidget(
          icon: AppIcons.search,
          iconColor: Colors.white,
          height: 18.4.r,
          onPressed: () {},
        ),
        3.w.horizontalSpace,
        // AnimatedBuilder(
        //   animation: containerOffsetAnimation ?? AlwaysStoppedAnimation(1),
        //   builder: (context, child) {
        //     return Opacity(
        //       opacity: showText ? 0.0 : 1.0, // إظهار الكونتينر تدريجيًا
        //       child: Transform.translate(
        //         offset: Offset(containerOffsetAnimation?.value ?? 0, 0),
        //         // تحريك الكونتينر
        //         child: AnimatedContainer(
        //           duration: const Duration(milliseconds: 400),
        //           height: 26.h,
        //           width: containerWidthAnimation?.value ?? 0,
        //           // توسيع الكونتينر
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(30.r),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
        IconButtonWidget(
          icon: AppIcons.favorite,
          iconColor: Colors.white,
          height: 20.5.r,
        ),
      ],
    );
  }
}
