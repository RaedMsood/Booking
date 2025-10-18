import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/user/presentation/pages/log_in_page.dart';
import '../constants/app_images.dart';
import '../helpers/navigateTo.dart';
import 'auto_size_text_widget.dart';
import 'buttons/default_button.dart';

class GoToLoginWidget extends StatelessWidget {
  const GoToLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.errorNetwork),
            14.h.verticalSpace,
            const AutoSizeTextWidget(
              text: "افتح الباب لعالم العروض والحجوزات الخاصة بك",
            ),
            4.h.verticalSpace,
            AutoSizeTextWidget(
              text: "سجل دخولك الآن لتكتشف كل ما وفرناه لك من فرص رائعة",
              fontSize: 11.sp,
            ),
            20.h.verticalSpace,
            DefaultButtonWidget(
              text: 'تسجيل الدخول',
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
