import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/state/pagination_data/paginated_model.dart';
import '../data_source/offers_remote_data_source.dart';
import '../model/specific_offer_details_model.dart';
import '../model/specific_offer_model.dart';

class OffersReposaitory {
  final OffersRemoteDataSource _remoteDataSource = OffersRemoteDataSource();

  Future<Either<DioException, PaginationModel<SpecificOfferModel>>>
      getBestOffers({
    required int page,
    int perPage = 5,
  }) async {
    try {
      final remote = await _remoteDataSource.getBestOffers(
        page: page,
        perPage: perPage,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }

  Future<Either<DioException, SpecificOfferDetailsModel>> getOfferDetails({
    required int offerId,
    int? propertyId,
  }) async {
    try {
      final remote = await _remoteDataSource.getOfferDetails(
        offerId: offerId,
        propertyId: propertyId,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}

