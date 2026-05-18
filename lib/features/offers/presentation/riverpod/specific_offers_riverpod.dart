import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/state/data_state.dart';
import '../../../../core/state/state.dart';
import '../../data/model/specific_offer_details_model.dart';
import '../../data/reposaitory/offers_reposaitory.dart';

final specificOfferDetailsProvider = StateNotifierProvider.autoDispose.family<
    SpecificOfferDetailsNotifier,
    DataState<SpecificOfferDetailsModel>,
    int>(
  (ref, offerId) {
    return SpecificOfferDetailsNotifier(offerId);
  },
);

class SpecificOfferDetailsNotifier
    extends StateNotifier<DataState<SpecificOfferDetailsModel>> {
  SpecificOfferDetailsNotifier(this.offerId)
      : super(DataState<SpecificOfferDetailsModel>.initial(
            SpecificOfferDetailsModel.empty())) {
    getData();
  }

  final int offerId;
  final _controller = OffersReposaitory();

  Future<void> getData({int? propertyId}) async {
    state = state.copyWith(state: States.loading);

    final result = await _controller.getOfferDetails(
      offerId: offerId,
      propertyId: propertyId,
    );

    result.fold(
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

  Future<void> selectProperty(int propertyId) async {
    if (state.data.selectedPropertyId == propertyId &&
        state.data.units.isNotEmpty) {
      return;
    }
    await getData(propertyId: propertyId);
  }

  Future<void> refresh() async {
    final selectedPropertyId = state.data.selectedPropertyId;
    await getData(propertyId: selectedPropertyId == 0 ? null : selectedPropertyId);
  }
}

