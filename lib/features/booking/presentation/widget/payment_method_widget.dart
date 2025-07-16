import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class PaymentMethodsWidget extends StatefulWidget {
  const PaymentMethodsWidget({super.key});

  @override
  State<PaymentMethodsWidget> createState() => _PaymentMethodsWidgetState();
}
class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget> {
  String selectedMethod = 'فلوسك';

  final List<Map<String, String>> methods = [
    {'label': 'عبر الكريمي', 'icon': 'assets/images/krimy.png'},
    {'label': 'ون كاش', 'icon': 'assets/images/one_cash.png'},
    {'label': 'محفظة جوالي', 'icon': 'assets/images/krimy.png'},
    {'label': 'فلوسك', 'icon': 'assets/images/one_cash.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: 'وسائل الدفع',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 12.h),
            Column(
              children: methods.map((method) => _buildPaymentOption(method)).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(Map<String, String> method) {
    bool isSelected = selectedMethod == method['label'];
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = method['label']!),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 3.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,

        ),
        child: Row(
          children: [

            SizedBox(width: 8.w),
            Image.asset(method['icon']!, width: 35.w, height: 35.w, fit: BoxFit.fill),
            SizedBox(width: 12.w),
            Expanded(
              child: AutoSizeTextWidget(
                text: method['label']!,
                fontSize: 11.sp,
                fontWeight: FontWeight.w400,
              ),
            ), Radio<String>(
              value: method['label']!,
              groupValue: selectedMethod,

              onChanged: (value) => setState(() => selectedMethod = value!),
              activeColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}