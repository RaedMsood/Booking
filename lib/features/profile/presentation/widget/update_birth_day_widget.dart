import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';

final updateBirthDateProvider = StateProvider<DateTime?>((ref) => null);

class UpdateBirthDatePickerWidget extends ConsumerWidget {
  const UpdateBirthDatePickerWidget({super.key,required this.onChanged});
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final birthDate = ref.watch(updateBirthDateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: S.of(context).birthdateOptional,
          fontSize: 11.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        InkWell(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.primaryColor,
                      onPrimary: Colors.white,
                      onSurface: Color(0xff032545),
                    ),
                    dialogBackgroundColor: Colors.white,
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (picked != null) {
              onChanged!(picked.toString());
              ref.read(updateBirthDateProvider.notifier).state = picked;
            }
          },
          child: Container(
            height: 42.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 11.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppIcons.date,
                  height: 18.h,
                ),
                10.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: birthDate == null
                      ? S.of(context).enterBirthdate
                      : "${birthDate.year}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
                  fontSize: 10.8.sp,
                  colorText:
                  birthDate == null ? AppColors.fontColor2 : Colors.black87,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
