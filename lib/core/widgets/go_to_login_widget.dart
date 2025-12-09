import 'package:booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/user/presentation/pages/log_in_page.dart';
import '../../generated/l10n.dart';
import '../constants/app_images.dart';
import '../helpers/navigateTo.dart';
import 'auto_size_text_widget.dart';
import 'buttons/default_button.dart';

class GoToLoginWidget extends StatelessWidget {
  const GoToLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:  EdgeInsets.all(14.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.errorNetwork),
            14.h.verticalSpace,
             AutoSizeTextWidget(
              text: S.of(context).openOffersWorldTitle,
              fontSize: 13.4.sp,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            8.h.verticalSpace,
            AutoSizeTextWidget(
              text: S.of(context).openOffersWorldSubtitle,
              fontSize: 11.sp,
              textAlign: TextAlign.center,
              maxLines: 2,
              colorText: AppColors.mainColorFont,
            ),
            20.h.verticalSpace,
            DefaultButtonWidget(
              text: S.of(context).logIn,
              width: 160.w,
              height: 36.h,
              onPressed: () {
                navigateTo(context, const LogInPage());
              },
            )
          ],
        ),
      ),
    );
  }
}
