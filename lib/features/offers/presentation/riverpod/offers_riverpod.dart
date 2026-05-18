import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/state/data_state.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../core/state/state.dart';
import '../../data/model/specific_offer_model.dart';
import '../../data/reposaitory/offers_reposaitory.dart';

final getBestOffersProvider = StateNotifierProvider<GetBestOffersNotifier,
    DataState<PaginationModel<SpecificOfferModel>>>(
  (ref) {
    return GetBestOffersNotifier();
  },
);

class GetBestOffersNotifier
    extends StateNotifier<DataState<PaginationModel<SpecificOfferModel>>> {
  GetBestOffersNotifier()
      : super(DataState<PaginationModel<SpecificOfferModel>>.initial(
            PaginationModel.empty())) {
    getBestOffers();
  }

  final _controller = OffersReposaitory();

  Future<void> getBestOffers({bool moreData = false}) async {
    if (moreData && state.data.currentPage >= state.data.lastPage) {
      return;
    }

    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    final nextPage = moreData ? state.data.currentPage + 1 : 1;

    final result = await _controller.getBestOffers(page: nextPage);

    result.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (newData) {
        state = state.success(newData, moreData);
      },
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(
      state: States.loading,
      data: PaginationModel.empty(),
    );
    await getBestOffers();
  }
}

