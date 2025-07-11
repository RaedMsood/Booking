import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HotelImage extends StatelessWidget {
  final String imageUrl;
  const HotelImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.sp),
      child: Image.network(
        imageUrl,
        width: 65.w,
        height: 55.h,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 65.w,
          height: 55.h,
          color: Colors.grey.shade200,
          child: const Icon(Icons.image_not_supported, color: Colors.grey),
        ),
      ),
    );
  }
}