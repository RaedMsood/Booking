import 'package:booking/core/state/check_state_in_get_api_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../state_mangment/notifications_riverpod.dart';
import '../widget/list_of_notifications_widget.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(notificationProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const AutoSizeTextWidget(
          text: 'الاشعارات',
        ),
      ),
      body: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfData: ListOfNotificationsWidget(
          getNotifications: state.data,
        ),
      ),
    );
  }
}
