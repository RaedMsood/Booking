import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/online_images_widget.dart';

class HexagonImageWidget extends StatelessWidget {
  final String imageUrl;

  const HexagonImageWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: ClipPath(
        clipper: HexagonClipper(),
        child: OnlineImagesWidget(
          imageUrl: imageUrl,
          size: Size(47.w, 46.h),
          borderRadius: 0,
          logoWidth: 0,
        ),
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    double edge = w * 0.25;

    Path path = Path()
      ..moveTo(w * 0.5, 0)
      ..lineTo(w, edge)
      ..lineTo(w, h - edge)
      ..lineTo(w * 0.5, h)
      ..lineTo(0, h - edge)
      ..lineTo(0, edge)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(HexagonClipper oldClipper) => false;
}
