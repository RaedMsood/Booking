import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RatingBarWidget extends StatelessWidget {
  final double evaluation;
  final int? length;
  final double? itemSize;

  const RatingBarWidget({
    super.key,
    required this.evaluation,
    this.length,
    this.itemSize,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: evaluation,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ignoreGestures: true,
      itemCount: length ?? 5,
      itemSize: itemSize ?? 14.sp,
      itemBuilder: (context, index) {
        return Icon(Icons.star_purple500_sharp,color: Color(0xfffbcc2b),);
      },
      onRatingUpdate: (rating) {},
    );
  }
}
