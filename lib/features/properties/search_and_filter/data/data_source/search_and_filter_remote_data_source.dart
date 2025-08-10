import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../../../home/data/model/property_data_model.dart';
import '../model/filter_data_model.dart';

class SearchAndFilterRemoteDataSource {
  // Get Search Results And Filter Properties
  Future<PaginationModel<PropertyDataModel>> searchAndFilterProperties({
    required int page,
    int perPage = 5,
    String? search,
    DateTime? dateFrom,
    DateTime? dateTo,
    int? cityId,
    int? priceFrom,
    int? priceTo,
    int? unitTypeId,
    List<int>? featureIds,
    List<int>?rating,
  }) async {
    if (rating!.isNotEmpty) {
    }
    final response = await RemoteRequest.getData(
      url: AppURL.searchAndFilterProperties,
      query: {
        'page': page,
        'perPage': perPage,
        'search': search,
        if (dateFrom != null) 'date_from': dateFrom,
        if (dateTo != null) 'date_to': dateTo,
        if (cityId != null) 'city_id': cityId,
        'price_from': priceFrom,
        'price_to': priceTo,
        if (unitTypeId != null) 'unit_type': unitTypeId,
        if (featureIds!.isNotEmpty) 'amenities': featureIds,
      },
    );
    return PaginationModel<PropertyDataModel>.fromJson(
      response.data['data'],
      (prop) {
        return PropertyDataModel.fromJson(prop);
      },
    );
  }

  Future<FilterDataModel> getFilterData() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getFilterData,
    );

    return FilterDataModel.fromJson(response.data['data']);
  }
}
