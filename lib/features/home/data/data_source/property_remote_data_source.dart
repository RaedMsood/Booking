import 'package:booking/features/home/data/model/property_model.dart';

import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';

class PropertyRemoteDataSource {
  PropertyRemoteDataSource();

  Future<PaginationModel<PropertyModel>> getProperty({
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

    return PaginationModel<PropertyModel>.fromJson(
      response.data['data'],
      (prop) {
        return PropertyModel.fromJson(prop);
      },
    );
  }
}
