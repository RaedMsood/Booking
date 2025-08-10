import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/state.dart';
import '../../../../core/state/data_state.dart';
import '../../../properties/home/data/model/property_data_model.dart';
import '../../data/model/position_properties_model.dart';
import '../../data/repos/map_repo.dart';

final positionProvider = StateNotifierProvider<PositionNotifier,
    DataState<List<PositionPropertiesModel>>>((ref) => PositionNotifier());

class PositionNotifier
    extends StateNotifier<DataState<List<PositionPropertiesModel>>> {
  PositionNotifier()
      : super(DataState<List<PositionPropertiesModel>>.initial([])) {
    getPropertiesProperties();
  }

  final _controller = MapReposaitory();

  Future<void> getPropertiesProperties() async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.getPropertiesProperties();
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final propertyFromPositionProvider = StateNotifierProvider<
    PropertyFromPositionNotifier,
    DataState<PropertyDataModel>>((ref) => PropertyFromPositionNotifier());

class PropertyFromPositionNotifier
    extends StateNotifier<DataState<PropertyDataModel>> {
  PropertyFromPositionNotifier()
      : super(DataState<PropertyDataModel>.initial(PropertyDataModel.empty()));

  final _controller = MapReposaitory();

  Future<void> getPropertiesFromPosition({int? idProperty}) async {
    state = state.copyWith(state: States.loading);
    final user =
        await _controller.getPropertiesFromPosition(idProperty: idProperty!);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}
