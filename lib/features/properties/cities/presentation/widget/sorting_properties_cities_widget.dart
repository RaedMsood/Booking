import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/radio_widget.dart';
import '../riverpod/cities_riverpod.dart';

class SortingPropertiesCitiesWidget extends ConsumerStatefulWidget {
  const SortingPropertiesCitiesWidget({
    super.key,
  });

  @override
  ConsumerState<SortingPropertiesCitiesWidget> createState() =>
      _SortingPropertiesWidgetWidgetState();
}

class _SortingPropertiesWidgetWidgetState
    extends ConsumerState<SortingPropertiesCitiesWidget> {
  int temp = 0;

  List<String> get nameFilter => [
    'الأكثر حجزا',
    'الاعلى سعرا',
    'الأقل سعرا',
  ];

  String get _title => nameFilter[temp];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _onOpenSheet,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: AppColors.mainColorFont.withOpacity(0.2), width: 0.9),
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            child: Row(
              children: [
                AutoSizeTextWidget(
                  text: _title,
                  colorText: AppColors.mainColorFont.withOpacity(0.9),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 11.sp,
                  color: AppColors.mainColorFont.withOpacity(0.9),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _onOpenSheet() async {
    final int? selected = await showSortBottomSheet(
      context: context,
      initialIndex: temp,
      options: nameFilter,
    );

    if (!mounted || selected == null) return;
    setState(() => temp = selected);

    scheduleMicrotask(() async {
      await Future<void>.delayed(const Duration(milliseconds: 180));
      if (!mounted) return;

      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ref
            .read(getFilterCitiesTypeProvider.notifier)
            .setSectionFilterNumber(selected);
      });
    });
  }
}

Future<int?> showSortBottomSheet({
  required BuildContext context,
  required int initialIndex,
  required List<String> options,
}) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: false,
    backgroundColor: Colors.transparent,
    builder: (ctx) => SortBottomSheetWidget(
      initialIndex: initialIndex,
      options: options,
    ),
  );
}

class SortBottomSheetWidget extends StatelessWidget {
  const SortBottomSheetWidget({
    super.key,
    required this.initialIndex,
    required this.options,
  });

  final int initialIndex;
  final List<String> options;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE9E6F3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Row(
              children: [
                8.w.horizontalSpace,
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
                      text: 'العرض حسب',
                      fontSize: 13.6.sp,
                      colorText: AppColors.mainColorFont,
                    ),
                  ],
                ),
                const Spacer(),
                IconButtonWidget(
                  icon: AppIcons.close,
                  height: 15.h,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                4.w.horizontalSpace,
              ],
            ),
            8.h.verticalSpace,
            Flexible(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final bool selected = index == initialIndex;
                  return InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () => Navigator.pop(context, index),
                    child: Container(
                      height: 46.h,
                      decoration: BoxDecoration(
                        color: AppColors.scaffoldColor, // بنفسجي فاتح بالصورة
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AutoSizeTextWidget(
                              text: options[index],
                              fontSize: 12.sp,
                              colorText: const Color(0xFF4F4A59),
                            ),
                          ),
                          RadioWidget(selected: selected),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
