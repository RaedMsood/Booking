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
        final contentVerticalPadding = 6.h;
        final contentSpacing = 8.h;

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
              child: Padding(
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
                              fontSize: 10.6.sp,
                              fontWeight: FontWeight.w500,
                              maxLines: 2,
                              minFontSize: 8,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          6.w.horizontalSpace,
                          PropertyCardRatingChipWidget(
                            rating: property.rating.toDouble(),
                            fontSize: 8.4.sp,
                            horizontalPadding: 5.w,
                            verticalPadding: 1.6.h,
                            itemSize: 11.sp,
                          ),
                        ],
                      ),
                      contentSpacing.verticalSpace,
                      PropertyCardLocationRowWidget(
                        city: property.city,
                        district: property.district,
                        iconHeight: 10.5.h,
                        fontSize: 8.8.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

