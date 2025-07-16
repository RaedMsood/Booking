import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../page/complete_add_booking_page.dart';

class DesginButtonInAddBookingWidget extends StatelessWidget {
  const DesginButtonInAddBookingWidget({super.key,required this.onPressed,this.text});
  final Function()? onPressed;
  final String? text;
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
          child: DefaultButtonWidget(
            text:text?? "التالي",
            height: 44.h,
            width: double.infinity,
            borderRadius:15.r ,
            onPressed: onPressed
          ),
        )
      ],
    );
  }
}
