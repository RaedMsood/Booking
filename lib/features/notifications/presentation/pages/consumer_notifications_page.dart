import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../state_mangment/notifications_riverpod.dart';
import '../widget/list_of_notifications_widget.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(notificationProvider);
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).notificationsTitle),
      body: SafeArea(
        top: false,
        child: CheckStateInGetApiDataWidget(
          state: state,
          widgetOfData: ListOfNotificationsWidget(
            getNotifications: state.data,
          ),
        ),
      ),
    );
  }
}
