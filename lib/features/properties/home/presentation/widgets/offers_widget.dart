import 'package:booking/core/widgets/auto_size_text_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/online_images_widget.dart';

class OffersWidget extends StatefulWidget {
  const OffersWidget({Key? key}) : super(key: key);

  @override
  State<OffersWidget> createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  int pageController = 0;

  List offersImage = [
    "https://techvillageeg.com/wp-content/uploads/2023/08/%D8%A3%D9%81%D8%B6%D9%84-%D8%AA%D8%B7%D8%A8%D9%8A%D9%82%D8%A7%D8%AA-%D8%AD%D8%AC%D8%B2-%D8%A7%D9%84%D9%81%D9%86%D8%A7%D8%AF%D9%82.webp",
    "https://techvillageeg.com/wp-content/uploads/2023/08/%D8%A3%D9%81%D8%B6%D9%84-%D8%AA%D8%B7%D8%A8%D9%8A%D9%82%D8%A7%D8%AA-%D8%AD%D8%AC%D8%B2-%D8%A7%D9%84%D9%81%D9%86%D8%A7%D8%AF%D9%82.webp",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 104.h,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          CarouselSlider.builder(
            itemCount: offersImage.length,
            itemBuilder: (context, index, realIdx) {
              return Padding(
                padding: EdgeInsets.only( right: 14.w),
                child: OnlineImagesWidget(
                  imageUrl: offersImage[index],
                  fit: BoxFit.cover,
                  size: Size(double.infinity, 104.h),
                  borderRadius: 8.r,
                ),
              );
            },
            options: CarouselOptions(
              height: 115.h,
              autoPlay: true,
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

              viewportFraction: 0.92,
              enlargeCenterPage: false,
              padEnds: false, // يلغّي الحشوة الأوتوماتيكية في الأطراف
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 58.h),
          //   padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 4.h),
          //   decoration: BoxDecoration(
          //     color: AppColors.secondaryColor.withOpacity(.68),
          //     borderRadius: BorderRadius.only(topLeft: Radius.circular(18.r))
          //   ),
          //   child: AutoSizeTextWidget(
          //     text: " كل العروض",
          //     fontSize: 11.2.sp,
          //     colorText: Colors.white,
          //   ),
          // ),
        ],
      ),
    );
  }
}

// class OffersWidget extends StatefulWidget {
//   const OffersWidget({super.key});
//
//   @override
//   State<OffersWidget> createState() => _OffersWidgetState();
// }
//
// class _OffersWidgetState extends State<OffersWidget> {
//   int pageController = 0;
//
//   List offersImage = [
//     "https://techvillageeg.com/wp-content/uploads/2023/08/%D8%A3%D9%81%D8%B6%D9%84-%D8%AA%D8%B7%D8%A8%D9%8A%D9%82%D8%A7%D8%AA-%D8%AD%D8%AC%D8%B2-%D8%A7%D9%84%D9%81%D9%86%D8%A7%D8%AF%D9%82.webp",
//     "https://techvillageeg.com/wp-content/uploads/2023/08/%D8%A3%D9%81%D8%B6%D9%84-%D8%AA%D8%B7%D8%A8%D9%8A%D9%82%D8%A7%D8%AA-%D8%AD%D8%AC%D8%B2-%D8%A7%D9%84%D9%81%D9%86%D8%A7%D8%AF%D9%82.webp",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 115.h,
//         autoPlay: true,
//         aspectRatio: 2,
//         viewportFraction: 1,
//         enlargeCenterPage: true,
//         autoPlayInterval: const Duration(seconds: 5),
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//         autoPlayCurve: Curves.fastOutSlowIn,
//         scrollDirection: Axis.horizontal,
//         reverse: false,
//         onPageChanged: (index, reason) {
//           setState(() {
//             pageController = index;
//           });
//         },
//       ),
//       items: offersImage.map<Widget>((e) {
//         return Card(
//           elevation: 2,
//           margin: EdgeInsets.symmetric(horizontal: 14.w),
//           shadowColor: AppColors.greySwatch.shade50.withOpacity(.4),
//           color: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.r),
//           ),
//           child: OnlineImagesWidget(
//             imageUrl: e,
//             fit: BoxFit.fill,
//             size: Size(double.infinity, 115.h),
//             borderRadius: 8.r,
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
