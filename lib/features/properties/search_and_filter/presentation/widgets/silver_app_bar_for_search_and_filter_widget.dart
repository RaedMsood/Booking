// import 'package:booking/core/widgets/auto_size_text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../core/theme/app_colors.dart';
// import '../../../../../core/widgets/buttons/icon_button_widget.dart';
//
// class SilverAppBarForSearchAndFilterWidget extends StatelessWidget
//     implements PreferredSizeWidget {
//   const SilverAppBarForSearchAndFilterWidget({
//     super.key,
//   });
//
//   @override
//   Size get preferredSize => Size.fromHeight(58.h);
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       backgroundColor: AppColors.secondaryColor,
//       surfaceTintColor: AppColors.scaffoldColor,
//       elevation: 0,
//       titleSpacing: 0,
//       toolbarHeight: 58.h,
//       expandedHeight: 180.h,
//       pinned: true,
//       leadingWidth: 62.w,
//       leading: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 11.h).copyWith(top: 4.4.h),
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.circle,
//           ),
//           child: const IconButtonWidget(),
//         ),
//       ),
//       flexibleSpace: FlexibleSpaceBar(
//         background: Column(
//           children: [
//             AutoSizeTextWidget(text: "أبحث عن المكان المناسب لك",),
//           ],
//         ),
//       ),
//     );
//   }
// }
