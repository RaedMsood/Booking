import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import 'pictures_of_property_details_widget.dart';

class CarouselSliderForTheTopTrendsWidget extends StatelessWidget {
  final List<TrendModel> trendsDate;
  final Widget child;
  final CarouselSliderController carouselController;

  final Function(int index, CarouselPageChangedReason reason) onPageChanged;

  const CarouselSliderForTheTopTrendsWidget({
    super.key,
    required this.trendsDate,
    required this.child,
    required this.onPageChanged,
    required this.carouselController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: 320.h,
            autoPlay: true,
            aspectRatio: 0,
            viewportFraction: 1,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            reverse: true,
            onPageChanged: onPageChanged,
          ),
          items: trendsDate.map((items) {
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    OnlineImagesWidget(
                      imageUrl: items.image,
                      size: Size(
                        double.infinity,
                        350.h,
                      ),
                      logoWidth: 0,
                      borderRadius: 0,
                    ),
                    // Container(
                    //   height: 350.h,
                    //   width: double.infinity,
                    //   decoration: const BoxDecoration(
                    //     gradient: LinearGradient(
                    //       colors: [
                    //         Colors.black45,
                    //         Colors.black26,
                    //         Colors.black12,
                    //         Colors.black12,
                    //         Colors.black12,
                    //         Colors.black26,
                    //         Colors.black38,
                    //         Colors.black45,
                    //         Colors.black54,
                    //         Colors.black54,
                    //       ],
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              },
            );
          }).toList(),
        ),
        child
      ],
    );
  }
}
