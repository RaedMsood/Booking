// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../theme/app_colors.dart';
// import 'auto_size_text_widget.dart';
// import 'buttons/default_button.dart';
//
// class EmptyWidget extends StatelessWidget {
//   final String? icon;
//   final String? title;
//   final String? subTitle;
//   final double? iconHeight;
//   final double? buttonWidth;
//   final VoidCallback? onPressed;
//   final bool isButton;
//   final String? textButton;
//
//   const EmptyWidget({
//     super.key,
//     this.icon,
//     this.title,
//     this.subTitle,
//     this.iconHeight,
//     this.buttonWidth,
//     this.onPressed,
//     this.isButton = true,
//     this.textButton,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         icon.toString().isEmpty
//             ? const SizedBox.shrink()
//             : SvgPicture.asset(
//                 icon.toString(),
//                 height: iconHeight ?? 100.h,
//               ),
//         AutoSizeTextWidget(
//           text: title.toString(),
//           fontSize: 12.sp,
//           fontWeight: FontWeight.w600,
//         ),
//         8.h.verticalSpace,
//         subTitle.toString().isEmpty
//             ? const SizedBox.shrink()
//             : AutoSizeTextWidget(
//                 text: subTitle.toString(),
//                 fontSize: 10.8.sp,
//                 colorText: AppColors.fontColor,
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//               ),
//         18.h.verticalSpace,
//         DefaultButtonWidget(
//           text: S.of(context).createAList,
//           height: 34.h,
//           width: buttonWidth ?? double.infinity,
//           textSize: 10.5.sp,
//           onPressed: () {
//             if (navigator) {
//               Navigator.of(context).pop();
//             }
//             showModalBottomSheetWidget(
//               context: context,
//               page: CreateANewListDialogWidget(),
//             );
//           },
//         ),
//         12.h.verticalSpace,
//       ],
//     );
//   }
// }
