import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../property_details/data/models/features_model.dart';
import '../../../search_and_filter/presentation/riverpod/search_and_filter_riverpod.dart';
import '../riverpod/home_riverpod.dart';
import 'fast_filter_widget.dart';

class PropertyViewTypeWidget extends ConsumerWidget {
  const PropertyViewTypeWidget({super.key, required this.features});

  final List<FeaturesModel> features;

  @override
  Widget build(BuildContext context, ref) {
    // var provider = ref.read(getAllPropertyProvider(Tuple2('','')).notifier);
    // ref.watch(getAllPropertyProvider(Tuple2('','')));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                alignment: Directionality.of(context) == TextDirection.rtl
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                children: [
                  Container(
                    height: 8.h,
                    width: 88.w,
                    margin: EdgeInsets.only(top: 10.h, right: 4.w),
                    decoration: BoxDecoration(
                      color: AppColors.primarySwatch.shade300
                          .withValues(alpha: .5),
                      borderRadius: BorderRadius.circular(1.r),
                    ),
                  ),
                  AutoSizeTextWidget(
                    text: S.of(context).yourHotelDestination,
                    fontSize: 13.6.sp,
                    colorText: AppColors.mainColorFont,
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     IconButtonWidget(
              //       icon: AppIcons.viewGrid,
              //       iconColor: provider.viewType == HomePropertyViewType.grid
              //           ? AppColors.primaryColor
              //           : AppColors.greySwatch.shade400,
              //       height: 18.h,
              //       width: 18.w,
              //       onPressed: () {
              //         provider.changeViewType(2);
              //       },
              //     ),
              //     2.w.horizontalSpace,
              //     InkWellButtonWidget(
              //       icon: AppIcons.viewList,
              //       iconColor: provider.viewType == HomePropertyViewType.list
              //           ? AppColors.primaryColor
              //           : AppColors.greySwatch.shade400,
              //       height: 18.h,
              //       width: 18.w,
              //       onPressed: () {
              //         provider.changeViewType(1);
              //       },
              //     ),
              //     2.w.horizontalSpace,
              //   ],
              // ),
              const SortingPropertiesWidget(),
            ],
          ),
          FastFeaturesFilterWidget(features: features)
        ],
      ),
    );
  }
}

class FastFeaturesFilterWidget extends ConsumerWidget {
  final List<FeaturesModel> features;

  const FastFeaturesFilterWidget({super.key, required this.features});

  @override
  Widget build(BuildContext context, ref) {
    final selected = ref.watch(selectedFeaturesProvider(features.length));
    final notifier =
        ref.read(selectedFeaturesProvider(features.length).notifier);
    return Container(
      margin: EdgeInsets.only(
        top: 14.h,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(features.length, (index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.h),
              child: FilterChip(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                label: Text(
                  features[index].name,
                  style: TextStyle(
                    fontSize: 9.4.sp,
                    color: selected[index]
                        ? AppColors.primaryColor
                        : AppColors.mainColorFont.withOpacity(0.9),
                  ),
                ),
                selected: selected[index],
                onSelected: (_) {
                  notifier.toggle(index);
                  ref
                      .read(getFeaturesProvider.notifier)
                      .setFeaturesNumber(features[index].id);
                },
                showCheckmark: false,
                selectedColor: const Color(0xfff5f6f8),
                backgroundColor: AppColors.scaffoldColor,
                shape: StadiumBorder(
                  side: BorderSide(
                    color: selected[index]
                        ? AppColors.primaryColor
                        : AppColors.greySwatch.shade300,
                    width: 1.2,
                  ),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
              ),
            );
          }),
        ),
      ),
    );
  }
}
