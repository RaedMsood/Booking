import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/data_state.dart';
import '../../../../core/state/state.dart';
import '../../data/booking_model/booking_data.dart';
import '../../data/booking_model/booking_data_model.dart';
import '../../data/reposaitory/booking_reposaitory.dart';

final checkBookingProvider =
    StateNotifierProvider.autoDispose<BookingNotifier, DataState<BookingData>>(
  (ref) {
    return BookingNotifier();
  },
);

class BookingNotifier extends StateNotifier<DataState<BookingData>> {
  BookingNotifier()
      : super(DataState<BookingData>.initial(BookingData.empty()));
  final _controller = BookingReposaitory();

  checkBookingInHotel({required BookingData bookingData}) async {
    state = state.copyWith(state: States.loading);
    final buy =
        await _controller.checkBookingFromHotel(bookingData: bookingData);
    buy.fold((failure) {
      state = state.copyWith(state: States.error, exception: failure);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final customerBookingProvider = StateNotifierProvider.autoDispose<
    CustomerBookingNotifier, DataState<BookingDataModel>>(
  (ref) {
    return CustomerBookingNotifier();
  },
);

class CustomerBookingNotifier
    extends StateNotifier<DataState<BookingDataModel>> {
  CustomerBookingNotifier()
      : super(DataState<BookingDataModel>.initial(BookingDataModel.empty()));
  final _controller = BookingReposaitory();

  customerBooking({required CustomerModel customer}) async {
    state = state.copyWith(state: States.loading);
    final customers =
        await _controller.custemorDataForBooking(custemor: customer);
    customers.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}


final getIfPropertyRatedProvider = StateNotifierProvider.family<
    GetIfPropertyRatedNotifier, bool?, Tuple2<int?, int?>>((ref, idSection) {
  return GetIfPropertyRatedNotifier();
});

class GetIfPropertyRatedNotifier extends StateNotifier<bool?> {
  GetIfPropertyRatedNotifier() : super(null);

  void setIfPropertyRatedNumber(bool isRated) {
    state = isRated;
  }
}

final showAllScoreInRateProvider =
    StateNotifierProvider.family<ShowAllScoreInRateNotifier, bool?, int?>(
        (ref, index) {
  return ShowAllScoreInRateNotifier();
});

class ShowAllScoreInRateNotifier extends StateNotifier<bool?> {
  ShowAllScoreInRateNotifier() : super(false);

  void setShowAllScoreInRate() {
    state = !state!;
  }
}
