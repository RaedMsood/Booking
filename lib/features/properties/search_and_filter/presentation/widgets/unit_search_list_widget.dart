import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../units/data/model/units_model.dart';
import '../../../units/presentation/widgets/unit_card_widget.dart';

class UnitSearchSliverListWidget extends StatelessWidget {
  const UnitSearchSliverListWidget({
    super.key,
    required this.units,
  });

  final List<UnitsModel> units;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 14.w)
          .copyWith(bottom: 14.h, top: 6.h),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return UnitCardWidget(units: units[index]);
          },
          childCount: units.length,
        ),
      ),
    );
  }
}

