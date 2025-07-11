import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../generated/l10n.dart';
import '../theme/app_colors.dart';
import 'auto_size_text_widget.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  final Function()? onPressed;

  const NoInternetConnectionWidget({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: 500.h,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.signal_wifi_connected_no_internet_4_rounded,
            size: 54.sp,
          ),
          10.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).timeout,
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
          4.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).network2,
            colorText: AppColors.fontColor,
            fontWeight: FontWeight.bold,
            fontSize: 13.5.sp,
          ),
        ],
      ),
    );
  }
}
