import 'package:booking/core/theme/app_colors.dart';
import 'package:booking/core/widgets/smooth_page_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../../profile/presentation/state_mangement/riverpod.dart';

class PropertyPhotosWidget extends StatefulWidget {
  final List<String> image;
  final double height;
  final int idProperties;
  final bool isFavorite;

  const PropertyPhotosWidget(
      {super.key,
      required this.image,
      required this.height,
      required this.idProperties,
      required this.isFavorite});

  @override
  State<PropertyPhotosWidget> createState() => _PropertyPhotosWidgetState();
}

class _PropertyPhotosWidgetState extends State<PropertyPhotosWidget> {
  int pageController = 0;
  late bool favorite = widget.isFavorite;

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
        Consumer(
          builder: (context, ref, _) {
            final isFav = ref.watch(
              favoriteIdsProvider
                  .select((ids) => ids.contains(widget.idProperties)),
            );

            final fav = ref.read(favoriteIdsProvider.notifier);
            fav.isBusy(widget.idProperties);

            return PositionedDirectional(
              top: 8,
              end: 4,
              child: SizedBox(
                height: 30.h,
                child: Material(
                  color: Colors.white,
                  shape: const CircleBorder(),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      fav.toggle(widget.idProperties);
                      setState(() {
                        favorite = !favorite;
                      });
                    },
                    icon: SvgPicture.asset(
                      isFav ? AppIcons.favoriteActive : AppIcons.favorite,
                      color: isFav
                          ? AppColors.primarySwatch.shade400
                          : AppColors.primaryColor,
                      height: isFav ? 18.h : 15.h,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
