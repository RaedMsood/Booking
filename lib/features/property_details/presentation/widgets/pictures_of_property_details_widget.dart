import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import 'carousel_slider_for_the_top_trends_widget.dart';
import 'hexagon_image _widget.dart';

class TrendModel {
  final int id;
  final String image;
  final String name;
  final String description;

  TrendModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
  });
}
class PicturesOfPropertyDetailsWidget extends StatefulWidget {
  const PicturesOfPropertyDetailsWidget({super.key});

  @override
  State<PicturesOfPropertyDetailsWidget> createState() => _PicturesOfPropertyDetailsWidgetState();
}

class _PicturesOfPropertyDetailsWidgetState extends State<PicturesOfPropertyDetailsWidget> {
  List<TrendModel> trends = [
    TrendModel(
      id: 1,
      image: "https://www.fay3.com/iQ4IUj5az/download",
      name: "#أزياء هاوندستوث",
      description: "نمط كلاسيكي مع مربعات صغيرة مكسورة",
    ),

    TrendModel(
      id: 4,
      image: "https://meaningg.cc/wp-content/uploads/2019/07/3947-16.jpg",
      name: "#ملابس نسائية",
      description: "كولكشن ملابس نسائية روعة",
    ),

    TrendModel(
      id: 6,
      image: "https://meaningg.cc/wp-content/uploads/2019/07/3947-16.jpg",
      name: "#ملابس نسائية",
      description: "كولكشن ملابس نسائية روعة",
    ),

    TrendModel(
      id: 8,
      image: "https://www.fay3.com/iQ4IUj5az/download",
      name: "#أزياء هاوندستوث",
      description: "نمط كلاسيكي مع مربعات صغيرة مكسورة",
    ),
    TrendModel(
      id: 4,
      image: "https://meaningg.cc/wp-content/uploads/2019/07/3947-16.jpg",
      name: "#ملابس نسائية",
      description: "كولكشن ملابس نسائية روعة",
    ),

    TrendModel(
      id: 6,
      image: "https://meaningg.cc/wp-content/uploads/2019/07/3947-16.jpg",
      name: "#ملابس نسائية",
      description: "كولكشن ملابس نسائية روعة",
    ),

    TrendModel(
      id: 8,
      image: "https://www.fay3.com/iQ4IUj5az/download",
      name: "#أزياء هاوندستوث",
      description: "نمط كلاسيكي مع مربعات صغيرة مكسورة",
    ),
  ];
  int _currentIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final CarouselSliderController _carouselController =
  CarouselSliderController();

  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });

    _scrollController.animateTo(
      index * 54.w,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CarouselSliderForTheTopTrendsWidget(
      trendsDate: trends,
      carouselController: _carouselController,
      onPageChanged: _onPageChanged,
      child: Container(
        height: 60.h,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 12.h),

        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(12.h)
        ),
        child: ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 6.h),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
                _carouselController.jumpToPage(index);
              },
              child: _currentIndex == index
                  ? HexagonImageWidget(imageUrl: trends[index].image)
                  : Stack(
                children: [
                  OnlineImagesWidget(
                    imageUrl: trends[index].image,
                    size: Size(54.w, 46.h),
                    borderRadius: 4.r,
                  ),
                  // if(index==0)
                  // Container(
                  //   width: 54.w,
                  //   height: 46.h,
                  //   decoration: BoxDecoration(
                  //     color: Colors.black38,
                  //     borderRadius: BorderRadius.circular(4.r),
                  //     border: Border.all(
                  //         color: Colors.white70, width: 0.4.w),
                  //   ),
                  //   alignment: Alignment.center,
                  //   child: AutoSizeTextWidget(
                  //     text: "${trends.length.toString()}+",
                  //     colorText: Colors.white,
                  //     fontSize: 12.5.sp,
                  //     minFontSize: 8,
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(width: 6.w),
          itemCount: trends.length,
        ),
      ),
    );
  }
}
