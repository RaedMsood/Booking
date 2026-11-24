import 'package:booking/generated/l10n.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart';
import '../../data/model/property_model.dart';
import '../../data/model/property_pagination_model.dart';
import '../../data/repos/property_repo.dart';

final scrollOffsetProvider = StateProvider<double>((ref) => 0.0);

class HomePropertyViewType {
  static int list = 1;
  static int grid = 2;
}

final getAllPropertyProvider = StateNotifierProvider.family<
    GetAllPropertyNotifier, DataState<PropertyModel>, Tuple2<String, String>>(
  (ref,params) {
    return GetAllPropertyNotifier(sortBy:params.value1, idsAmenities: params.value2);
  },
);

class GetAllPropertyNotifier extends StateNotifier<DataState<PropertyModel>> {
  GetAllPropertyNotifier({required this.idsAmenities, required this.sortBy})
      : super(DataState<PropertyModel>.initial(PropertyModel.empty())) {
    getData();
  }

  int viewType = HomePropertyViewType.list;
  String sortBy;
  String idsAmenities;
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

    final result = await _controller.getAllProperty(
        page: nextPage, idsAmenities: idsAmenities, sortBy: sortBy);

    print(sortBy);
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

final getFilterTypeProvider =
    StateNotifierProvider<GetFilterTypeNotifier, String?>(
        (ref) {
  return GetFilterTypeNotifier();
});

class GetFilterTypeNotifier extends StateNotifier<String?> {
  GetFilterTypeNotifier() : super(null);

  void setSectionFilterNumber(int numberFilter) {
    switch (numberFilter) {
      case 0:
        state = 'most_booked';
      case 1:
        state = 'price_desc';

      case 2:
        state = 'price_asc';
      case 3:
        state = 'highest_rated';
      default:
        state = '';
    }
  }
}
final getFeaturesProvider =
StateNotifierProvider<GetFeaturesNotifier, String?>(
      (ref) => GetFeaturesNotifier(),
);

class GetFeaturesNotifier extends StateNotifier<String?> {
  GetFeaturesNotifier() : super(null);

  void setFeaturesNumber(int featureId) {
    List<String> ids = state?.split(',') ?? [];

    if (ids.contains(featureId.toString())) {
      ids.remove(featureId.toString());
    } else {
      ids.add(featureId.toString());
    }

    state = ids.isEmpty ? null : ids.join(',');
  }



}