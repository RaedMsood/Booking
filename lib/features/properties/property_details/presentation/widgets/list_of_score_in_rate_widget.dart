import 'package:booking/features/my_bookings/data/model/rate_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../my_bookings/presentation/widgets/rating_row_widget.dart';

class ListOfScoreInRateWidget extends StatelessWidget {
 const ListOfScoreInRateWidget(

      {super.key, required this.isShowAllScore, required this.score});

  final bool isShowAllScore;
  final List<RateModel> score;



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 6.0.h),
          child: RatingRowWidget(
            title: score[index].nameOfRate ?? '',
            value: double.parse(score[index].numberOfRate.toString()),
            onChanged: (v) {},
          ),
        );
      },
      itemCount: isShowAllScore == false ? 2 : score.length,
    );
  }
}
