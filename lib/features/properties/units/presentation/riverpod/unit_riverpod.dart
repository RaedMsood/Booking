import 'package:dartz/dartz.dart';
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



final getAllUnitsProvider =
StateNotifierProvider.family<GetAllUnitsNotifier, DataState<SectionsModel>, Tuple2<int, int>>(
      (ref, params) {
    final int propertyId = params.value1;
    final int sectionId = params.value2;
    return GetAllUnitsNotifier(propertyId, sectionId);
  },
);

class GetAllUnitsNotifier extends StateNotifier<DataState<SectionsModel>> {
  final int propertyId;
  final int sectionId;

  GetAllUnitsNotifier(this.propertyId, this.sectionId)
      : super(DataState<SectionsModel>.initial(SectionsModel.empty())) {
    // أول تحميل
    getData();
  }

  final UnitReposaitory _controller = sl<UnitReposaitory>();

  Future<void> getData({
    bool moreData = false,
    bool isRefresh = false,
  }) async {
    // منع طلب المزيد لو وصلنا آخر صفحة
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
          // تحميل المزيد لنفس القسم → ندمج الوحدات
          final PaginationModel<UnitsModel> units =
          oldData.units.copyWith(
            data: [...oldData.units.data, ...data.units.data],
            currentPage: data.units.currentPage,
            lastPage: data.units.lastPage,
          );

          // نحافظ على الأقسام اللي كانت موجودة من قبل أو نحدثها من الـ API
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
// final getAllUnitsProvider = StateNotifierProvider.autoDispose
//     .family<GetAllUnitsNotifier, DataState<SectionsModel>, int>(
//   (ref, int propertyId) {
//     return GetAllUnitsNotifier(propertyId);
//   },
// );
//
// class GetAllUnitsNotifier extends StateNotifier<DataState<SectionsModel>> {
//   final int propertyId;
//
//   GetAllUnitsNotifier(this.propertyId)
//       : super(DataState<SectionsModel>.initial(SectionsModel.empty())) {
//     // getData();
//   }
//
//   final _controller = sl<UnitReposaitory>();
//
//   Future<void> getData({required int sectionId, bool moreData = false}) async {
//     if (moreData && state.data.units.currentPage >= state.data.units.lastPage) {
//       return;
//     }
//     if (moreData) {
//       state = state.copyWith(state: States.loadingMore);
//     } else {
//       state = state.copyWith(state: States.loading);
//     }
//
//     final nextPage = moreData ? state.data.units.currentPage + 1 : 1;
//
//     final result = await _controller.getAllUnits(
//       page: nextPage,
//       propertyId: propertyId,
//       sectionId: sectionId,
//     );
//
//     result.fold(
//       (failure) {
//         state = state.copyWith(state: States.error, exception: failure);
//       },
//       (data) {
//         // state = state.success(newData, moreData);
//         var oldData = state.data;
//
//         if (oldData.sections.isNotEmpty) {
//           PaginationModel units;
//           units = oldData.units.copyWith(
//             data: [...oldData.units.data, ...data.units.data],
//             currentPage: data.units.currentPage,
//           );
//           oldData = oldData.copyWith(units: units);
//         } else {
//           oldData = data;
//         }
//         state = state.copyWith(state: States.loaded, data: oldData);
//       },
//     );
//   }
// }
