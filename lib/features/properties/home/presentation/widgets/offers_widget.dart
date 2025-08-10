import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/online_images_widget.dart';

class OffersWidget extends StatefulWidget {
  const OffersWidget({super.key});

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  int pageController = 0;

  List offersImage = [
    "https://techvillageeg.com/wp-content/uploads/2023/08/%D8%A3%D9%81%D8%B6%D9%84-%D8%AA%D8%B7%D8%A8%D9%8A%D9%82%D8%A7%D8%AA-%D8%AD%D8%AC%D8%B2-%D8%A7%D9%84%D9%81%D9%86%D8%A7%D8%AF%D9%82.webp",
    "https://img.freepik.com/free-vector/flat-summer-sale-banner-template-with-photo_23-2148953278.jpg?semt=ais_hybrid&w=740",
    "https://img.pikbest.com/backgrounds/20210619/blue-gold-hotel-reservation-login-page_6022886.jpg!f305cw",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104.h,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: offersImage.length,
        itemBuilder: (context, index, realIdx) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: OnlineImagesWidget(
              imageUrl: offersImage[index],
              fit: BoxFit.cover,
              size: Size(double.infinity, 104.h),
              borderRadius: 8.r,
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: offersImage.length > 1,
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
          enableInfiniteScroll: false,
          viewportFraction: 0.93,
          enlargeCenterPage: false,
          padEnds: true,
        ),
      ),
    );
  }
}
