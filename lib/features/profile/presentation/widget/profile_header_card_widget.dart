import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../../../user/presentation/pages/log_in_page.dart';

class ProfileHeaderCardWidget extends StatelessWidget {
  final VoidCallback? onLogoutSuccess;

  const ProfileHeaderCardWidget({super.key, this.onLogoutSuccess});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!Auth().loggedIn) {
          navigateTo(context, const LogInPage());
        }
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        child: Visibility(
          visible: Auth().loggedIn,
          replacement: AutoSizeTextWidget(
            text: S.of(context).logIn,
            colorText: AppColors.primaryColor,
            fontSize: 12.8.sp,
            textAlign: TextAlign.center,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text: Auth().name,
                fontSize: 12.5.sp,
              ),
              5.h.verticalSpace,
              AutoSizeTextWidget(
                text: Auth().phoneNumber,
                colorText: AppColors.primaryColor,
                fontSize: 11.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
