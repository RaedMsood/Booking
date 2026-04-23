import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../riverpod/search_and_filter_riverpod.dart';

class SearchResultModeToggleWidget extends ConsumerWidget {
  const SearchResultModeToggleWidget({super.key});

  String _label(BuildContext context, SearchFilterResultMode mode) {
    final isArabic = Directionality.of(context) == TextDirection.rtl;
    switch (mode) {
      case SearchFilterResultMode.property:
        return isArabic ? 'المنشآت' : 'Properties';
      case SearchFilterResultMode.unit:
        return isArabic ? 'المرافق' : 'Units';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMode = ref.watch(pendingSearchResultModeProvider);

    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: .16),
          width: 0.8,
        ),
      ),
      child: Row(
        children: SearchFilterResultMode.values.map((mode) {
          final isSelected = selectedMode == mode;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(10.r),
              onTap: () {
                ref.read(pendingSearchResultModeProvider.notifier).state = mode;
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor.withValues(alpha: .08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryColor.withValues(alpha: .38)
                        : Colors.transparent,
                    width: 0.8,
                  ),
                ),
                child: Center(
                  child: AutoSizeTextWidget(
                    text: _label(context, mode),
                    fontSize: 11.sp,
                    colorText: isSelected
                        ? AppColors.primaryColor
                        : AppColors.fontColor2,
                    fontWeight: FontWeight.w500,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

