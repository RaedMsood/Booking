import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../generated/l10n.dart';
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
              text: isCity ? S.of(context).governorate : S.of(context).roomType,
              fontSize: 11.sp,
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
                          (isCity ? S.of(context).selectGovernorate : S.of(context).selectRoomType),
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
}
