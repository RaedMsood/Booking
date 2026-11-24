import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../model/property_model.dart';

class PropertyRemoteDataSource {
  PropertyRemoteDataSource();

  Future<PropertyModel> getAllProperty({
    required int page,
    int perPage = 5,
    String? sortBy,
    String? idsAmenities,
  }) async {
    print(sortBy);
    final response = await RemoteRequest.getData(
      url: AppURL.property,
      query: {
        'page': page,
        'perPage': 4,
        'sort_by': sortBy,
        'amenities': idsAmenities,
      },
    );

    return PropertyModel.fromJson(response.data['data']);
  }
}
