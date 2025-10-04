import '../../../../core/network/remote_request.dart';
import '../../../../core/network/urls.dart';
import '../model/notifications_model.dart';


class NotificationsRemoteDataSource {
  NotificationsRemoteDataSource();

  Future<List<NotificationsModel>> getNotifications() async {
    final response = await RemoteRequest.getData(url: AppURL.notification);

      return NotificationsModel.fromJsonList(response.data);

  }
  }