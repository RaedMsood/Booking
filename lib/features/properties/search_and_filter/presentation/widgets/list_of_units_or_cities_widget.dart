import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../cities/presentation/widget/design_for_cities_widget.dart';
import '../../data/model/filter_data_model.dart';
import '../riverpod/search_and_filter_riverpod.dart';

class ListOfUnitsOrCitiesWidget extends StatelessWidget {
  final List<CityOrUnitTypesModel> unitTypes;

  final bool isCity;

  const ListOfUnitsOrCitiesWidget(
      {super.key, this.isCity = false, required this.unitTypes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 480.h,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          8.h.verticalSpace,
          Row(
            children: [
              14.w.horizontalSpace,
              AutoSizeTextWidget(
                text: isCity ? "المحافظة" : "نوع الغرفة",
                fontWeight: FontWeight.w400,
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
          Expanded(child: Consumer(
            builder: (context, ref, child) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 14.w)
                    .copyWith(top: 8.h, bottom: 14.h),
                itemBuilder: (context, index) {
                  return DesignForCitiesWidget(
                    name: unitTypes[index].name.toString(),
                    onTap: () {
                      ref
                          .read(isCity
                              ? selectACityToFilterProvider.notifier
                              : selectedUnitTypesProvider.notifier)
                          .state = unitTypes[index];
                      Navigator.of(context).pop();
                    },
                  );
                },
                itemCount: unitTypes.length,
              );
            },
          )),
        ],
      ),
    );
  }
}
