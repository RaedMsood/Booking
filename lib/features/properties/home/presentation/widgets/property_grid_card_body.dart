import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/property_data_model.dart';
import 'property_card_location_row_widget.dart';
import 'property_card_rating_chip_widget.dart';
import 'property_photos_widget.dart';

class PropertyGridCardBody extends StatelessWidget {
  final PropertyDataModel property;

  const PropertyGridCardBody({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 178.h;
        final imageHeight = (cardHeight * 0.64).clamp(104.h, 122.h).toDouble();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: imageHeight,
              child: PropertyPhotosWidget(
                image: property.mainImageUrls,
                height: imageHeight,
                idProperties: property.id,
                isFavorite: property.isFavorite,
                enableScrollReveal: true,
              ),
            ),
            Expanded(
              child: _PropertyGridCardInfoSection(property: property),
            ),
          ],
        );
      },
    );
  }
}

class _PropertyGridCardInfoSection extends StatelessWidget {
  final PropertyDataModel property;

  const _PropertyGridCardInfoSection({
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 48.h;
        final isTight = availableHeight <= 56.h;
        final isVeryTight = availableHeight <= 46.h;
        final contentVerticalPadding =
            isVeryTight ? 1.5.h : (isTight ? 2.h : 6.h);
        final contentSpacing = isVeryTight ? 1.h : (isTight ? 2.h : 6.h);
        final titleMaxLines = isTight ? 1 : 2;
        final titleFontSize =
            isVeryTight ? 8.8.sp : (isTight ? 9.6.sp : 10.6.sp);
        final titleMinFontSize = isVeryTight ? 7.0 : 8.0;
        final titleRatingSpacing = isVeryTight ? 4.w : 6.w;
        final ratingFontSize = isVeryTight ? 7.6.sp : (isTight ? 8.sp : 8.4.sp);
        final ratingHorizontalPadding =
            isVeryTight ? 4.w : (isTight ? 4.5.w : 5.w);
        final ratingVerticalPadding =
            isVeryTight ? 1.h : (isTight ? 1.2.h : 1.6.h);
        final ratingItemSize = isVeryTight ? 9.5.sp : (isTight ? 10.sp : 11.sp);
        final locationIconHeight =
            isVeryTight ? 9.4.h : (isTight ? 10.h : 10.5.h);
        final locationFontSize =
            isVeryTight ? 7.8.sp : (isTight ? 8.2.sp : 8.8.sp);

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

