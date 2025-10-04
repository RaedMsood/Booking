// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../constants/app_icons.dart';
// import '../theme/app_colors.dart';
//
// class OnlineImagesWidget extends StatelessWidget {
//   final String imageUrl;
//   final bool circularImage;
//   final double? circularRadius;
//   final bool hasShadow;
//   final Size? size;
//   final BoxFit? fit;
//   final double? logoWidth;
//   final double? borderRadius;
//
//   const OnlineImagesWidget({
//     super.key,
//     required this.imageUrl,
//     this.circularImage = false,
//     this.circularRadius,
//     this.hasShadow = false,
//     this.size,
//     this.fit,
//     this.logoWidth,
//     this.borderRadius,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: imageUrl,
//       placeholder: (context, value) {
//         return Container(
//           height: size?.height,
//           width: size?.width,
//           decoration: BoxDecoration(
//             color: Colors.grey[300],
//             borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
//           ),
//           child: SpinKitPulse(
//             color: AppColors.primaryColor,
//             size: 20.r,
//           ),
//         );
//       },
//       imageBuilder: (context, imageProvider) {
//         var image = DecorationImage(
//           image: imageProvider,
//           fit: fit ?? BoxFit.cover,
//         );
//
//         return SizedBox(
//           height: size?.height,
//           width: size?.width,
//           child: Stack(
//             clipBehavior: Clip.antiAlias,
//             children: [
//               circularImage
//                   ? CircleAvatar(
//                       backgroundImage: imageProvider,
//                       radius: circularRadius ?? 35.sp,
//                     )
//                   : Container(
//                       decoration: BoxDecoration(
//                         image: image,
//                         borderRadius:
//                             BorderRadius.circular(borderRadius ?? 4.r),
//                       ),
//                       height: size?.height,
//                       width: size?.width,
//                     ),
//             ],
//           ),
//         );
//       },
//       errorWidget: (context, url, error) => Container(
//         height: size?.height,
//         width: size?.width,
//         decoration: BoxDecoration(
//           color: AppColors.greySwatch.shade200,
//           borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
//         ),
//         child: Center(
//           child: SvgPicture.asset(
//             AppIcons.logo,
//             width: logoWidth ?? 50.w,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:octo_image/octo_image.dart';

import '../constants/app_icons.dart';
import '../theme/app_colors.dart';

class OnlineImagesWidget extends StatelessWidget {
  final String imageUrl;
  final bool circularImage;
  final double? circularRadius;
  final bool hasShadow;
  final Size? size; // مرّر ارتفاع أو الاثنين لو تستخدمه كأيقونة
  final BoxFit? fit;
  final double? logoWidth;
  final double? borderRadius;
  final String? cacheKey;

  const OnlineImagesWidget({
    super.key,
    required this.imageUrl,
    this.circularImage = false,
    this.circularRadius,
    this.hasShadow = false,
    this.size,
    this.fit,
    this.logoWidth,
    this.borderRadius,
    this.cacheKey,
  });

  @override
  Widget build(BuildContext context) {
    final url = imageUrl.trim();
    if (url.isEmpty || url.toLowerCase() == 'null') {
      return _errorBox(size?.width, size?.height);
    }

    final r = (circularRadius ?? (ScreenUtil().pixelRatio != 0 ? 35.sp : 35.0))
        .toDouble();
    final bRadius = BorderRadius.circular((borderRadius ?? 4.r));

    // نحاول نحسب cacheWidth بشكل آمن وبسيط
    int? safeCacheWidth(double? w) {
      if (w == null || !w.isFinite || w <= 0) return null;
      final dpr = MediaQuery.of(context).devicePixelRatio;
      final px = (w * (dpr.isFinite && dpr > 0 ? dpr : 2.0)).round();
      // Clamp خفيف يغطي الصغير والكبير بدون إفراط
      return px.clamp(64, 4096);
    }

    return LayoutBuilder(
      builder: (ctx, constraints) {
        // لو الأب حدّد عرضًا، نستخدمه؛ وإلا نرجع للـ size.width؛ وإلا نخليها null
        final boundedW = (constraints.hasBoundedWidth &&
                constraints.maxWidth.isFinite &&
                constraints.maxWidth > 0)
            ? constraints.maxWidth
            : (size?.width);

        final targetWidth = boundedW; // للعرض على الشاشة
        final targetHeight = size?.height; // ثبّت الارتفاع لو مرّرته
        final cacheW = safeCacheWidth(boundedW ?? size?.width);

        final provider = CachedNetworkImageProvider(
          url,
          cacheKey: cacheKey,
          // ↓ يقلل فكّ الترميز للصور الكبيرة وللصور الصغيرة يظل منطقي
          maxWidth: cacheW,
        );

        final boxShadow = hasShadow
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null;

        final imageWidget = OctoImage(
          image: provider,
          width: targetWidth,
          height: targetHeight,
          fit: fit ?? BoxFit.cover,
          placeholderBuilder: (ctx) =>
              _placeholderBox(targetWidth, targetHeight, bRadius, boxShadow),
          errorBuilder: (ctx, _, __) => _errorBox(targetWidth, targetHeight,
              boxShadow: boxShadow, bRadius: bRadius),
        );

        if (circularImage) {
          return SizedBox(
            width: targetWidth,
            height: targetHeight ?? r * 2,
            child: ClipOval(
              child: imageWidget,
            ),
          );
        }

        return Container(
          width: targetWidth,
          height: targetHeight,
          decoration:
              BoxDecoration(borderRadius: bRadius, boxShadow: boxShadow),
          clipBehavior: Clip.antiAlias,
          child: imageWidget,
        );
      },
    );
  }

  Widget _placeholderBox(
      double? w, double? h, BorderRadius bRadius, List<BoxShadow>? shadows) {
    return Container(
      height: size?.height,
      width: size?.width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
      ),
      child: SpinKitPulse(
        color: AppColors.primaryColor,
        size: 20.r,
      ),
    );
  }

  Widget _errorBox(double? w, double? h,
      {List<BoxShadow>? boxShadow, BorderRadius? bRadius}) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: AppColors.greySwatch.shade200,
        borderRadius: bRadius ?? BorderRadius.circular((borderRadius ?? 4.r)),
        boxShadow: boxShadow,
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        AppIcons.logo,
        width: logoWidth ?? (ScreenUtil().pixelRatio != 0 ? 50.w : 50.0),
      ),
    );
  }
}
