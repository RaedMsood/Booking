import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../model/sections_model.dart';
import '../model/unit_details_model.dart';

class UnitDataSource {
  UnitDataSource();

  Future<UnitDetailsModel> getUnitDetails({
    required int unitId,
  }) async {
    final response = await RemoteRequest.getData(
      url: "${AppURL.unitDetails}/$unitId",
    );
    return UnitDetailsModel.fromJson(response.data['data']);
  }

  Future<UnitsInPropertySectionsModel> getAllUnits({
    required int propertyId,
    required int page,
    required int sectionId,
    int perPage = 10,
  }) async {
    final response = await RemoteRequest.getData(
      url: "${AppURL.getAllUnis}/$propertyId",
      query: {
        'page': page,
        'perPage': perPage,
        'sectionId': sectionId,
      },
    );

    return UnitsInPropertySectionsModel.fromJson(response.data['data']);
  }
}
