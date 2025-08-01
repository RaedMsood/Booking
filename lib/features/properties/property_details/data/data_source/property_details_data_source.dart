import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../models/property_details_model.dart';

class PropertyDetailsDataSource {
  PropertyDetailsDataSource();

  Future<PropertyDetailsModel> getPropertyDetails({
    required int id,
  }) async {
    final response = await RemoteRequest.getData(
        url: AppURL.propertyDetails, query: {'property_id': id});

    return PropertyDetailsModel.fromJson(response.data['data']);
  }
}
