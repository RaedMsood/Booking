import 'package:dartz/dartz.dart';
import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../booking_model/booking_model.dart';

class BookingDataSource{

  Future<Unit> checkBookingFromHotel({
    required BookingData bookingData,
  }) async {

    await RemoteRequest.postData(
      path:  AppURL.checkBookingHotel,
      data: bookingData.toJson(),
    );
    return Future.value(unit);
  }

  Future<PaginationModel<BookingData>> getBookingTypeFilter({
    required int filterType,
    required int page,
    int perPage = 5,

  }) async {
    final response = await RemoteRequest.getData(
      url: "${AppURL.getBookingType}$filterType",
      query: {
        'page': page,
        'perPage': 5,
      },
    );

    return PaginationModel<BookingData>.fromJson(
      response.data['data'],
          (book) {
        return BookingData.fromJson(book);
      },
    );
  }
}