import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../home/data/model/property_model.dart';
import '../../../home/data/model/property_pagination_model.dart';
import '../../data/model/city_model.dart';
import '../../data/repos/cities_repo.dart';
final sselectedCityProvider = StateProvider.family<CityModel?,CityModel>((ref,init) {
  return init;
});

final selectedCityProvider = StateProvider<CityModel?>((ref) => null);
final selectedCityErrorProvider = StateProvider<String?>((ref) => null);

final getAllCitiesProvider = StateNotifierProvider<GetAllCitiesNotifier,
    DataState<List<CityModel>>>(
      (ref) {
    return GetAllCitiesNotifier();
  },
);

class GetAllCitiesNotifier extends StateNotifier<DataState<List<CityModel>>> {
  GetAllCitiesNotifier() : super(DataState<List<CityModel>>.initial([])) {
    getData();
  }

  final _controller = CitiesReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.getAllCities();
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final getPropertiesByCityProvider = StateNotifierProvider
    .family<GetPropertiesByCityNotifier, DataState<PropertyModel>, Tuple3<int,String,String>>(
      (ref, params) {
    return GetPropertiesByCityNotifier(params.value1,params.value2,params.value3);
  },
);

class GetPropertiesByCityNotifier
    extends StateNotifier<DataState<PropertyModel>> {
  final int cityId;
  String sortBy;
  String idsAmenities;
  GetPropertiesByCityNotifier(this.cityId,this.sortBy,this.idsAmenities)
      : super(DataState<PropertyModel>.initial(PropertyModel.empty())) {
    getData();
  }

  final _controller = CitiesReposaitory();

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

    final result = await _controller.getPropertiesByCity(
      page: nextPage,
      cityId: cityId,
      sortBy: sortBy,
idsAmenities: idsAmenities
    );

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
}


final getFilterCitiesTypeProvider =
StateNotifierProvider<GetFilterTypeCitiesNotifier, String?>(
        (ref) {
      return GetFilterTypeCitiesNotifier();
    });

class GetFilterTypeCitiesNotifier extends StateNotifier<String?> {
  GetFilterTypeCitiesNotifier() : super(null);

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
final getFeaturesCitiesProvider =
StateNotifierProvider<GetFeaturesCitiesNotifier, String?>(
      (ref) => GetFeaturesCitiesNotifier(),
);

class GetFeaturesCitiesNotifier extends StateNotifier<String?> {
  GetFeaturesCitiesNotifier() : super(null);

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