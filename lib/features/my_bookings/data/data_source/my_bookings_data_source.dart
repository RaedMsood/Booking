import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../model/my_bookings_data.dart';
import '../model/rate_model.dart';

class MyBookingsDataSource {
  Future<PaginationModel<MyBookingsData>> getBookingTypeFilter({
    required int filterType,
    required int page,
    int perPage = 5,
  }) async {
    final response = await RemoteRequest.getData(
      url: "${AppURL.getBookingType}$filterType",
      query: {
        'page': page,
        'perPage': 4,
      },
    );

    return PaginationModel<MyBookingsData>.fromJson(
      response.data['data'] ?? response.data,
      (book) {
        return MyBookingsData.fromJson(book);
      },
    );
  }

  Future<Unit> rateTheProperty(
      {required List<RateModel> rate,
      required int idProperty,
      required int idBooking}) async {
    final response = await RemoteRequest.postData(
      path: AppURL.rateProperty,
      data: {
        "property_id": idProperty,
        "criteria": RateModel.toJsonList(rate),
        'booking_id': idBooking
      },
    );
    debugPrint(response.statusCode.toString());

    return Future.value(unit);
  }
}
