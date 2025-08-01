import 'package:booking/core/theme/app_colors.dart';
import 'package:booking/core/widgets/smooth_page_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../../../core/widgets/rating_bar_widget.dart';

class PropertyPhotosWidget extends StatefulWidget {
  final List<String> image;
  final double height;

  PropertyPhotosWidget({
    super.key,
    required this.image,
    required this.height,
  });

  @override
  State<PropertyPhotosWidget> createState() => _PropertyPhotosWidgetState();
}

class _PropertyPhotosWidgetState extends State<PropertyPhotosWidget> {
  int pageController = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            itemCount: widget.image.length,
            onPageChanged: (value) {
              setState(() {
                pageController = value;
              });
            },
            itemBuilder: (context, imageIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  topLeft: Radius.circular(8.r),
                ),
                child: OnlineImagesWidget(
                  imageUrl: widget.image[imageIndex],
                  size: Size(double.infinity, widget.height),
                  borderRadius: 0,
                ),
              );
            },
          ),
        ),

        SmoothPageIndicatorWidget(
          pageController: pageController,
          count: widget.image.length,
        ),

        PositionedDirectional(
          top: 8,
          end: 8,
          child: Container(
            padding: EdgeInsets.all(5.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child:  SvgPicture.asset(
              AppIcons.favoriteActive,
              color: AppColors.primarySwatch.shade400,
              //  color:Color(0xffda6b6e),
              height: 18.h,
            ),
          ),
          // child: Container(
          //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(8.r),
          //         bottomRight: Radius.circular(8.r)),
          //     gradient: LinearGradient(
          //       colors: [
          //         Color(0xFFefc421),
          //         Color(0xFFefc654),
          //         Color(0xFFeecf5d),
          //         Color(0xFFf8cd71),
          //
          //         // Color(0xFFF4C430).withOpacity(.8),
          //       ],
          //       begin: Alignment.centerLeft,
          //       end: Alignment.centerRight,
          //     ),
          //   ),
          //   child: RatingBarWidget(
          //     evaluation: 5,
          //     labeledColor: Colors.black,
          //     itemSize: 11.5.sp,
          //   ),
          // ),
        ),
      ],
    );
  }
}
