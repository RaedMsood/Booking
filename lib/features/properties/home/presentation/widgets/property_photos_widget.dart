import 'package:booking/core/theme/app_colors.dart';
import 'package:booking/core/widgets/smooth_page_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../../profile/presentation/state_mangement/riverpod.dart';
import '../../data/model/property_data_model.dart';
import '../riverpod/home_riverpod.dart';

class PropertyPhotosWidget extends StatefulWidget {
  final List<String> image;
  final double height;
  final int idProperties;
  final bool isFavorite;
  final bool enableScrollReveal;
  final PropertyDataModel? property;

  const PropertyPhotosWidget(
      {super.key,
      required this.image,
      required this.height,
      required this.idProperties,
      required this.isFavorite,
      this.enableScrollReveal = false,
      this.property});

  @override
  State<PropertyPhotosWidget> createState() => _PropertyPhotosWidgetState();
}

class _PropertyPhotosWidgetState extends State<PropertyPhotosWidget> {
  int pageController = 0;

  double get _maxParallaxShift => widget.height * 0.14;

  double _calculateParallaxOffset(BuildContext context) {
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return 0;

    final viewportHeight = MediaQuery.sizeOf(context).height;
    if (viewportHeight <= 0) return 0;

    final itemPosition = renderObject.localToGlobal(Offset.zero);
    final itemCenterY = itemPosition.dy + (renderObject.size.height / 2);
    final normalized = (((itemCenterY / viewportHeight) - 0.5) * 2)
        .clamp(-1.0, 1.0);
    if (normalized == 0) return 0;

    final intensity = Curves.easeOutCubic.transform(normalized.abs());
    return -normalized.sign * intensity * _maxParallaxShift;
  }

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
            itemBuilder: (itemContext, imageIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  topLeft: Radius.circular(8.r),
                ),
                child: widget.enableScrollReveal
                    ? Consumer(
                        builder: (context, ref, _) {
                          ref.watch(scrollOffsetProvider);

                          final extraHeight = (_maxParallaxShift * 2) + 10.h;
                          final shift = _calculateParallaxOffset(this.context);

                          return ClipRect(
                            child: TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0, end: shift),
                              duration: const Duration(milliseconds: 140),
                              curve: Curves.easeOutCubic,
                              builder: (context, animatedShift, child) {
                                return Transform.translate(
                                  offset: Offset(0, animatedShift),
                                  child: child,
                                );
                              },
                              child: OverflowBox(
                                minHeight: widget.height + extraHeight,
                                maxHeight: widget.height + extraHeight,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: widget.height + extraHeight,
                                  width: double.infinity,
                                  child: Transform.scale(
                                    scale: 1.05,
                                    child: OnlineImagesWidget(
                                      imageUrl: widget.image[imageIndex],
                                      fit: BoxFit.cover,
                                      size: Size(
                                        double.infinity,
                                        widget.height + extraHeight,
                                      ),
                                      borderRadius: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : OnlineImagesWidget(
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
              favoritesProvider.select(
                (state) => state.isFavorite(widget.idProperties),
              ),
            );
            final isBusy = ref.watch(
              favoritesProvider.select(
                (state) => state.isBusy(widget.idProperties),
              ),
            );

            final favorites = ref.read(favoritesProvider.notifier);

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
                     onPressed: isBusy
                         ? null
                         : () => favorites.toggle(
                               id: widget.idProperties,
                               property: widget.property,
                             ),
                    icon: SvgPicture.asset(
                      isFav ? AppIcons.favoriteActive : AppIcons.favorite,
                      colorFilter: ColorFilter.mode(
                        isFav
                            ? AppColors.primarySwatch.shade400
                            : AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
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
