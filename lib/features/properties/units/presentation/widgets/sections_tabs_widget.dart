import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/shimmer_widget.dart';
import '../riverpod/unit_riverpod.dart';

class SectionsTabsPinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double tabAnimationValue;
  final int propertyId;

  SectionsTabsPinnedHeaderDelegate({
    required this.tabAnimationValue,
    required this.propertyId,
  });

  static final double _height = 50.h;

  bool get _isSectionsTab {
    // لما تكون القيمة بين 0.5 و 1.5 نعتبر أننا في منطقة تبويب الأقسام
    return tabAnimationValue >= 0.5 && tabAnimationValue <= 1.5;
  }

  @override
  double get minExtent => _isSectionsTab ? _height : 0;

  @override
  double get maxExtent => _isSectionsTab ? _height : 0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (!_isSectionsTab) {
      return const SizedBox.shrink();
    }

    return Container(
      color: AppColors.scaffoldColor,
      child: Consumer(
        builder: (context, ref, _) {
          final baseState =
              ref.watch(getAllUnitsProvider(Tuple2(propertyId, 0)));
          final sections = baseState.data.sections;

          if (sections.isEmpty && baseState.stateData == States.loading) {
            return const ShimmerOfSectionsWidget();
          }

          if (sections.isEmpty) {
            return const SizedBox.shrink();
          }
          final selectedSectionId =
              ref.watch(selectedUnitsSectionIdProvider(propertyId)) ??
                  sections.first.id;

          return SizedBox(
            height: _height,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              scrollDirection: Axis.horizontal,
              itemCount: sections.length,
              separatorBuilder: (_, __) => 8.w.horizontalSpace,
              itemBuilder: (context, index) {
                final section = sections[index];
                final bool isSelected = selectedSectionId == section.id;

                return InkWell(
                  borderRadius: BorderRadius.circular(20.r),
                  onTap: () {
                    final sectionId = section.id;
                    ref
                        .read(
                            selectedUnitsSectionIdProvider(propertyId).notifier)
                        .state = sectionId;
                    final sectionState = ref.read(
                      getAllUnitsProvider(
                        Tuple2(propertyId, sectionId),
                      ),
                    );
                    final alreadyLoaded =
                        sectionState.data.units.data.isNotEmpty;
                    //  إذا ما فيه داتا وما هو في حالة تحميل، حمّل لأول مرة
                    if (!alreadyLoaded &&
                        sectionState.stateData != States.loading &&
                        sectionState.stateData != States.loadingMore) {
                      ref
                          .read(
                            getAllUnitsProvider(
                              Tuple2(propertyId, sectionId),
                            ).notifier,
                          )
                          .getData();
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 23.w, vertical: 4.h),
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor.withValues(alpha: 0.05)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(25.r),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryColor
                            : const Color(0xFFE0E0E0),
                        width: 0.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: AutoSizeTextWidget(
                      text: section.name,
                      fontSize: 10.sp,
                      colorText: isSelected
                          ? AppColors.primaryColor
                          : AppColors.greyColor,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SectionsTabsPinnedHeaderDelegate oldDelegate) {
    return oldDelegate.tabAnimationValue != tabAnimationValue ||
        oldDelegate.propertyId != propertyId;
  }
}

class ShimmerOfSectionsWidget extends StatelessWidget {
  const ShimmerOfSectionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      separatorBuilder: (_, __) => 8.w.horizontalSpace,
      itemBuilder: (context, index) {
        return ShimmerWidget(
          child: Container(
            width: 76.w,
            margin: EdgeInsets.symmetric(vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
            ),
          ),
        );
      },
    );
  }
}
