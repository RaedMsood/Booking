import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/data_state.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../../../../core/state/state.dart';
import '../../data/booking_model/booking_model.dart';
import '../../data/booking_model/status_model.dart';
import '../../data/reposaitory/booking_reposaitory.dart';

final checkBookingProvider =
    StateNotifierProvider.autoDispose<BookingNotifier, DataState<Unit>>(
  (ref) {
    return BookingNotifier();
  },
);

class BookingNotifier extends StateNotifier<DataState<Unit>> {
  BookingNotifier() : super(DataState<Unit>.initial(unit));
  final _controller = BookingReposaitory();

  checkBookingInHotel({required BookingData bookingData}) async {
    state = state.copyWith(state: States.loading);
    final buy =
        await _controller.checkBookingFromHotel(bookingData: bookingData);
    buy.fold((faliure) {
      state = state.copyWith(state: States.error, exception: faliure);
    }, (_) {
      state = state.copyWith(
        state: States.loaded,
      );
    });
  }
}

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

  final _controller = BookingReposaitory();

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
