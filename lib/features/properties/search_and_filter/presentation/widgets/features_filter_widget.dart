import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../property_details/data/models/features_model.dart';
import '../riverpod/search_and_filter_riverpod.dart';

class FeaturesFilterWidget extends ConsumerWidget {
  final List<FeaturesModel> features;

  const FeaturesFilterWidget({super.key, required this.features});

  @override
  Widget build(BuildContext context, ref) {
    final selected = ref.watch(selectedFeaturesProvider(features.length));
    final notifier =
        ref.read(selectedFeaturesProvider(features.length).notifier);
    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 12.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: List.generate(features.length, (index) {
              return FilterChip(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                label: Text(
                  features[index].name,
                  style: TextStyle(
                    fontSize: 9.4.sp,
                    color: selected[index]
                        ? AppColors.primaryColor
                        : AppColors.greyColor,
                  ),
                ),
                selected: selected[index],
                onSelected: (_) => notifier.toggle(index),
                selectedColor: const Color(0xfff5f6f8),
                checkmarkColor: AppColors.primaryColor,
                backgroundColor: Colors.white,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: selected[index]
                        ? AppColors.primaryColor
                        : AppColors.greySwatch.shade100,
                    width: 1.2,
                  ),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
              );
            }),
          ),
        ],
      ),
    );
  }
}
