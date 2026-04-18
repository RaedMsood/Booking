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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.w, 4.h, 8.w, 4.h),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AutoSizeTextWidget(
                          text: property.name,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          maxLines: 1,
                          minFontSize: 9,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      8.w.horizontalSpace,
                      PropertyCardRatingChipWidget(
                        rating: property.rating.toDouble(),
                        fontSize: 10.sp,
                        horizontalPadding: 6.w,
                        verticalPadding: 2.h,
                        itemSize: 14.sp,
                      ),
                    ],
                  ),
                  4.h.verticalSpace,
                  PropertyCardLocationRowWidget(
                    city: property.city,
                    district: property.district,
                    iconHeight: 12.h,
                    fontSize: 10.sp,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


