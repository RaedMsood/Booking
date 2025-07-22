import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart';
import '../../data/models/property_details_model.dart';
import '../../data/repos/property_details_repo.dart';

final getPropertyDetailsProvider = StateNotifierProvider.family<
    GetPropertyDetailsNotifier, DataState<PropertyDetailsModel>, int>(
  (ref, int id) {
    return GetPropertyDetailsNotifier(id);
  },
);

class GetPropertyDetailsNotifier
    extends StateNotifier<DataState<PropertyDetailsModel>> {
  final int id;

  GetPropertyDetailsNotifier(this.id)
      : super(
          DataState<PropertyDetailsModel>.initial(PropertyDetailsModel.empty()),
        ) {
    getData();
  }

  final _controller = sl<PropertyDetailsReposaitory>();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.getPropertyDetails(id: id);
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
