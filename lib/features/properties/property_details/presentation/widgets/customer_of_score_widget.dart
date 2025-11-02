import 'package:booking/features/properties/property_details/presentation/widgets/rate_of_score_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class CustomerOfScoreAndRateWidget  extends StatelessWidget {
  const CustomerOfScoreAndRateWidget ({super.key,required  this.name,required this.timeScore,required this.rateOfScore});

  final String name;
final String timeScore;
final dynamic rateOfScore;
@override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: name,
              fontSize: 11.8.sp,
            ),
            2.6.h.verticalSpace,
            AutoSizeTextWidget(
              text:timeScore,
              fontSize: 8.sp,
              colorText: const Color(0xff788988),
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
        const  Spacer(),
         RateOfScoreWidget(rateOfScore: rateOfScore,),
      ],
    );
  }
}
