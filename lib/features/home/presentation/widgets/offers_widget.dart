import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../../../core/widgets/smooth_page_indicator_widget.dart';

class OffersWidget extends StatefulWidget {
  const OffersWidget({super.key});

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  int pageController = 0;

  List offersImage = [
    "https://techvillageeg.com/wp-content/uploads/2023/08/%D8%A3%D9%81%D8%B6%D9%84-%D8%AA%D8%B7%D8%A8%D9%8A%D9%82%D8%A7%D8%AA-%D8%AD%D8%AC%D8%B2-%D8%A7%D9%84%D9%81%D9%86%D8%A7%D8%AF%D9%82.webp",
    "https://lens.usercontent.google.com/image?vsrid=CPiJ2fWE2OzzrwEQAhgBIiRlYjVjMjU3Yy05Y2ZiLTQwYjEtYmUxNi1iNzU3YzIwNGNlODkyBiICZWgoADiWzf3E5LWOAw&gsessionid=g3pxA0dkMz759E7MEyCb50iPfuvKzDRRrAg5L-hs7E0CNv0udM1SXA",
    "https://media.zid.store/61fdcc47-4ddf-47ef-a50c-8347a582db4f/e4bfb94b-90b9-4bd7-acb4-036a223c3c3b.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 146.h,
            autoPlay: true,
            aspectRatio: 2,
            viewportFraction: 1,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            reverse: false,
            onPageChanged: (index, reason) {
              setState(() {
                pageController = index;
              });
            },
          ),
          items: offersImage.map<Widget>((e) {
            return Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(horizontal: 14.w),
              shadowColor: AppColors.greySwatch.shade50.withOpacity(.4),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: OnlineImagesWidget(
                imageUrl: e,
                fit: BoxFit.fill,
                size: Size(double.infinity, 146.h),
                borderRadius: 16.r,
              ),
            );
          }).toList(),
        ),
        8.h.verticalSpace,
        SmoothPageIndicatorWidget(
          pageController: pageController,
          count: offersImage.length,
        ),
      ],
    );
  }
}
