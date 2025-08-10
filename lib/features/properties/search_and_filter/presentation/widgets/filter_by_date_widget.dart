import 'package:booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../riverpod/search_and_filter_riverpod.dart';
import 'calendar_range_picker_sheet_widget.dart';

class FilterByDateWidget extends ConsumerStatefulWidget {
  const FilterByDateWidget({super.key});

  @override
  ConsumerState<FilterByDateWidget> createState() => _FilterByDateWidgetState();
}

class _FilterByDateWidgetState extends ConsumerState<FilterByDateWidget> {
  String _rangeText(BuildContext context) {
    var selectedRange = ref.read(selectedDateRangeProvider);

    if (selectedRange == null) {
      return 'من  -  إلى';
    }
    final locale = Localizations.localeOf(context).toString();
    final fmt = DateFormat('EEEE dd MMMM', locale);
    final start = fmt.format(selectedRange.start);
    final end = fmt.format(selectedRange.end);
    return '$start  -  $end';
  }

  @override
  Widget build(BuildContext context) {
    var selectedRange = ref.watch(selectedDateRangeProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: "التاريخ",
          fontSize: 12.sp,
          colorText: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
        8.h.verticalSpace,
        GestureDetector(
          onTap: () async {
            final range = await showCalendarRangePickerBottomSheet(
              context,
              initialRange: selectedRange,
            );
            if (range != null) {
              ref.read(selectedDateRangeProvider.notifier).state = range;
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeTextWidget(
                    text: _rangeText(context),
                    colorText: selectedRange == null
                        ? AppColors.fontColor
                        : AppColors.mainColorFont,
                    fontSize: 11.2.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8),
                SvgPicture.asset(
                  AppIcons.date,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
