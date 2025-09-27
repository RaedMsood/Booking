import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../model/notifications_model.dart';
import '../source/notifications_remote.dart';


class ReposaitoriesNotifications  {

  ReposaitoriesNotifications();

  Future<Either<DioException, List<NotificationsModel>>> getNotifications() async {
    try {
      final update = await NotificationsRemoteDataSource().getNotifications();
      return Right(update);
    } on DioException catch (e) {
      return Left(e);
    }
  }
}