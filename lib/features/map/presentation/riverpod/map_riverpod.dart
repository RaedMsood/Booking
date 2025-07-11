import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/state.dart';
import '../../../../core/state/state_data.dart';
import '../../data/model/city_model.dart';
import '../../data/repos/map_repo.dart';

final selectedCityProvider = StateProvider<CityModel?>((ref) => null);
final selectedCityErrorProvider = StateProvider<String?>((ref) => null);

final getCitiesProvider = StateNotifierProvider.autoDispose<GetCitiesNotifier,
    DataState<List<CityModel>>>(
  (ref) {
    return GetCitiesNotifier();
  },
);

class GetCitiesNotifier extends StateNotifier<DataState<List<CityModel>>> {
  GetCitiesNotifier() : super(DataState<List<CityModel>>.initial([])) {
    getData();
  }

  final _controller = MapReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.getCities();
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}
