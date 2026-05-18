import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/online_images_widget.dart';

class SpecificOffersHeaderWidget extends StatelessWidget {
  const SpecificOffersHeaderWidget({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final image = imagePath.trim();

    return Container(
      height: 250.h,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      child: image.isEmpty
          ? Container(color: Colors.grey.shade200)
          : image.startsWith('http')
          ? OnlineImagesWidget(
              imageUrl: image,
              fit: BoxFit.fill,
              size: Size(double.infinity, 250.h),
            )
          : DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.fill,
                ),
              ),
            ),
    );
  }
}

