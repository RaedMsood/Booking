import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../profile/presentation/state_mangement/riverpod.dart';

class DraggableScoreBarWidget extends ConsumerStatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const DraggableScoreBarWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  ConsumerState<DraggableScoreBarWidget> createState() =>
      _DraggableScoreBarState();
}

class _DraggableScoreBarState extends ConsumerState<DraggableScoreBarWidget> {
  final GlobalKey _key = GlobalKey();

  // void _updateFromDx(double dx) {
  //   final box = _key.currentContext!.findRenderObject() as RenderBox;
  //   final width = box.size.width;
  //
  //   final double reversedDx = (width - dx).clamp(0.0, width);
  //
  //   final double t = reversedDx / width;
  //   final double v = 1.0 + t * 9.0;
  //
  //   widget.onChanged(v.clamp(1.0, 10.0));
  // }
  void _updateFromDx(double dx) {
    final box = _key.currentContext!.findRenderObject() as RenderBox;
    final width = box.size.width;

    final textDir = Directionality.of(context);
    // المسافة من جهة البدء:
    final fromStartDx = (textDir == TextDirection.ltr) ? dx : (width - dx);
    final clamped = fromStartDx.clamp(0.0, width);
    final t = clamped / width; // 0.0 عند البداية → 1.0 عند النهاية
    final v = 1.0 + t * 9.0;

    widget.onChanged(v.clamp(1.0, 10.0));
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(languageProvider);

    final double progress10 =
        ((widget.value - 1.0) * (10.0 / 9.0)).clamp(0.0, 10.0);

    final labels = List<int>.generate(10, (i) => i + 1);

    //final textDir = Directionality.of(context);

    return GestureDetector(
      onPanDown: (d) => _updateFromDx(d.localPosition.dx),
      onPanUpdate: (d) => _updateFromDx(d.localPosition.dx),
      onTapDown: (d) => _updateFromDx(d.localPosition.dx),
      behavior: HitTestBehavior.opaque,
      child: Container(
        key: _key,
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          textDirection: locale.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl, // ثبّت الترتيب المنطقي
          children: [
            for (final label in labels)
              Expanded(
                child: _ScoreBox(
                  label: label,
                  fillRatio: (progress10 - (label - 1)).clamp(0.0, 1.0),
                  textDirection: locale.languageCode == 'en'
                      ? TextDirection.ltr
                      : TextDirection
                          .rtl, // مرّر الاتجاه للتحكم بالمحاذاة والـradius
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ScoreBox extends StatelessWidget {
  final int label;
  final double fillRatio;
  final TextDirection textDirection;

  const _ScoreBox({
    required this.label,
    required this.fillRatio,
    required this.textDirection,
  });

  BorderRadius _radiusForBackground(bool isStart, bool isEnd, bool isLTR) {
    final radius = Radius.circular(7.r);
    // corners عند جهة البدء والنهاية
    return isLTR
        ? BorderRadius.only(
            topLeft: isStart ? radius : Radius.zero,
            bottomLeft: isStart ? radius : Radius.zero,
            topRight: isEnd ? radius : Radius.zero,
            bottomRight: isEnd ? radius : Radius.zero,
          )
        : BorderRadius.only(
            topRight: isStart ? radius : Radius.zero,
            bottomRight: isStart ? radius : Radius.zero,
            topLeft: isEnd ? radius : Radius.zero,
            bottomLeft: isEnd ? radius : Radius.zero,
          );
  }

  @override
  Widget build(BuildContext context) {
    final isLTR = textDirection == TextDirection.ltr;

    // بما أننا ثبّتْنا الـRow على LTR والlabels = 1..10
    // start = index 0 -> label 1 ، end = index 9 -> label 10
    final isStart = label == 1;
    final isEnd = label == 10;

    final bgRadius = _radiusForBackground(isStart, isEnd, isLTR);

    final textColor =
        (fillRatio >= 0.5) ? Colors.white : const Color(0xff605A65);

    // محاذاة التعبئة من جهة البدء:
    final fillAlignment = isLTR ? Alignment.centerLeft : Alignment.centerRight;

    return Stack(
      children: [
        // الخلفية
        Container(
          height: 36.h,
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: bgRadius,
          ),
        ),

        if (fillRatio > 0)
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: Align(
                alignment: fillAlignment,
                child: FractionallySizedBox(
                  widthFactor: fillRatio.clamp(0.0, 1.0),
                  alignment: fillAlignment,
                  child: Container(
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: bgRadius,
                    ),
                  ),
                ),
              ),
            ),
          ),

        Positioned.fill(
          child: Center(
            child: AutoSizeTextWidget(
              text: '$label',
              fontWeight: FontWeight.w400,
              fontSize: 11.sp,
              maxLines: 1,
              colorText: textColor,
            ),
          ),
        ),
      ],
    );
  }
}

// class _ScoreBox extends StatelessWidget {
//   final int label;
//   final double fillRatio;
//
//   const _ScoreBox({
//     required this.label,
//     required this.fillRatio,
//   });
//
//   BorderRadius? _radiusForBackground() {
//     if (label == 1) {
//       return BorderRadius.only(
//         topRight: Radius.circular(7.r),
//         bottomRight: Radius.circular(7.r),
//       );
//     }
//     if (label == 10) {
//       return BorderRadius.only(
//         topLeft: Radius.circular(7.r),
//         bottomLeft: Radius.circular(7.r),
//       );
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final textColor =
//         (fillRatio >= 0.5) ? Colors.white : const Color(0xff605A65);
//
//     return Stack(
//       children: [
//         // خلفية المربع
//         Container(
//           height: 36.h,
//           margin: EdgeInsets.symmetric(horizontal: 2.w),
//           decoration: BoxDecoration(
//             color: const Color(0xffF5F5F5),
//             borderRadius: _radiusForBackground(),
//           ),
//         ),
//
//         if (fillRatio > 0)
//           Positioned.fill(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 2.w),
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: FractionallySizedBox(
//                   widthFactor: fillRatio.clamp(0.0, 1.0),
//                   alignment: Alignment.centerRight,
//                   child: Container(
//                     height: 36.h,
//                     decoration: BoxDecoration(
//                       color: AppColors.primaryColor,
//                       borderRadius: _radiusForBackground(),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//         Positioned.fill(
//           child: Center(
//             child: AutoSizeTextWidget(
//               text: '$label',
//               fontWeight: FontWeight.w400,
//               fontSize: 11.sp,
//               maxLines: 1,
//               colorText: textColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
