import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../booking_model/booking_data.dart';
import '../booking_model/booking_data_model.dart';

class BookingDataSource {
  Future<BookingData> checkBookingFromHotel({
    required BookingData bookingData,
  }) async {
    final response = await RemoteRequest.postData(
      path: AppURL.checkBookingHotel,
      data: bookingData.toJson(),
    );
    final parsed = BookingData.fromJson(response.data['data']['id']);
    return parsed.copyWith(
      totalPrice: parsed.totalPrice ?? bookingData.totalPrice,
      price: parsed.price ?? bookingData.price,
      hasDiscount: parsed.hasDiscount || bookingData.hasDiscount,
    );
  }

  Future<BookingDataModel> custemorDataForBooking({
    required CustomerModel custemor,
  }) async {
    final response = await RemoteRequest.postData(
      path: AppURL.custemorForBooking,
      data: custemor.toJson(),
    );
    final parsed = BookingDataModel.fromJson(response.data['data']);
    final requestBooking = custemor.booking;
    if (requestBooking == null) return parsed;

    return BookingDataModel(
      bookingData: parsed.bookingData.copyWith(
        totalPrice: parsed.bookingData.totalPrice ?? requestBooking.totalPrice,
        price: parsed.bookingData.price ?? requestBooking.price,
        hasDiscount: parsed.bookingData.hasDiscount || requestBooking.hasDiscount,
      ),
      customer: parsed.customer,
    );
  }
}
