import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import 'carousel_slider_for_detail_images_widget.dart';
import 'hexagon_image _widget.dart';

class DetailsPicturesWidget extends StatefulWidget {
  final List<String> images;

  const DetailsPicturesWidget({super.key, required this.images});

  @override
  State<DetailsPicturesWidget> createState() =>
      _DetailsPicturesWidgetState();
}

class _DetailsPicturesWidgetState
    extends State<DetailsPicturesWidget> {
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
    return CarouselSliderForDetailImagesWidget(
      images: widget.images,
      carouselController: _carouselController,
      onPageChanged: _onPageChanged,
      child: Container(
        height: 58.h,
        margin: EdgeInsets.symmetric(horizontal: 13.w).copyWith(bottom: 10.h),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: ListView.separated(
          controller: _scrollController,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentIndex = index;
                });
                _carouselController.jumpToPage(index);
              },
              child: _currentIndex == index
                  ? HexagonImageWidget(imageUrl: widget.images[index])
                  : OnlineImagesWidget(
                      imageUrl: widget.images[index],
                      size: Size(54.w, 46.h),
                      borderRadius: 6.r,
                    ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(width: 6.w),
          itemCount: widget.images.length,
        ),
      ),
    );
  }
}
