import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../page/complete_add_booking_page.dart';

class DesginButtonInAddBookingWidget extends StatelessWidget {
  const DesginButtonInAddBookingWidget({super.key,required this.button});

  final Widget? button;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 70.h,
          width: double.infinity,
          color: Colors.white,
        ),
        Padding(
          padding:  EdgeInsets.all(14.0.sp),
          child:button,)
      ],
    );
  }
}
