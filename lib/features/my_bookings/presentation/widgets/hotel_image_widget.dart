import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/online_images_widget.dart';

class HotelImageWidget extends StatelessWidget {
  final String imageUrl;
  const   HotelImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.sp),
      child: OnlineImagesWidget(
        imageUrl: imageUrl,
        size: Size(65.w, 50.h),
        fit:  BoxFit.cover,
      ),
    );
  }
}