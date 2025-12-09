import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/models/deposit_model.dart';
import 'general_container_for_details_widget.dart';

class DepositWidget extends StatelessWidget {
  final DepositModel deposit;
  const DepositWidget({super.key, required this.deposit});

  @override
  Widget build(BuildContext context) {
    return GeneralContainerForDetailsWidget(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: S.of(context).deposit,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: "%${deposit.depositRatio}",
            fontSize: 12.sp,
            colorText: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),

          if(deposit.policy.isNotEmpty)...[
            8.h.verticalSpace,
            AutoSizeTextWidget(
              text: deposit.policy,
              fontSize: 11.5.sp,
              colorText: AppColors.greySwatch.shade700,
              fontWeight: FontWeight.w400,
            ),
          ],

        ],
      ),
    );
  }
}
