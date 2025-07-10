import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'realty_card_widget.dart';

class RealEstateListWidget extends StatelessWidget {
  const RealEstateListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        // physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(18.sp),
        itemBuilder: (context, index) {
          return RealtyCardWidget();
        },
        itemCount: 3,
      
      ),
    );
  }
}
