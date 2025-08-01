import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart';
import '../../data/model/property_data_model.dart';
import '../../data/model/property_model.dart';
import '../../data/model/property_pagination_model.dart';
import '../../data/repos/property_repo.dart';

final scrollOffsetProvider = StateProvider<double>((ref) => 0.0);

class HomePropertyViewType {
  static int list = 1;
  static int grid = 2;
}

final getAllPropertyProvider =
    StateNotifierProvider<GetAllPropertyNotifier, DataState<PropertyModel>>(
  (ref) {
    return GetAllPropertyNotifier();
  },
);

class GetAllPropertyNotifier extends StateNotifier<DataState<PropertyModel>> {
  GetAllPropertyNotifier()
      : super(DataState<PropertyModel>.initial(PropertyModel.empty())) {
    getData();
  }

  int viewType = HomePropertyViewType.list;

  final _controller = sl<PropertyReposaitory>();

  Future<void> getData({bool moreData = false}) async {
    if (moreData &&
        state.data.property.currentPage >= state.data.property.lastPage) {
      return;
    }
    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    final nextPage = moreData ? state.data.property.currentPage + 1 : 1;

    final result = await _controller.getAllProperty(page: nextPage);

    result.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (data) {
        var oldData = state.data;

        if (oldData.cities.isNotEmpty) {
          PropertyPaginationModel property;
          property = oldData.property.copyWith(
            data: [...oldData.property.data, ...data.property.data],
            currentPage: data.property.currentPage,
          );
          oldData = oldData.copyWith(property: property);
        } else {
          oldData = data;
        }
        state = state.copyWith(state: States.loaded, data: oldData);
      },
    );
  }

  changeViewType(int viewType) {
    this.viewType = viewType;
    state = state.copyWith(state: States.loaded);
  }
}

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

  final _controller = sl<PropertyReposaitory>();

  TextEditingController searchController = TextEditingController();

  Future<void> getData({bool moreData = false}) async {
    if (moreData && state.data.currentPage >= state.data.lastPage) {
      return;
    }
    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    final nextPage = moreData ? state.data.currentPage + 1 : 1;

    final result = await _controller.searchAndFilterProperties(
      page: nextPage,
      search: searchController.text,
    );

    result.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (newData) {
        state = state.success(newData, moreData);
      },
    );
  }

  Future<void> search() async {
    // state = state.copyWith(
    //   data: state.data.copyWith(
    //     products: state.data.products.copyWith(
    //       data: [],
    //       currentPage: 0,
    //     ),
    //   ),
    // );
    state = state.copyWith(
      data: PaginationModel.empty(),
      state: States.initial,
    );

    await getData();
  }
}
