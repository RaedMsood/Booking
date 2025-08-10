import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../data/model/filter_data_model.dart';
import '../riverpod/search_and_filter_riverpod.dart';
import 'list_of_units_or_cities_widget.dart';

class FilterByUnitOrCityWidget extends ConsumerWidget {
  final List<CityOrUnitTypesModel> unitTypes;
  final bool isCity;

  const FilterByUnitOrCityWidget({
    super.key,
    required this.unitTypes,
    this.isCity = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    final selected = ref.watch(
        isCity ? selectACityToFilterProvider : selectedUnitTypesProvider);

    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            12.h.verticalSpace,
            AutoSizeTextWidget(
              text: isCity ? "المحافظة" : "نوع الغرفة",
              fontSize: 12.sp,
              colorText: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
            8.h.verticalSpace,
            InkWell(
              onTap: () {
                showModalBottomSheetWidget(
                  context: context,
                  backgroundColor: AppColors.scaffoldColor,
                  page: ListOfUnitsOrCitiesWidget(
                    unitTypes: unitTypes,
                    isCity: isCity,
                  ),
                );
              },
              child: Container(
                height: 42.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    AutoSizeTextWidget(
                      text: selected?.name ??
                          (isCity ? 'اختر المحافظة' : 'اختر نوع الغرفة'),
                      colorText: selected == null
                          ? AppColors.fontColor
                          : AppColors.mainColorFont,
                      fontSize: 11.2.sp,
                      fontWeight: FontWeight.w400,
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
        ),
      ],
    );
  }

// Widget _listOfItems(WidgetRef ref, BuildContext context) {
//   return SizedBox(
//     height: 480.h,
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         8.h.verticalSpace,
//         Row(
//           children: [
//             14.w.horizontalSpace,
//             AutoSizeTextWidget(
//               text: isCity ? "المحافظة" : "نوع الغرفة",
//               fontWeight: FontWeight.w400,
//             ),
//             const Spacer(),
//             IconButtonWidget(
//               icon: AppIcons.close,
//               height: 15.h,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//             4.w.horizontalSpace,
//           ],
//         ),
//         Expanded(
//           child: ListView.builder(
//             physics: const BouncingScrollPhysics(),
//             padding: EdgeInsets.symmetric(horizontal: 14.w)
//                 .copyWith(top: 8.h, bottom: 14.h),
//             itemBuilder: (context, index) {
//               return DesignForCitiesWidget(
//                 name: unitTypes[index].name.toString(),
//                 onTap: () {
//                   ref
//                       .read(isCity
//                           ? selectACityToFilterProvider.notifier
//                           : selectedUnitTypesProvider.notifier)
//                       .state = unitTypes[index];
//                   Navigator.of(context).pop();
//                 },
//               );
//             },
//             itemCount: unitTypes.length,
//           ),
//         ),
//       ],
//     ),
//   );
// }
}
