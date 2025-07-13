import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/online_images_widget.dart';

class PropertyPhotosWidget extends StatelessWidget {
  final List<String> image;

  const PropertyPhotosWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        SizedBox(
          height: 180.h,
          child: PageView.builder(
            itemCount: image.length,
            itemBuilder: (context, imageIndex) {
              return OnlineImagesWidget(
                imageUrl: image[imageIndex],
                size: Size(double.infinity, 180.h),
                borderRadius: 16.r,
              );
            },
          ),
        ),

        PositionedDirectional(
          top: 10.h,
          start: 10.w,
          child: Container(
            padding: EdgeInsets.all(6.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28.r),
            ),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                AppIcons.favorite,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
