import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../my_bookings/presentation/widgets/invoice_widget.dart';

class BillSummaryWidget extends StatelessWidget {
  final dynamic deposit;
  final dynamic totalPrice;

  const BillSummaryWidget({
    super.key,
    required this.deposit,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InvoiceRowWidget(
            label: S.of(context).grandTotal,
            price: totalPrice.toString(),
            fontSizeLabel: 11.4.sp,
            fontSizePrice: 12.2.sp,
            fontSizeSecondText: 9.8.sp,
            firstColor: const Color(0xff605A65),
            textColor: const Color(0xff292D32),
          ),
          4.verticalSpace,
          const Divider(color: Color(0xffF0F0F0)),
          4.verticalSpace,
          InvoiceRowWidget(
            label: S.of(context).depositAmount,
            price: deposit.toString(),
            fontSizeLabel: 11.4.sp,
            fontSizePrice: 12.2.sp,
            fontSizeSecondText: 9.8.sp,
            textColor: const Color(0xff292D32),
            firstColor: const Color(0xff605A65),
          ),
          8.verticalSpace,
          InvoiceRowWidget(
            label: S.of(context).remainingAfterDeposit,
            price: (totalPrice - deposit).toString(),
            firstColor: AppColors.primaryColor,
            fontSizeLabel: 11.4.sp,
            fontSizePrice: 12.2.sp,
            fontSizeSecondText: 9.8.sp,
            textColor: const Color(0xff292D32),
          ),
        ]),
      ),
    );
  }
}
