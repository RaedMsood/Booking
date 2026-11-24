import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/network/urls.dart';
import '../data_source/chatbot_remote_data_source.dart';
import '../model/chat_response_model.dart';

class ChatbotRepository {
  final ChatbotRemoteDataSource _remoteDataSource = ChatbotRemoteDataSource();

  Future<Either<DioException, ChatResponseModel>> sendMessage({
    required String message,
    String? sessionId,
  }) async {
    try {
      final remote = await _remoteDataSource.sendMessage(
        message: message,
        sessionId: sessionId,
      );
      return Right(remote);
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(
        DioException(
          requestOptions: RequestOptions(path: AppURL.aiChatMessage),
          error: e,
        ),
      );
    }
  }
}
