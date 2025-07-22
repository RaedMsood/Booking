import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../riverpod/unit_riverpod.dart';
import 'unit_card_widget.dart';

class ListOfUnitsWidget extends ConsumerWidget {
  final int propertyId;

  final ScrollController scrollController;

  const ListOfUnitsWidget({
    super.key,
    required this.propertyId,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getAllUnitsProvider(propertyId));

    return CheckStateInGetApiDataWidget(
      state: state,
      widgetOfData: Expanded(
        child: ListView.builder(
          controller: scrollController,
          padding: EdgeInsets.all(14.sp),
          itemBuilder: (context, index) {
            if (index == state.data.data.length) {
              if (state.stateData == States.loadingMore) {
                return const CircularProgressIndicatorWidget();
              }
            }
            return UnitCardWidget(units: state.data.data[index]);
          },
          itemCount: state.data.data.length +
              ((state.stateData == States.loadingMore ) ? 1 : 0),
        ),
      ),
    );
  }
}
