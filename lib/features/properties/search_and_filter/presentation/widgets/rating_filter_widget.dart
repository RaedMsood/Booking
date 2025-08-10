import 'package:booking/core/widgets/rating_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../riverpod/search_and_filter_riverpod.dart';

class RatingFilterWidget extends ConsumerStatefulWidget {
  const RatingFilterWidget({super.key});

  @override
  ConsumerState<RatingFilterWidget> createState() => _RatingFilterWidgetState();
}

class _RatingFilterWidgetState extends ConsumerState<RatingFilterWidget> {
  final List<double> _rating = [
    5.0,
    4.0,
    3.0,
    2.0,
    1.0,
  ];

  void _selectedFunction(int index) {
    setState(() {});
    var selected = ref.read(selectedRatingProvider);
    if (selected.contains(_rating[index])) {
      selected.remove(_rating[index]);
    } else {
      selected.add(_rating[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(selectedRatingProvider);

    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(
            _rating.length,
            (index) {
              var idx = _rating.length - 1 - index;

              return InkWell(
                onTap: () {
                  _selectedFunction(index);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: RatingBarWidget(
                          evaluation: (idx + 1).toDouble(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AutoSizeTextWidget(
                          text: _rating[index].toString(),
                          fontSize: 12.2.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Checkbox(
                        value: ref
                            .read(selectedRatingProvider)
                            .contains(_rating[index]),
                        onChanged: (bool? checked) {
                          if (checked == null) return;
                          _selectedFunction(index);
                        },
                        activeColor: AppColors.primaryColor,
                        checkColor: Colors.white,
                        shape: const CircleBorder(),
                        side: MaterialStateBorderSide.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return const BorderSide(
                              color: AppColors.primaryColor,
                              width: 1,
                            );
                          }
                          return BorderSide(
                            color: AppColors.fontColor.withOpacity(.8),
                            width: 1,
                          );
                        }),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                          horizontal: -0.5,
                          vertical: -3.5,
                        ),
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => states.contains(MaterialState.selected)
                              ? AppColors.primaryColor
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
