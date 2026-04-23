import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../../core/state/state.dart';
import '../../../property_details/data/models/features_model.dart';
import '../../../units/data/model/units_model.dart';
import '../../data/model/filter_data_model.dart';
import '../../../home/data/model/property_data_model.dart';
import '../../data/repos/search_and_filter_repo.dart';

enum SearchFilterResultMode { property, unit }

final appliedSearchResultModeProvider =
    StateProvider<SearchFilterResultMode>((ref) {
  return SearchFilterResultMode.property;
});

final pendingSearchResultModeProvider =
    StateProvider.autoDispose<SearchFilterResultMode>((ref) {
  return ref.read(appliedSearchResultModeProvider);
});

final selectedDateRangeProvider = StateProvider<DateTimeRange?>((ref) => null);

final currentPriceRangeProvider = StateProvider<RangeValues?>((ref) => null);

final selectedUnitTypesProvider =
    StateProvider<CityOrUnitTypesModel?>((ref) => null);

final selectACityToFilterProvider =
    StateProvider<CityOrUnitTypesModel?>((ref) => null);

final selectedRatingProvider = StateProvider<List<double?>>((ref) => []);

final selectedFeaturesProvider =
    StateNotifierProvider.family<SelectedFeaturesNotifier, List<bool>, int>(
  (ref, count) => SelectedFeaturesNotifier(count),
);

class SelectedFeaturesNotifier extends StateNotifier<List<bool>> {
  SelectedFeaturesNotifier(int count) : super(List<bool>.filled(count, false));

  void toggle(int index) {
    state = [
      for (var i = 0; i < state.length; i++)
        if (i == index) !state[i] else state[i],
    ];
  }
}

///////////////////////////////////////////////////////////////////////////////////

final searchAndFilterPropertiesProvider = StateNotifierProvider.autoDispose<
    SearchAndFilterPropertiesNotifier,
    DataState<PaginationModel<PropertyDataModel>>>(
  (ref) {
    return SearchAndFilterPropertiesNotifier();
  },
);

