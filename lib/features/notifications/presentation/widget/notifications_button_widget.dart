import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../services/auth/auth.dart';
import '../../../user/presentation/pages/log_in_page.dart';
import '../pages/consumer_notifications_page.dart';
import '../state_mangment/notifications_riverpod.dart';

class NotificationsButtonWidget extends ConsumerWidget {
  final Color? colorIcon;
  const NotificationsButtonWidget({super.key,this.colorIcon});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final unread = ref.watch(unreadCountProvider);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButtonWidget(
          icon: AppIcons.notification,
          iconColor: colorIcon??Colors.black,
          onPressed: () async {
            if (!Auth().loggedIn) {
              navigateTo(context, const LogInPage());
            } else {
              navigateTo(context, const NotificationsPage());
              ref.read(unreadCountProvider.notifier).refresh();
            }
          },
        ),
        // if (unread > 0)
          Positioned(
            left: unread >= 10 ? 4.w : 8.w,
            top: 1.8,
            child: Container(
              padding: EdgeInsets.all(unread >= 10 ? 1.sp : 1.sp),
              decoration: BoxDecoration(
                color: AppColors.dangerColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white,width: 0.8.w
                ),
              ),
              child: AutoSizeTextWidget(
                text: unread > 99 ? '99+' : ' 7 ',
                colorText: Colors.white,
                fontSize: 7.2.sp,
                minFontSize: 6,
              ),
            ),
          ),
      ],
    );  }
}
