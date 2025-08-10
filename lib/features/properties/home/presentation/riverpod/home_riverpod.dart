import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart';
import '../../../units/data/model/units_model.dart';
import '../../../search_and_filter/data/model/filter_data_model.dart';
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


