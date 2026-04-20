import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/property_data_model.dart';
import '../riverpod/home_riverpod.dart';
import 'property_card_location_row_widget.dart';
import 'property_card_rating_chip_widget.dart';
import 'property_photos_widget.dart';

class PropertyVerticalCardBody extends ConsumerWidget {
  final PropertyDataModel property;

  const PropertyVerticalCardBody({
    super.key,
    required this.property,
  });

  double _calculateCardDrift(BuildContext context) {
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
    return -normalized.sign * intensity * 5;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(scrollOffsetProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final drift = _calculateCardDrift(context);
        final cardHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 208.h;
        final cardWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;

        final isCompact = cardHeight <= 190.h || cardWidth <= 220.w;
        final reservedContentHeight = isCompact ? 58.h : 56.h;
        final imageHeight = (cardHeight - reservedContentHeight)
            .clamp(136.h, 160.h)
            .toDouble();
        final titleMaxLines = isCompact ? 1 : 2;
        final titleFontSize = isCompact ? 11.sp : 12.sp;
        final titleMinFontSize = isCompact ? 8.0 : 9.0;
        final titleRatingSpacing = isCompact ? 6.w : 8.w;
        final contentVerticalPadding = isCompact ? 3.h : 4.h;
        final contentSpacing = isCompact ? 2.h : 4.h;
        final locationIconHeight = isCompact ? 11.h : 12.h;
        final locationFontSize = isCompact ? 9.sp : 10.sp;

        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: drift),
          duration: const Duration(milliseconds: 140),
          curve: Curves.easeOutCubic,
          builder: (context, animatedDrift, child) {
            return Transform.translate(
              offset: Offset(0, animatedDrift),
              child: child,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PropertyCardMediaSection(
                property: property,
                imageHeight: imageHeight,
              ),
              Expanded(
                child: _PropertyCardInfoSection(
                  property: property,
                  titleMaxLines: titleMaxLines,
                  titleFontSize: titleFontSize,
                  titleMinFontSize: titleMinFontSize,
                  titleRatingSpacing: titleRatingSpacing,
                  contentVerticalPadding: contentVerticalPadding,
                  contentSpacing: contentSpacing,
                  locationIconHeight: locationIconHeight,
                  locationFontSize: locationFontSize,
                  isCompact: isCompact,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PropertyCardMediaSection extends StatelessWidget {
  final PropertyDataModel property;
  final double imageHeight;

  const _PropertyCardMediaSection({
    required this.property,
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: imageHeight,
      child: PropertyPhotosWidget(
        image: property.mainImageUrls,
        height: imageHeight,
        idProperties: property.id,
        isFavorite: property.isFavorite,
        enableScrollReveal: true,
      ),
    );
  }
}

class _PropertyCardInfoSection extends StatelessWidget {
  final PropertyDataModel property;
  final int titleMaxLines;
  final double titleFontSize;
  final double titleMinFontSize;
  final double titleRatingSpacing;
  final double contentVerticalPadding;
  final double contentSpacing;
  final double locationIconHeight;
  final double locationFontSize;
  final bool isCompact;

  const _PropertyCardInfoSection({
    required this.property,
    required this.titleMaxLines,
    required this.titleFontSize,
    required this.titleMinFontSize,
    required this.titleRatingSpacing,
    required this.contentVerticalPadding,
    required this.contentSpacing,
    required this.locationIconHeight,
    required this.locationFontSize,
    required this.isCompact,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
        8.w,
        contentVerticalPadding,
        8.w,
        contentVerticalPadding,
      ),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AutoSizeTextWidget(
                    text: property.name,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w500,
                    maxLines: titleMaxLines,
                    minFontSize: titleMinFontSize,
                    textAlign: TextAlign.start,
                  ),
                ),
                titleRatingSpacing.horizontalSpace,
                PropertyCardRatingChipWidget(
                  rating: property.rating.toDouble(),
                  fontSize: isCompact ? 9.sp : 10.sp,
                  horizontalPadding: isCompact ? 5.w : 6.w,
                  verticalPadding: isCompact ? 1.5.h : 2.h,
                  itemSize: isCompact ? 12.sp : 14.sp,
                ),
              ],
            ),
            contentSpacing.verticalSpace,
            PropertyCardLocationRowWidget(
              city: property.city,
              district: property.district,
              iconHeight: locationIconHeight,
              fontSize: locationFontSize,
            ),
          ],
        ),
      ),
    );
  }
}


