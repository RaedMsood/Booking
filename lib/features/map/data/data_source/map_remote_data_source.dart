import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../../../properties/home/data/model/property_data_model.dart';
import '../model/position_properties_model.dart';

class MapRemoteDataSource {
  MapRemoteDataSource();
  Future<List<PositionPropertiesModel>> getPositionProperties() async {
    final response = await RemoteRequest.getData(
      url: AppURL.propertyPosition,
    );
    return PositionPropertiesModel.fromJsonList(response.data['data']);
  }
  Future<PropertyDataModel> getPropertiesFromPosition(int idProperty) async {
    final response = await RemoteRequest.getData(
      url: AppURL.propertyFromPosition,
      query: {
        'property_id':idProperty
      }
    );
    return PropertyDataModel.fromJson(response.data['data']);
  }
}