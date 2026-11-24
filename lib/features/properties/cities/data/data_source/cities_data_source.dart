import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../../../home/data/model/property_model.dart';
import '../model/city_model.dart';

class CitiesRemoteDataSource {
  CitiesRemoteDataSource();

  Future<List<CityModel>> getAllCities() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getCities,
    );
    return CityModel.fromJsonList(response.data['data']);
  }
  Future<PropertyModel> getPropertiesByCity({
    required int page,
    required int cityId,
    String? sortBy,
    String? idsAmenities,
    int perPage = 5,
  }) async {
    final response = await RemoteRequest.getData(
      url: AppURL.propertiesByCity,
      query: {
        'page': page,
        'perPage': perPage,
        'city_id': cityId,
        'sort_by': sortBy,
        'amenities': idsAmenities,
      },
    );

    return PropertyModel.fromJson(response.data['data']);
  }
}