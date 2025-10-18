import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/state/data_state.dart';
import '../../../../core/state/state.dart';
import '../../data/model/notifications_model.dart';
import '../../data/repository/notifications_repository.dart';

final notificationProvider = StateNotifierProvider.autoDispose<NotificationNotifier,
    DataState<List<NotificationsModel>>>((ref) => NotificationNotifier());

class NotificationNotifier
    extends StateNotifier<DataState<List<NotificationsModel>>> {
  NotificationNotifier() : super(DataState<List<NotificationsModel>>.initial([])) {
    getNotifications();
  }

  final _controller = ReposaitoriesNotifications();

  Future<void> getNotifications() async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.getNotifications();
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}