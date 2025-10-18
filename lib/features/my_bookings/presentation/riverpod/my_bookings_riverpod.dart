import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/data_state.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../core/state/state.dart';
import '../../../booking/data/booking_model/booking_model.dart';
import '../../data/model/rate_model.dart';
import '../../data/model/status_model.dart';
import '../../data/repos/my_bookings_reposaitory.dart';

final getBookingProvider = StateNotifierProvider.family<GetBookingNotifier,
    DataState<PaginationModel<BookingData>>, int>(
  (ref, bookingType) {
    return GetBookingNotifier(bookingType);
  },
);

class GetBookingNotifier
    extends StateNotifier<DataState<PaginationModel<BookingData>>> {
  GetBookingNotifier(this.bookingType)
      : super(DataState<PaginationModel<BookingData>>.initial(
            PaginationModel.empty())) {
    getDataBookingType();
  }

  int bookingType;

  final _controller = MyBookingsReposaitory();

  Future<void> getDataBookingType({bool moreData = false}) async {
    if (moreData && state.data.currentPage >= state.data.lastPage) {
      return;
    }
    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    final nextPage = moreData ? state.data.currentPage + 1 : 1;

    final result = await _controller.getBookingTypeFilter(
        page: nextPage, filterType: bookingType);

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

final statusColorsProvider =
Provider.family<StatusColors, String>((ref, status) {
  switch (status) {
    case 'حالية':
      return const StatusColors(
        background: Color(0xffFFF3CD),
        text: Color(0xffFFA500),
      );
    case 'منتهيه':
      return const StatusColors(
        background: Color(0xffD4EDDA),
        text: Color(0xff28A745),
      );
    case 'ملغية':
      return const StatusColors(
        background: Color(0xffFFE2E2),
        text: Color(0xffFF4D4F),
      );
    default:
      return const StatusColors(
        background: Color(0xffFFE2E2),
        text: Color(0xffFF4D4F),
      );
  }
});

final ratePropertyProvider =
    StateNotifierProvider.autoDispose<RatePropertyNotifier, DataState<Unit>>(
  (ref) {
    return RatePropertyNotifier();
  },
);

class RatePropertyNotifier extends StateNotifier<DataState<Unit>> {
  RatePropertyNotifier() : super(DataState<Unit>.initial(unit));
  final _controller = MyBookingsReposaitory();

  rateProperty(
      {required List<RateModel> rate,
      required int idProperty,
      required int idBooking}) async {
    state = state.copyWith(state: States.loading);
    final rates = await _controller.rateTheProperty(
        rate: rate, idProperty: idProperty, idBooking: idBooking);
    rates.fold((failure) {
      state = state.copyWith(state: States.error, exception: failure);
    }, (data) {
      state = state.copyWith(
        state: States.loaded,
      );
    });
  }
}


