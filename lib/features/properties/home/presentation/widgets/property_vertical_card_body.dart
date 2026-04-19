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
    final drift = _calculateCardDrift(context);

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
          SizedBox(
            height: 160.h,
            child: PropertyPhotosWidget(
              image: property.mainImageUrls,
              height: 160.h,
              idProperties: property.id,
              isFavorite: property.isFavorite,
              enableScrollReveal: true,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.w, 4.h, 8.w, 4.h),
              child: Align(
                alignment: AlignmentDirectional.topStart,
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
      ),
    );
  }
}


