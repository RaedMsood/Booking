// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
// import '../../../../../core/state/data_state.dart';
// import '../../../../../core/state/state.dart';
// import '../../../../../core/widgets/loading_widget.dart';
// import '../../data/model/units_model.dart';
// import '../riverpod/unit_riverpod.dart';
// import 'unit_card_widget.dart';
//
// class ListOfUnitsWidget extends StatelessWidget {
//   final int propertyId;
//   final String nameProp;
//   final String location;
//   final String image;
//   final ScrollController scrollController;
//   final DataState<SectionsModel> state;
//
//   const ListOfUnitsWidget({
//     super.key,
//     required this.propertyId,
//     required this.scrollController,
//     required this.location,
//     required this.nameProp,
//     required this.image,
//     required this.state,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final units = state.data.units.data;
//
//     return ListView.builder(
//       controller: scrollController,
//       padding: EdgeInsets.all(14.sp),
//       itemCount:
//       units.length + ((state.stateData == States.loadingMore) ? 1 : 0),
//       itemBuilder: (context, index) {
//         if (index == units.length) {
//           if (state.stateData == States.loadingMore) {
//             return const CircularProgressIndicatorWidget();
//           }
//           return const SizedBox.shrink();
//         }
//
//         return UnitCardWidget(
//           units: units[index],
//           image: image,
//           location: location,
//           nameProp: nameProp,
//         );
//       },
//     );
//   }
// }
//
// // class UnitsPage extends ConsumerStatefulWidget {
// //   final int propertyId;
// //   final String nameProp;
// //   final String location;
// //   final String image;
// //
// //   const UnitsPage(
// //       {super.key,
// //       required this.propertyId,
// //       required this.location,
// //       required this.nameProp,
// //       required this.image});
// //
// //   @override
// //   ConsumerState<UnitsPage> createState() => _UnitsPageState();
// // }
// //
// // class _UnitsPageState extends ConsumerState<UnitsPage> {
// //   final ScrollController _scrollController = ScrollController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _scrollController.addListener(_onScroll);
// //   }
// //
// //   void _onScroll() {
// //     // ============ Pagination ============
// //     if (_scrollController.position.pixels >=
// //         _scrollController.position.maxScrollExtent - 100) {
// //       final state = ref.read(getAllUnitsProvider(1));
// //       if (state.stateData != States.loadingMore) {
// //         ref
// //             .read(getAllUnitsProvider(widget.propertyId).notifier)
// //             .getData(moreData: true);
// //       }
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     _scrollController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: const SecondaryAppBarWidget(title: ""),
// //       body: SafeArea(
// //         top: false,
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Padding(
// //               padding:
// //                   EdgeInsets.symmetric(horizontal: 14.w).copyWith(top: 6.h),
// //               child: AutoSizeTextWidget(
// //                 text: "${S.of(context).roomsFor} ${widget.nameProp}",
// //                 fontSize: 13.6.sp,
// //                 fontWeight: FontWeight.w500,
// //                 maxLines: 2,
// //                 minFontSize: 12,
// //               ),
// //             ),
// //             8.h.verticalSpace,
// //             ListOfUnitsWidget(
// //               scrollController: _scrollController,
// //               propertyId: widget.propertyId,
// //               image: widget.image,
// //               location: widget.location,
// //               nameProp: widget.nameProp,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
//
// // class ListOfUnitsWidget extends ConsumerWidget {
// //   final int propertyId;
// //   final String nameProp;
// //   final String location;
// //   final String image;
// //   final ScrollController scrollController;
// //
// //   const ListOfUnitsWidget(
// //       {super.key,
// //       required this.propertyId,
// //       required this.scrollController,
// //       required this.location,
// //       required this.nameProp,
// //       required this.image});
// //
// //   @override
// //   Widget build(BuildContext context, ref) {
// //     var state = ref.watch(getAllUnitsProvider(propertyId));
// //
// //     return CheckStateInGetApiDataWidget(
// //       state: state,
// //       widgetOfData: Expanded(
// //         child: ListView.builder(
// //           controller: scrollController,
// //           padding: EdgeInsets.all(14.sp),
// //           itemBuilder: (context, index) {
// //             if (index == state.data.data.length) {
// //               if (state.stateData == States.loadingMore) {
// //                 return const CircularProgressIndicatorWidget();
// //               }
// //             }
// //             return UnitCardWidget(
// //               units: state.data.data[index],
// //               image: image,
// //               location: location,
// //               nameProp: nameProp,
// //             );
// //           },
// //           itemCount: state.data.data.length +
// //               ((state.stateData == States.loadingMore) ? 1 : 0),
// //         ),
// //       ),
// //     );
// //   }
// // }
