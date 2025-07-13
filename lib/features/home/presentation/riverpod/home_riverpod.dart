import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/state.dart';
import '../../../../core/state/data_state.dart';
import '../../../../injection.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../../data/model/property_model.dart';
import '../../data/repos/property_repo.dart';

final scrollOffsetProvider = StateProvider<double>((ref) => 0.0);

final getPropertyProvider = StateNotifierProvider<GetPropertyNotifier,
    DataState<PaginationModel<PropertyModel>>>(
  (ref) {
    return GetPropertyNotifier();
  },
);

class GetPropertyNotifier
    extends StateNotifier<DataState<PaginationModel<PropertyModel>>> {
  GetPropertyNotifier()
      : super(DataState<PaginationModel<PropertyModel>>.initial(
            PaginationModel.empty())) {
    getData();
  }

  final _controller = sl<PropertyReposaitory>();

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

    final result = await _controller.getProperty(page: nextPage);

    result.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (newData) {
        final updatedData =
            moreData ? [...state.data.data, ...newData.data] : newData.data;
        state = state.copyWith(
          state: States.loaded,
          data: state.data.copyWith(
            data: updatedData,
            currentPage: newData.currentPage,
            lastPage: newData.lastPage,
          ),
        );
      },
    );
  }
}
