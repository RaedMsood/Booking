import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';

final updateGenderProvider = StateProvider<String?>(
      (ref) => null,
);

class UpdateGenderWidget extends ConsumerWidget {
  const UpdateGenderWidget({
    super.key,
    this.selectedGenderFromProfile,
    this.onChanged
  });

  final ValueChanged<String>? onChanged;
  final String? selectedGenderFromProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initial = selectedGenderFromProfile ?? 'male';
    final selectedGender = ref.watch(updateGenderProvider);
    final genderNotifier = ref.read(updateGenderProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text:  S.of(context).gender,
          fontSize: 11.5.sp,
          colorText: Colors.black87,
        ),
        SizedBox(height: 6.h),
        InkWell(
          onTap: () {
            showModalBottomSheetWidget(
              context: context,
              page: GenderBottomSheet(
                ref: ref,
                initialGender: initial,
                onChanged: onChanged,
              ),
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
                SizedBox(width: 8.w),
                AutoSizeTextWidget(
                  text: selectedGender == 'male' ?  S.of(context).male :  S.of(context).female,
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
  const GenderBottomSheet({
    super.key,
    required this.ref,
    required this.initialGender,
    required this.onChanged
  });

  final WidgetRef ref;
  final String initialGender;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final genders = {
      'male': S.of(context).male,
      'female': S.of(context).female
    };
    final current = ref.watch(updateGenderProvider);
    final notifier = ref.read(updateGenderProvider.notifier);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: genders.entries.map((entry) {
          final isSelected = current == entry.key;
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
              notifier.state = entry.key;
              onChanged;
              Navigator.of(context).pop();
            },
          );
        }).toList(),
      ),
    );
  }
}
