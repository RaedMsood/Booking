import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../../core/state/state.dart';
import '../../../../../injection.dart';
import '../../data/model/sections_model.dart';
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

final selectedUnitsSectionIdProvider =
StateProvider.family<int?, int>((ref, propertyId) => null);

final getAllUnitsProvider =
StateNotifierProvider.family<GetAllUnitsNotifier, DataState<UnitsInPropertySectionsModel>, Tuple2<int, int>>(
      (ref, params) {
    final int propertyId = params.value1;
    final int sectionId = params.value2;
    return GetAllUnitsNotifier(propertyId, sectionId);
  },
);

class GetAllUnitsNotifier extends StateNotifier<DataState<UnitsInPropertySectionsModel>> {
  final int propertyId;
  final int sectionId;

  GetAllUnitsNotifier(this.propertyId, this.sectionId)
      : super(DataState<UnitsInPropertySectionsModel>.initial(UnitsInPropertySectionsModel.empty())) {
    getData();
  }

  final UnitReposaitory _controller = sl<UnitReposaitory>();

  Future<void> getData({
    bool moreData = false,
    bool isRefresh = false,
  }) async {
    if (moreData &&
        !isRefresh &&
        state.data.units.currentPage >= state.data.units.lastPage &&
        state.data.units.currentPage != 0) {
      return;
    }

    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    final int nextPage;
    if (isRefresh || state.data.units.currentPage == 0) {
      nextPage = 1;
    } else if (moreData) {
      nextPage = state.data.units.currentPage + 1;
    } else {
      nextPage = 1;
    }

    final result = await _controller.getAllUnits(
      page: nextPage,
      propertyId: propertyId,
      sectionId: sectionId,
    );

    result.fold(
          (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
          (data) {
        var oldData = state.data;

        // أول مرة أو refresh → نبدّل الداتا بالكامل
        if (oldData.units.data.isEmpty || isRefresh || !moreData) {
          oldData = data;
        } else {
          final PaginationModel<UnitsModel> units =
          oldData.units.copyWith(
            data: [...oldData.units.data, ...data.units.data],
            currentPage: data.units.currentPage,
            lastPage: data.units.lastPage,
          );
          oldData = oldData.copyWith(
            sections: data.sections.isNotEmpty ? data.sections : oldData.sections,
            units: units,
          );
        }

        state = state.copyWith(
          state: States.loaded,
          data: oldData,
        );
      },
    );
  }
}
