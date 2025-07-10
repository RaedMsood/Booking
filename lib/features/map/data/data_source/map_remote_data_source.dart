import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../model/city_model.dart';

class MapRemoteDataSource {
  MapRemoteDataSource();

  Future<List<CityModel>> getCities() async {
    final response = await RemoteRequest.getData(
      url: AppURL.getCities,
    );
    return CityModel.fromJsonList(response.data['data']);
  }
}
