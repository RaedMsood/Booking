import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';

final genderProvider = StateProvider<String>((ref) => 'male');

class GenderPickerWidget extends ConsumerWidget {
  const GenderPickerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender = ref.watch(genderProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: "الجنس",
          fontSize: 11.5.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        InkWell(
          onTap: () {
            showModalBottomSheetWidget(
              context: context,
              page: GenderBottomSheet(ref: ref),
            );
          },
          child: Container(
            height: 42.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  selectedGender == 'male' ? Icons.male : Icons.female,
                  size: 20.sp,
                  color: AppColors.primaryColor,
                ),
                8.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: selectedGender == 'male' ? 'ذكر' : 'أنثى',
                  fontSize: 11.sp,
                  colorText: Colors.black87,
                ),
                const Spacer(),
                SvgPicture.asset(
                  AppIcons.arrowBottom,
                  height: 18.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GenderBottomSheet extends StatelessWidget {
  final WidgetRef ref;

  const GenderBottomSheet({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    final genders = {'male': 'ذكر', 'female': 'أنثى'};

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...genders.entries.map(
            (entry) {
              final isSelected = ref.read(genderProvider) == entry.key;
              return ListTile(
                leading: Icon(
                  entry.key == 'male' ? Icons.male : Icons.female,
                  size: 22.sp,
                  color: isSelected ? AppColors.primaryColor : AppColors.fontColor,
                ),
                title: Text(
                  entry.value,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: isSelected ? AppColors.primaryColor : AppColors.fontColor,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                onTap: () {
                  ref.read(genderProvider.notifier).state = entry.key;
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
