import 'package:booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/rating_bar_widget.dart';
import '../../../../../core/widgets/read_more_text_widget.dart';
import '../../data/models/features_model.dart';
import 'hotel_features_widget.dart';

class NameAndDescriptionAndRatingWidget extends StatelessWidget {
  final String name;
  final String description;
  final double rating;
  final List<FeaturesModel> features;

  const NameAndDescriptionAndRatingWidget({
    super.key,
    required this.name,
    required this.description,
    required this.rating,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: name,
                        fontSize: 13.6.sp,
                        fontWeight: FontWeight.w500,
                        maxLines: 2,
                        minFontSize: 12,
                      ),
                    ),
                    6.w.horizontalSpace,
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: const Color(0xfffef4d4).withOpacity(.8),
                        borderRadius: BorderRadius.circular(28.r),
                      ),
                      child: Row(
                        children: [
                          AutoSizeTextWidget(
                            text: rating.toString(),
                            fontSize: 10.5.sp,
                            colorText: AppColors.secondaryColor,
                          ),
                          1.8.w.horizontalSpace,
                          RatingBarWidget(
                            evaluation: rating,
                            length: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                8.h.verticalSpace,
                if (description.isNotEmpty)
                  ReadMoreTextWidget(
                    text: description,
                  ),
              ],
            ),
          ),
          6.h.verticalSpace,
          if (features.isNotEmpty)
            HotelFeaturesWidget(
              features: features,
            ),
        ],
      ),
    );
  }
}
