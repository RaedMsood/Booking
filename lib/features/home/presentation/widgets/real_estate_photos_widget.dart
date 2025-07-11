import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/online_images_widget.dart';

class RealEstatePhotosWidget extends StatelessWidget {
  const RealEstatePhotosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OnlineImagesWidget(
          imageUrl:
          "https://www.alaraby.co.uk/sites/default/files/media/images/6A56AE3C-62E8-4A83-98CE-D00CE8260D5D.jpg",
          size: Size(double.infinity, 180.h),
          borderRadius: 16.r,
        ),
        PositionedDirectional(
          top: 10.h,
          start: 10.w,
          child: Container(
            padding: EdgeInsets.all(7.sp),
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
