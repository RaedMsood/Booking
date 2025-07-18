import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../../../generated/l10n.dart';

class VerifyPinputWidget extends StatelessWidget {
  final TextEditingController verifyController;

  const VerifyPinputWidget({super.key, required this.verifyController});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: verifyController,
      crossAxisAlignment: CrossAxisAlignment.center,
      length: 6,
      defaultPinTheme: PinTheme(
        width: 62.w,
        height: 44.h,
        textStyle: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: const Color(0xfff4f6f9),
          borderRadius: BorderRadius.circular(4.sp),
          border: Border.all(
            color: Colors.black12,
          ),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 62.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: const Color(0xfff4f6f9),
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(4.sp),
        ),
      ),
      validator: (value) {
        if (value == null || value.toString().isEmpty) {
          return S.of(context).pleaseEnterTheVerificationCode;
        }
      },
    );
  }
}
