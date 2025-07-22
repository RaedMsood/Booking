import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart';
import '../../data/model/unit_details_model.dart';
import '../../data/model/units_model.dart';
import '../../data/repos/unit_repo.dart';

final getUnitDetailsProvider = StateNotifierProvider.family<
    GetUnitDetailsNotifier, DataState<UnitDetailsModel>, int>(
  (ref, int unitId) {
    return GetUnitDetailsNotifier(unitId);
  },
);

class GetUnitDetailsNotifier
    extends StateNotifier<DataState<UnitDetailsModel>> {
  final int unitId;

  GetUnitDetailsNotifier(this.unitId)
      : super(
          DataState<UnitDetailsModel>.initial(UnitDetailsModel.empty()),
        ) {
    getData();
  }

  final _controller = sl<UnitReposaitory>();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.getUnitDetails(unitId: unitId);
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

final getAllUnitsProvider = StateNotifierProvider.autoDispose
    .family<GetAllUnitsNotifier, DataState<PaginationModel<UnitsModel>>, int>(
  (ref, int propertyId) {
    return GetAllUnitsNotifier(propertyId);
  },
);

class GetAllUnitsNotifier
    extends StateNotifier<DataState<PaginationModel<UnitsModel>>> {
  final int propertyId;

  GetAllUnitsNotifier(this.propertyId)
      : super(DataState<PaginationModel<UnitsModel>>.initial(
            PaginationModel.empty())) {
    getData();
  }

  final _controller = sl<UnitReposaitory>();

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

    final result =
        await _controller.getAllUnits(page: nextPage, propertyId: propertyId);

    result.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (newData) {
        state = state.success(newData, moreData);
      },
    );
  }
}
