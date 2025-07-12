import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'real_estate_card_widget.dart';

class RealEstateListWidget extends StatelessWidget {
  const RealEstateListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
       physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return RealEstateCardWidget();
      },
      itemCount: 3,

    );
  }
}
