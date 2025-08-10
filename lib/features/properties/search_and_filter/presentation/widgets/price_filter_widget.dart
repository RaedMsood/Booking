import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentRange = ref.read(currentPriceRangeProvider);
      if (currentRange == null) {
        ref.read(currentPriceRangeProvider.notifier).state =
            RangeValues(widget.minPrice, widget.maxPrice);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentRange = ref.watch(currentPriceRangeProvider);

    if (currentRange == null) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AutoSizeTextWidget(
          text: "السعر",
          fontSize: 12.sp,
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
                        AppColors.primarySwatch.shade200.withOpacity(.8),
                    thumbColor: AppColors.primaryColor,
                    overlayColor:
                        AppColors.primarySwatch.shade200.withOpacity(.8),
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
                  _buildValueBox('من', currentRange.start),
                  14.w.horizontalSpace,
                  Container(
                    width: 10.w,
                    height: 1.1.h,
                    color: const Color(0xff605a65),
                  ),
                  14.w.horizontalSpace,
                  _buildValueBox('إلى', currentRange.end),
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
