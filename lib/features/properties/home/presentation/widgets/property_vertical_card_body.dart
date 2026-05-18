import 'package:booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/property_data_model.dart';
import '../riverpod/home_riverpod.dart';
import 'property_card_location_row_widget.dart';
import 'property_offer_banner_widget.dart';
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
        final imageHeight = 160.h;

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
              4.verticalSpace,
              Expanded(
                child: _PropertyCardInfoSection(
                  property: property,
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
        key: ValueKey('property-photos-${property.id}'),
        image: property.mainImageUrls,
        height: imageHeight,
        idProperties: property.id,
        isFavorite: property.isFavorite,
        enableScrollReveal: true,
        property: property,
      ),
    );
  }
}

class _PropertyCardInfoSection extends StatelessWidget {
  final PropertyDataModel property;

  const _PropertyCardInfoSection({
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    final showOfferBanner = property.hasOffer;

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 48.h;
        final isTight = availableHeight <= 56.h;
        final isVeryTight = availableHeight <= 46.h;
        final contentVerticalPadding = isVeryTight ? 1.5.h : (isTight ? 2.h : 4.h);
        final contentSpacing = isVeryTight ? 1.h : (isTight ? 2.h : 4.h);
        final titleMaxLines = isTight ? 1 : 2;
        final titleFontSize = isVeryTight ? 12.sp : (isTight ? 12.5.sp : 13.0.sp);
        final titleMinFontSize = isVeryTight ? 12.0 : (isTight ? 12.5 : 13.0);
        final titleRatingSpacing = isVeryTight ? 4.w : (isTight ? 6.w : 8.w);
        final ratingFontSize = isVeryTight ? 8.sp : (isTight ? 9.sp : 10.sp);
        final ratingHorizontalPadding = isVeryTight ? 4.w : (isTight ? 5.w : 6.w);
        final ratingVerticalPadding = isVeryTight ? 1.h : (isTight ? 1.5.h : 2.h);
        final ratingItemSize = isVeryTight ? 10.sp : (isTight ? 12.sp : 14.sp);
        final locationIconHeight = isVeryTight ? 10.h : (isTight ? 11.h : 12.h);
        final locationFontSize = isVeryTight ? 10.0.sp : (isTight ? 10.5.sp : 11.5.sp);

        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            8.w,
            contentVerticalPadding,
            8.w,
            contentVerticalPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showOfferBanner) ...[
                PropertyOfferBannerWidget(
                  text: property.offerBadgeText,
                ),
                SizedBox(height: contentSpacing),
                Divider(
                  height: 1.h,
                  color: const Color(0xffF5F5F5),
                ),
                SizedBox(height: contentSpacing),
              ],
              Flexible(
                child: Row(
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
                      fontSize: ratingFontSize,
                      horizontalPadding: ratingHorizontalPadding,
                      verticalPadding: ratingVerticalPadding,
                      itemSize: ratingItemSize,
                    ),
                  ],
                ),
              ),
              SizedBox(height: contentSpacing),
              Flexible(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: PropertyCardLocationRowWidget(
                    city: property.city,
                    district: property.district,
                    iconHeight: locationIconHeight,
                    fontSize: locationFontSize,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


