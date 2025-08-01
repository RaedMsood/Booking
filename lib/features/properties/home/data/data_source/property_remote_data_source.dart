import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
import '../model/property_data_model.dart';
import '../model/property_model.dart';

class PropertyRemoteDataSource {
  PropertyRemoteDataSource();

  Future<PropertyModel> getAllProperty({
    required int page,
    int perPage = 5,
  }) async {
    final response = await RemoteRequest.getData(
      url: AppURL.property,
      query: {
        'page': page,
        'perPage': perPage,
      },
    );

    return PropertyModel.fromJson(response.data['data']);
  }

  // Get Search Results And Filter Properties
  Future<PaginationModel<PropertyDataModel>> searchAndFilterProperties({
    required int page,
    int perPage = 5,
    String? search,
    int? cityId,
    int? priceFrom,
    int? priceTo,
    int? unitId,
    List<int>? featureId,
  }) async {
    final response = await RemoteRequest.getData(
      url: AppURL.getSearchResultsAndFilterProperties,
      query: {
        'page': page,
        'perPage': perPage,
        'search': search,
        'city_id': cityId,
        'price_from': priceFrom,
        'price_to': priceTo,
        'unit_type': unitId,
        'amenities': featureId,
      },
    );
    return PaginationModel<PropertyDataModel>.fromJson(
      response.data['data'],
      (prop) {
        return PropertyDataModel.fromJson(prop);
      },
    );
  }
}