class SearchAndFilterPropertiesNotifier
    extends StateNotifier<DataState<PaginationModel<PropertyDataModel>>> {
  SearchAndFilterPropertiesNotifier()
      : super(DataState<PaginationModel<PropertyDataModel>>.initial(
            PaginationModel.empty())) {
    getData();
  }

  int? unitTypeId;
  int? cityId;
  List<int> featuresIds = [];
  DateTime? dateFrom;
  DateTime? dateTo;
  RangeValues? priceRange;
  List<int> rating = [];
  TextEditingController searchController = TextEditingController();

  final _controller = SearchAndFilterReposaitory();

  void _setStateIfMounted(DataState<PaginationModel<PropertyDataModel>> value) {
    if (!mounted) return;
    state = value;
  }

  Future<void> getData({bool moreData = false}) async {
    if (!mounted) return;

    if (moreData && state.data.currentPage >= state.data.lastPage) {
      return;
    }
    if (moreData) {
      _setStateIfMounted(state.copyWith(state: States.loadingMore));
    } else {
      _setStateIfMounted(state.copyWith(state: States.loading));
    }

    final nextPage = moreData ? state.data.currentPage + 1 : 1;

    final result = await _controller.searchAndFilterProperties(
      page: nextPage,
      search: searchController.text,
      dateFrom: dateFrom,
      dateTo: dateTo,
      cityId: cityId,
      unitTypeId: unitTypeId,
      featureIds: featuresIds,
      priceFrom: priceRange?.start.toInt(),
      priceTo: priceRange?.end.toInt(),
      rating: rating,
    );

    if (!mounted) return;

    result.fold(
      (failure) {
        _setStateIfMounted(
          state.copyWith(state: States.error, exception: failure),
        );
      },
      (newData) {
        _setStateIfMounted(state.success(newData, moreData));
      },
    );
  }

  Future<void> search() async {
    if (!mounted) return;

    _setStateIfMounted(state.copyWith(
      data: PaginationModel.empty(),
      state: States.initial,
    ));

    await getData();
  }

  Future<void> filter(
    WidgetRef ref, {
    required List<FeaturesModel> features,
  }) async {
    dateFrom = ref.read(selectedDateRangeProvider)?.start;
    dateTo = ref.read(selectedDateRangeProvider)?.end;
    cityId = ref.read(selectACityToFilterProvider.notifier).state?.id;
    unitTypeId = ref.read(selectedUnitTypesProvider.notifier).state?.id;
    final selectedFeatures = ref.read(selectedFeaturesProvider(features.length));
    featuresIds = [
      for (int i = 0; i < features.length; i++)
        if (selectedFeatures[i]) features[i].id,
    ];
    priceRange = ref.read(currentPriceRangeProvider);
    if (ref.read(selectedRatingProvider.notifier).state.isNotEmpty) {
      rating = ref
          .read(selectedRatingProvider.notifier)
          .state
          .whereType<double>()
          .map((e) => e.toInt())
          .toList();
    }

    if (!mounted) return;

    _setStateIfMounted(state.copyWith(
      data: PaginationModel.empty(),
      state: States.initial,
    ));

    await getData();
  }

  Future<void> undoFiltering(
    WidgetRef ref, {
    required List<FeaturesModel> features,
    required double minPrice,
    required double maxPrice,
  }) async {
    ref.read(selectedDateRangeProvider.notifier).state = null;
    ref.read(selectACityToFilterProvider.notifier).state = null;
    ref.read(selectedUnitTypesProvider.notifier).state = null;
    ref.read(selectedFeaturesProvider(features.length).notifier).state =
        List<bool>.filled(features.length, false);
    ref.read(currentPriceRangeProvider.notifier).state =
        RangeValues(minPrice, maxPrice);
    ref.read(selectedRatingProvider.notifier).state = [];
    dateFrom = null;
    dateTo = null;
    cityId = null;
    unitTypeId = null;
    featuresIds = [];
    priceRange = null;
    rating = [];

    if (!mounted) return;

    _setStateIfMounted(state.copyWith(
      data: PaginationModel.empty(),
      state: States.initial,
    ));
    await getData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

/////////////////////////////////////////////////////////////////////////

final searchAndFilterUnitsProvider = StateNotifierProvider.autoDispose<
    SearchAndFilterUnitsNotifier,
    DataState<PaginationModel<UnitsModel>>>(
  (ref) {
    return SearchAndFilterUnitsNotifier();
  },
);

class SearchAndFilterUnitsNotifier
    extends StateNotifier<DataState<PaginationModel<UnitsModel>>> {
  SearchAndFilterUnitsNotifier()
      : super(DataState<PaginationModel<UnitsModel>>.initial(
            PaginationModel.empty())) {
    getData();
  }

  int? unitTypeId;
  int? cityId;
  List<int> featuresIds = [];
  DateTime? dateFrom;
  DateTime? dateTo;
  RangeValues? priceRange;
  List<int> rating = [];
  TextEditingController searchController = TextEditingController();

  final _controller = SearchAndFilterReposaitory();

  void _setStateIfMounted(DataState<PaginationModel<UnitsModel>> value) {
    if (!mounted) return;
    state = value;
  }

  Future<void> getData({bool moreData = false}) async {
    if (!mounted) return;

    if (moreData && state.data.currentPage >= state.data.lastPage) {
      return;
    }
    if (moreData) {
      _setStateIfMounted(state.copyWith(state: States.loadingMore));
    } else {
      _setStateIfMounted(state.copyWith(state: States.loading));
    }

    final nextPage = moreData ? state.data.currentPage + 1 : 1;

    final result = await _controller.searchAndFilterUnits(
      page: nextPage,
      search: searchController.text,
      dateFrom: dateFrom,
      dateTo: dateTo,
      cityId: cityId,
      unitTypeId: unitTypeId,
      featureIds: featuresIds,
      priceFrom: priceRange?.start.toInt(),
      priceTo: priceRange?.end.toInt(),
      rating: rating,
    );

    if (!mounted) return;

    result.fold(
      (failure) {
        _setStateIfMounted(
          state.copyWith(state: States.error, exception: failure),
        );
      },
      (newData) {
        _setStateIfMounted(state.success(newData, moreData));
      },
    );
  }

  Future<void> search() async {
    if (!mounted) return;

    _setStateIfMounted(state.copyWith(
      data: PaginationModel.empty(),
      state: States.initial,
    ));

    await getData();
  }

  Future<void> filter(
    WidgetRef ref, {
    required List<FeaturesModel> features,
  }) async {
    dateFrom = ref.read(selectedDateRangeProvider)?.start;
    dateTo = ref.read(selectedDateRangeProvider)?.end;
    cityId = ref.read(selectACityToFilterProvider.notifier).state?.id;
    unitTypeId = ref.read(selectedUnitTypesProvider.notifier).state?.id;
    final selectedFeatures = ref.read(selectedFeaturesProvider(features.length));
    featuresIds = [
      for (int i = 0; i < features.length; i++)
        if (selectedFeatures[i]) features[i].id,
    ];
    priceRange = ref.read(currentPriceRangeProvider);
    if (ref.read(selectedRatingProvider.notifier).state.isNotEmpty) {
      rating = ref
          .read(selectedRatingProvider.notifier)
          .state
          .whereType<double>()
          .map((e) => e.toInt())
          .toList();
    }

    if (!mounted) return;

    _setStateIfMounted(state.copyWith(
      data: PaginationModel.empty(),
      state: States.initial,
    ));

    await getData();
  }

  Future<void> undoFiltering(
    WidgetRef ref, {
    required List<FeaturesModel> features,
    required double minPrice,
    required double maxPrice,
  }) async {
    ref.read(selectedDateRangeProvider.notifier).state = null;
    ref.read(selectACityToFilterProvider.notifier).state = null;
    ref.read(selectedUnitTypesProvider.notifier).state = null;
    ref.read(selectedFeaturesProvider(features.length).notifier).state =
        List<bool>.filled(features.length, false);
    ref.read(currentPriceRangeProvider.notifier).state =
        RangeValues(minPrice, maxPrice);
    ref.read(selectedRatingProvider.notifier).state = [];
    dateFrom = null;
    dateTo = null;
    cityId = null;
    unitTypeId = null;
    featuresIds = [];
    priceRange = null;
    rating = [];

    if (!mounted) return;

    _setStateIfMounted(state.copyWith(
      data: PaginationModel.empty(),
      state: States.initial,
    ));
    await getData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

/////////////////////////////////////////////////////////////////////////

final getFilterDataProvider =
    StateNotifierProvider<GetFilterDataNotifier, DataState<FilterDataModel>>(
  (ref) {
    return GetFilterDataNotifier();
  },
);

class GetFilterDataNotifier extends StateNotifier<DataState<FilterDataModel>> {
  GetFilterDataNotifier()
      : super(
          DataState<FilterDataModel>.initial(FilterDataModel.empty()),
        ) {
    getData();
  }

  final _controller = SearchAndFilterReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.getFilterData();
    data.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (data) {
        state = state.copyWith(
          state: States.loaded,
          data: data,
        );
      },
    );
  }
}
