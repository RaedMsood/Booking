import 'package:booking/features/properties/units/data/model/units_model.dart';

import '../../../../../core/network/remote_request.dart';
import '../../../../../core/network/urls.dart';
import '../../../../../core/state/pagination_data/paginated_model.dart';
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

  Future<SectionsModel> getAllUnits({
    required int propertyId,
    required int page,
    required int sectionId,
    int perPage = 4,
  }) async {
    final response = await RemoteRequest.getData(
      url: "${AppURL.getAllUnis}/$propertyId",
      query: {
        'page': page,
        'perPage': perPage,
        'sectionId': sectionId,
      },
    );

    return SectionsModel.fromJson(  response.data['data']);
    // return PaginationModel<UnitsModel>.fromJson(
    //   response.data['data'],
    //   (prop) {
    //     return UnitsModel.fromJson(prop);
    //   },
    // );
  }
}
