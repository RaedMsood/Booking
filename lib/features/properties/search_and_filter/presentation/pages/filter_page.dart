import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../generated/l10n.dart';
import '../riverpod/search_and_filter_riverpod.dart';
import '../widgets/features_filter_widget.dart';
import '../widgets/filter_and_undo_filter_button_widget.dart';
import '../widgets/filter_by_date_widget.dart';
import '../widgets/filter_by_unit_or_city_widget.dart';
import '../widgets/price_filter_widget.dart';
import '../widgets/rating_filter_widget.dart';

class FilterPage extends ConsumerWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getFilterDataProvider);

    return Scaffold(
      extendBody: true,
      appBar: SecondaryAppBarWidget(title: S.of(context).filterTitle),
      body: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfData: SingleChildScrollView(
          padding: EdgeInsets.all(14.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FilterByDateWidget(),
              FilterByUnitOrCityWidget(
                unitTypes: state.data.cities,
                isCity: true,
              ),
              FilterByUnitOrCityWidget(unitTypes: state.data.unitTypes),
              12.h.verticalSpace,
              PriceFilterWidget(
                maxPrice: double.tryParse(state.data.maxPrice) ?? 0.0,
                minPrice: double.tryParse(state.data.minPrice) ?? 0.0,
              ),
              AutoSizeTextWidget(
                text: S.of(context).features,
                fontSize: 12.sp,
                colorText: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
              FeaturesFilterWidget(
                features: state.data.features,
              ),
              AutoSizeTextWidget(
                text: S.of(context).rating,
                fontSize: 12.sp,
                colorText: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
              const RatingFilterWidget(),
              70.h.verticalSpace,
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          state.stateData == States.loading || state.stateData == States.error
              ? null
              : FilterAndUndoFilterButtonWidget(
                  clickOnFilter: () {
                    ref.read(searchAndFilterPropertiesProvider.notifier).filter(
                          ref,
                          features: state.data.features,
                        );

                    Navigator.of(context).pop();
                  },
                  clickOnUndoFilter: () {
                    ref
                        .read(searchAndFilterPropertiesProvider.notifier)
                        .undoFiltering(
                          ref,
                          features: state.data.features,
                          maxPrice: double.tryParse(state.data.maxPrice) ?? 0.0,
                          minPrice: double.tryParse(state.data.minPrice) ?? 0.0,
                        );
                  },
                ),
    );
  }
}
