import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';

class BookingSuccessDialogWidget extends ConsumerWidget {
  const BookingSuccessDialogWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 88.h,
            width: 94.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.primarySwatch.shade800,
                  AppColors.primarySwatch.shade700,
                  AppColors.primarySwatch.shade500,
                  AppColors.primarySwatch.shade400.withValues(alpha: .92),
                ],
              ),
            ),
            child: Icon(
              Icons.check_sharp,
              color: Colors.white,
              size: 38.sp,
            ),
          ),
          14.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).successfully,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).bookingConfirmed,
            fontSize: 12.sp,
            colorText: AppColors.fontColor,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          16.h.verticalSpace,
          DefaultButtonWidget(
            text: S.of(context).backToMyBookings,
            width: 160.w,
            height: 38.h,
            textSize: 11.sp,
            onPressed: () {
              ref.read(activeIndexProvider.notifier).state = 2;
              navigateAndFinish(context, const BottomNavigationBarWidget());
            },
          ),
        ],
      ),
    );
  }
}

class CompleteBooking {
  static successDialog(BuildContext context, ref) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return const Dialog(
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          child: BookingSuccessDialogWidget(),
        );
      },
    ).then((v) {
      ref.read(activeIndexProvider.notifier).state = 2;
      navigateAndFinish(context, const BottomNavigationBarWidget());
    });
  }
}
