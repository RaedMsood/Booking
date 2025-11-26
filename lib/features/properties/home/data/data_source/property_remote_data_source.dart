import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
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
        'perPage': 4,
      },
    );


    return PropertyModel.fromJson(response.data['data']);
  }
}
