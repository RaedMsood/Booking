import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../booking/presentation/riverpod/booking_riverpod.dart';
import '../../data/models/rate_with_customer_model.dart';
import 'customer_of_score_widget.dart';
import 'general_container_for_details_widget.dart';
import 'list_of_score_in_rate_widget.dart';

class ListOfAllScoresCustemorWidget extends ConsumerWidget {
  const ListOfAllScoresCustemorWidget({
    super.key,
    required this.rateOfScore,
  });

  final List<RateWithCustomerModel> rateOfScore;

  @override
  Widget build(BuildContext context, ref) {
    return ListView.builder(
      itemCount: rateOfScore.length,
      itemBuilder: (context, index) {
        var isShow = ref.watch(showAllScoreInRateProvider(index));

        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomerOfScoreAndRateWidget(
                    name: rateOfScore[index].customerName ?? '',
                    timeScore: rateOfScore[index].timeScore ?? '',
                    rateOfScore: rateOfScore[index].avg,
                  ),
                  8.h.verticalSpace,
                  ListOfScoreInRateWidget(
                    isShowAllScore: isShow ?? false,
                    score: rateOfScore[index].allScore ?? [],
                  ),
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(showAllScoreInRateProvider(index).notifier)
                          .setShowAllScoreInRate();
                    },
                    child: Icon(
                      isShow == false
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                      size: 25.w,
                      color: const Color(0xff757575),
                    ),
                  ),
                ],
              ),
            ),
            12.verticalSpace,
          ],
        );
      },
    );
  }
}
