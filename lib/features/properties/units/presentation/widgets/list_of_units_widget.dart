import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../data/model/units_model.dart';
import '../riverpod/unit_riverpod.dart';
import 'unit_card_widget.dart';

class ListOfUnitsWidget extends StatelessWidget {
  final int propertyId;
  final String nameProp;
  final String location;
  final String image;
  final ScrollController scrollController;
  final DataState<SectionsModel> state;

  const ListOfUnitsWidget({
    super.key,
    required this.propertyId,
    required this.scrollController,
    required this.location,
    required this.nameProp,
    required this.image,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final units = state.data.units.data;

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(14.sp),
      itemCount:
      units.length + ((state.stateData == States.loadingMore) ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == units.length) {
          if (state.stateData == States.loadingMore) {
            return const CircularProgressIndicatorWidget();
          }
          return const SizedBox.shrink();
        }

        return UnitCardWidget(
          units: units[index],
          image: image,
          location: location,
          nameProp: nameProp,
        );
      },
    );
  }
}


// class ListOfUnitsWidget extends ConsumerWidget {
//   final int propertyId;
//   final String nameProp;
//   final String location;
//   final String image;
//   final ScrollController scrollController;
//
//   const ListOfUnitsWidget(
//       {super.key,
//       required this.propertyId,
//       required this.scrollController,
//       required this.location,
//       required this.nameProp,
//       required this.image});
//
//   @override
//   Widget build(BuildContext context, ref) {
//     var state = ref.watch(getAllUnitsProvider(propertyId));
//
//     return CheckStateInGetApiDataWidget(
//       state: state,
//       widgetOfData: Expanded(
//         child: ListView.builder(
//           controller: scrollController,
//           padding: EdgeInsets.all(14.sp),
//           itemBuilder: (context, index) {
//             if (index == state.data.data.length) {
//               if (state.stateData == States.loadingMore) {
//                 return const CircularProgressIndicatorWidget();
//               }
//             }
//             return UnitCardWidget(
//               units: state.data.data[index],
//               image: image,
//               location: location,
//               nameProp: nameProp,
//             );
//           },
//           itemCount: state.data.data.length +
//               ((state.stateData == States.loadingMore) ? 1 : 0),
//         ),
//       ),
//     );
//   }
// }
