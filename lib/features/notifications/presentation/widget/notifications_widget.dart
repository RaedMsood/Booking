import 'package:booking/core/helpers/navigateTo.dart';
import 'package:booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../my_bookings/presentation/pages/my_booking_details_page.dart';
import '../../../properties/property_details/presentation/pages/property_details_page.dart';
import '../../../properties/units/presentation/pages/unit_details_page.dart';
import '../../data/model/notifications_model.dart';
import '../state_mangment/notifications_riverpod.dart';

class NotificationsWidget extends ConsumerWidget {
  final NotificationsModel data;
  final int index;

  const NotificationsWidget(
      {super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRead = data.readAt != null;

    return GestureDetector(
      onTap: () {
        // if (data.readAt == null) {
        //   ref.read(notificationProvider.notifier).markAsRead(index: index);
        // }
        ref.read(notificationProvider.notifier).markAsRead(index: index);
        if (data.type == 'property') {
          navigateTo(
            context,
            PropertyDetailsPage(
              propertyId: data.typeId!,
              images: const <String>[],
            ),
          );
        } else if (data.type == 'booking') {
          navigateTo(
            context,
            MyBookingDetailsPage(
              bookingId: data.typeId!,
              isCompletedBook: false,
            ),
          );
        } else if (data.type == 'unit') {
          navigateTo(
            context,
            UnitDetailsPage(unitId: data.typeId!),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color:
                        isRead ? Colors.grey.shade300 : AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: Icon(
                    Icons.notifications,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: AutoSizeTextWidget(
                              text: data.title,
                              fontSize: 11.2.sp,
                              maxLines: 4,
                            ),
                          ),
                          6.w.horizontalSpace,
                          Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: AutoSizeTextWidget(
                              text: data.date,
                              fontSize: 8.sp,
                              colorText: AppColors.fontColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AutoSizeTextWidget(
                        text: data.message,
                        colorText: AppColors.fontColor,
                        fontSize: 10.sp,
                        maxLines: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
