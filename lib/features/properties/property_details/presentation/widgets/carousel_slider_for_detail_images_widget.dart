// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../core/widgets/online_images_widget.dart';
//
// class CarouselSliderForDetailImagesWidget extends StatelessWidget {
//   final List<String> images;
//   final Widget child;
//   final CarouselSliderController carouselController;
//
//   final Function(int index, CarouselPageChangedReason reason) onPageChanged;
//
//   const CarouselSliderForDetailImagesWidget({
//     super.key,
//     required this.images,
//     required this.child,
//     required this.onPageChanged,
//     required this.carouselController,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         CarouselSlider(
//           carouselController: carouselController,
//           options: CarouselOptions(
//             height: double.infinity,
//             autoPlay: images.length <= 1 ? false : true,
//             aspectRatio: 0,
//             viewportFraction: 1,
//             autoPlayInterval: const Duration(seconds: 4),
//             autoPlayAnimationDuration: const Duration(milliseconds: 800),
//             autoPlayCurve: Curves.fastOutSlowIn,
//             scrollDirection: Axis.horizontal,
//             reverse: true,
//             onPageChanged: onPageChanged,
//           ),
//           items: images.map((items) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return Stack(
//                   children: [
//                     OnlineImagesWidget(
//                       imageUrl: items,
//                       size: Size(
//                         double.infinity,
//                         330.h,
//                       ),
//                       logoWidth: 0,
//                       borderRadius: 0,
//                     ),
//                   ],
//                 );
//               },
//             );
//           }).toList(),
//         ),
//         if (images.isEmpty || images.length <= 1)
//           const SizedBox.shrink()
//         else
//           child
//       ],
//     );
//   }
// }
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../../../core/widgets/photo_view_dialog_widget.dart';

class CarouselSliderForDetailImagesWidget extends StatelessWidget {
  final List<String> images;
  final Widget child;
  final CarouselSliderController carouselController;

  final Function(int index, CarouselPageChangedReason reason) onPageChanged;

  const CarouselSliderForDetailImagesWidget({
    super.key,
    required this.images,
    required this.child,
    required this.onPageChanged,
    required this.carouselController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: double.infinity,
            autoPlay: images.length <= 1 ? false : true,
            aspectRatio: 0,
            viewportFraction: 1,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            reverse: true,
            onPageChanged: onPageChanged,
          ),
          items: images.asMap().entries.map((entry) {
            final index = entry.key;
            final imageUrl = entry.value;
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    if (images.isEmpty) return;
                    PhotoViewDialogWidget.show(
                      context,
                      images: images,
                      initialIndex: index,
                    );
                  },
                  child: Stack(
                    children: [
                      OnlineImagesWidget(
                        imageUrl: imageUrl,
                        size: Size(
                          double.infinity,
                          330.h,
                        ),
                        logoWidth: 0,
                        borderRadius: 0,
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        if (images.isEmpty || images.length <= 1)
          const SizedBox.shrink()
        else
          child
      ],
    );
  }
}
