import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/filter_data_model.dart';
import '../riverpod/search_and_filter_riverpod.dart';
import '../widgets/features_filter_widget.dart';
import '../widgets/filter_and_undo_filter_button_widget.dart';
import '../widgets/filter_by_date_widget.dart';
import '../widgets/filter_by_unit_or_city_widget.dart';
import '../widgets/price_filter_widget.dart';
import '../widgets/rating_filter_widget.dart';
import '../widgets/search_result_mode_toggle_widget.dart';

class FilterPage extends ConsumerWidget {
  const FilterPage({super.key});

  void _applyForMode(
    WidgetRef ref,
    SearchFilterResultMode mode,
    FilterDataModel data,
  ) {
    final propertySearchText =
        ref.read(searchAndFilterPropertiesProvider.notifier).searchController.text;

    ref.read(appliedSearchResultModeProvider.notifier).state = mode;

    if (mode == SearchFilterResultMode.property) {
      ref.read(searchAndFilterPropertiesProvider.notifier).filter(
            ref,
            features: data.features,
          );
      return;
    }

    ref.read(searchAndFilterUnitsProvider.notifier).searchController.text =
        propertySearchText;
    ref.read(searchAndFilterUnitsProvider.notifier).filter(
          ref,
          features: data.features,
        );
  }

  void _undoForMode(
    WidgetRef ref,
    SearchFilterResultMode mode,
    FilterDataModel data,
  ) {
    final propertySearchText =
        ref.read(searchAndFilterPropertiesProvider.notifier).searchController.text;

    ref.read(appliedSearchResultModeProvider.notifier).state = mode;

    if (mode == SearchFilterResultMode.property) {
      ref.read(searchAndFilterPropertiesProvider.notifier).undoFiltering(
            ref,
            features: data.features,
            maxPrice: double.tryParse(data.maxPrice) ?? 0.0,
            minPrice: double.tryParse(data.minPrice) ?? 0.0,
          );
      return;
    }

    ref.read(searchAndFilterUnitsProvider.notifier).searchController.text =
        propertySearchText;
    ref.read(searchAndFilterUnitsProvider.notifier).undoFiltering(
          ref,
          features: data.features,
          maxPrice: double.tryParse(data.maxPrice) ?? 0.0,
          minPrice: double.tryParse(data.minPrice) ?? 0.0,
        );
  }

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getFilterDataProvider);
    final pendingMode = ref.watch(pendingSearchResultModeProvider);

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
              const SearchResultModeToggleWidget(),
              12.h.verticalSpace,
              FilterByUnitOrCityWidget(unitTypes: state.data.unitTypes),
              12.h.verticalSpace,
              const FilterByDateWidget(),
              FilterByUnitOrCityWidget(
                unitTypes: state.data.cities,
                isCity: true,
              ),
              12.h.verticalSpace,
              PriceFilterWidget(
                maxPrice: double.tryParse(state.data.maxPrice) ?? 0.0,
                minPrice: double.tryParse(state.data.minPrice) ?? 0.0,
              ),
              AutoSizeTextWidget(
                text: S.of(context).features,
                fontSize: 11.sp,
                colorText: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
              FeaturesFilterWidget(
                features: state.data.features,
              ),
              AutoSizeTextWidget(
                text: S.of(context).rating,
                fontSize: 11.sp,
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
                    _applyForMode(ref, pendingMode, state.data);

                    Navigator.of(context).pop();
                  },
                  clickOnUndoFilter: () {
                    _undoForMode(ref, pendingMode, state.data);
                  },
                ),
    );
  }
}
