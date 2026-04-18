import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/property_data_model.dart';
import 'property_card_location_row_widget.dart';
import 'property_card_rating_chip_widget.dart';
import 'property_photos_widget.dart';

class PropertyVerticalCardBody extends StatelessWidget {
  final PropertyDataModel property;

  const PropertyVerticalCardBody({
    super.key,
    required this.property,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 160.h,
          child: PropertyPhotosWidget(
            image: property.mainImageUrls,
            height: 160.h,
            idProperties: property.id,
            isFavorite: property.isFavorite,
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final topPadding = (constraints.maxHeight * 0.12).clamp(4.0, 8.h);
              final bottomPadding =
                  (constraints.maxHeight * 0.12).clamp(6.0, 10.h);
              final titleFontSize = 12.sp;
              const titleMinFontSize = 9.0;
              final chipFontSize = 10.sp;
              final chipVerticalPadding = 2.h;
              final chipHorizontalPadding = 6.w;
              final ratingItemSize = 14.sp;
              final spacerHeight = 6.h;
              final locationIconHeight = 12.h;
              final locationFontSize = 10.sp;

              return Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  8.w,
                  topPadding,
                  8.w,
                  bottomPadding,
                ),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
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
                              maxLines: 2,
                              minFontSize: titleMinFontSize,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          8.w.horizontalSpace,
                          PropertyCardRatingChipWidget(
                            rating: property.rating.toDouble(),
                            fontSize: chipFontSize,
                            horizontalPadding: chipHorizontalPadding,
                            verticalPadding: chipVerticalPadding,
                            itemSize: ratingItemSize,
                          ),
                        ],
                      ),
                      SizedBox(height: spacerHeight),
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
            },
          ),
        ),
      ],
    );
  }
}


