import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/notifications_model.dart';
import 'notifications_widget.dart';

class ListOfNotificationsWidget extends StatelessWidget {
  final List<NotificationsModel> getNotifications;

  const ListOfNotificationsWidget({super.key, required this.getNotifications});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      primary: true,
      padding: EdgeInsets.all(15.sp),
      itemBuilder: (context, index) {
        return NotificationsWidget(
          data: getNotifications[index],
          index: index,
        );
      },
      itemCount: getNotifications.length,
    );
  }
}
