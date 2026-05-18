import 'package:booking/core/widgets/online_images_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/specific_offer_item_model.dart';

class HotelOfferChipWidget extends StatelessWidget {
  const HotelOfferChipWidget({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final SpecificOfferItemModel item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryColor
                    : Colors.transparent,
                width: 1.6,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OnlineImagesWidget(
                  imageUrl: item.imagePath,
                  circularImage: true,
                  fit: BoxFit.cover,
                  size: Size(30.w, 27.h),
                ),
                4.w.horizontalSpace,
                Flexible(
                  child: AutoSizeTextWidget(
                    text: item.title,
                    fontSize: 8.sp,
                    maxLines: 2,
                    colorText: AppColors.mainColorFont,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

