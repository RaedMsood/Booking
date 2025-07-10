import 'package:dio/dio.dart';
import '../../../generated/l10n.dart';
import 'erorr_model.dart';

class MessageOfErorrApi {
  static List<String> getExeptionMessage(DioException exception) {
    final message = exception.response?.data?['message'];

    if (message != null) {
      final error = ErrorsModel.fromJson(message);
      return [error.title, error.subTittle.toString()];
    } else {
      switch (exception.type) {
        case DioExceptionType.connectionError:
          return ["S.current.network", "S.current.network2", "S.current.cancel"];
        case DioExceptionType.connectionTimeout:
          return ["S.current.timeout", "S.current.pleaseTryAgain"];
        case DioExceptionType.badResponse:
        default:
          return ["S.current.network", "S.current.network2"];
      }
    }
  }
}
