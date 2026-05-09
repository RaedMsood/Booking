import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../riverpod/search_and_filter_riverpod.dart';

class PriceFilterWidget extends ConsumerStatefulWidget {
  final double minPrice;
  final double maxPrice;

  const PriceFilterWidget({
    super.key,
    required this.minPrice,
    required this.maxPrice,
  });

  @override
  ConsumerState<PriceFilterWidget> createState() => _PriceFilterWidgetState();
}

class _PriceFilterWidgetState extends ConsumerState<PriceFilterWidget> {
  final NumberFormat _formatter = NumberFormat('#,##0', 'en_US');

  RangeValues _normalizedRange(RangeValues? range) {
    final min = widget.minPrice;
    final max = widget.maxPrice;

    if (range == null) {
      return RangeValues(min, max);
    }

    var start = range.start.clamp(min, max).toDouble();
    var end = range.end.clamp(min, max).toDouble();

    if (start > end) {
      final temp = start;
      start = end;
      end = temp;
    }

    return RangeValues(start, end);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentRange = ref.read(currentPriceRangeProvider);
      final normalized = _normalizedRange(currentRange);
      if (currentRange == null ||
          currentRange.start != normalized.start ||
          currentRange.end != normalized.end) {
        ref.read(currentPriceRangeProvider.notifier).state = normalized;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final storedRange = ref.watch(currentPriceRangeProvider);
    final currentRange = _normalizedRange(storedRange);

    if (storedRange == null ||
        storedRange.start != currentRange.start ||
        storedRange.end != currentRange.end) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ref.read(currentPriceRangeProvider.notifier).state = currentRange;
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AutoSizeTextWidget(
          text: S.of(context).price,
          fontSize: 11.sp,
          colorText: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
        8.h.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  sliderTheme: SliderThemeData(
                    trackHeight: 2.4.h,
                    activeTrackColor: AppColors.primaryColor,
                    inactiveTrackColor:
                        AppColors.primarySwatch.shade200.withValues(alpha:.8),
                    thumbColor: AppColors.primaryColor,
                    overlayColor:
                        AppColors.primarySwatch.shade200.withValues(alpha:.8),
                    showValueIndicator: ShowValueIndicator.never,

                  ),
                ),
                child: RangeSlider(
                  values: currentRange,
                  min: widget.minPrice,
                  max: widget.maxPrice,
                  divisions: ((widget.maxPrice - widget.minPrice) ~/ 5000),
                  onChanged: (values) {
                    ref.read(currentPriceRangeProvider.notifier).state = values;
                  },
                ),
              ),
              8.h.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildValueBox(S.of(context).from, currentRange.start),
                  14.w.horizontalSpace,
                  Container(
                    width: 10.w,
                    height: 1.1.h,
                    color: const Color(0xff605a65),
                  ),
                  14.w.horizontalSpace,
                  _buildValueBox(S.of(context).to, currentRange.end),
                ],
              ),
              10.h.verticalSpace,
            ],
          ),
        ),
        12.h.verticalSpace,

      ],
    );
  }

  Widget _buildValueBox(String label, double value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          AutoSizeTextWidget(
            text: '$label ',
            fontSize: 11.5.sp,
            colorText: const Color(0xff605a65),
            fontWeight: FontWeight.w400,
          ),
          AutoSizeTextWidget(
            text: _formatter.format(value),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          AutoSizeTextWidget(
            text: ' ﷼',
            fontSize: 13.5.sp,
            colorText: const Color(0xff605a65),
          ),
        ],
      ),
    );
  }
}
