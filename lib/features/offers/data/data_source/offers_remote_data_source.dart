import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../../../../core/state/pagination_data/paginated_model.dart';
import '../model/specific_offer_details_model.dart';
import '../model/specific_offer_model.dart';

class OffersRemoteDataSource {
  Future<PaginationModel<SpecificOfferModel>> getBestOffers({
    required int page,
    int perPage = 5,
  }) async {
    final response = await RemoteRequest.getData(
      url: AppURL.bestOffers,
      query: {
        'page': page,
        'perPage': perPage,
      },
    );

    return PaginationModel<SpecificOfferModel>.fromJson(
      response.data['data'] ?? response.data,
      (offer) {
        return SpecificOfferModel.fromJson(offer);
      },
    );
  }

  Future<SpecificOfferDetailsModel> getOfferDetails({
    required int offerId,
    int? propertyId,
  }) async {
    final response = await RemoteRequest.getData(
      url: '${AppURL.offerDetails}/$offerId',
      query: propertyId == null
          ? null
          : {
              'property_id': propertyId,
            },
    );

    return SpecificOfferDetailsModel.fromJson(response.data['data'] ?? response.data);
  }
}

