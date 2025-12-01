import 'dart:async';

import 'package:booking/core/widgets/secondary_app_bar_widget.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/units_model.dart';
import '../riverpod/unit_riverpod.dart';
import '../widgets/list_of_units_widget.dart';
import '../widgets/unit_card_widget.dart';

class UnitsPage extends ConsumerStatefulWidget {
  final int propertyId;
  final String nameProp;
  final String location;
  final String image;

  const UnitsPage({
    super.key,
    required this.propertyId,
    required this.location,
    required this.nameProp,
    required this.image,
  });

  @override
  ConsumerState<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends ConsumerState<UnitsPage>
    with TickerProviderStateMixin {
  TabController? _tabController;
  bool _isTabControllerInitialized = false;

  final Map<int, ScrollController> _scrollControllers = {};
  final PageStorageBucket _pageStorageBucket = PageStorageBucket();

  @override
  void dispose() {
    _scrollControllers.forEach((key, controller) {
      controller.dispose();
    });
    _tabController?.dispose();
    super.dispose();
  }

  ScrollController _getScrollControllerForSection(int sectionId) {
    if (!_scrollControllers.containsKey(sectionId)) {
      _scrollControllers[sectionId] = ScrollController();
    }
    return _scrollControllers[sectionId]!;
  }

  @override
  Widget build(BuildContext context) {
    /// نستخدم قسم "الكل" (غالبًا id = 0) لجلب الأقسام
    final baseState =
    ref.watch(getAllUnitsProvider(Tuple2(widget.propertyId, 0)));

    final List<SectionsOfPropertyModel> sections = baseState.data.sections;

    if (sections.isEmpty ||
        (baseState.stateData == States.loading &&
            !_isTabControllerInitialized)) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        ),
      );
    }

    try {
      if (!_isTabControllerInitialized) {
        _tabController = TabController(
          length: sections.length,
          vsync: this,
        );
        _isTabControllerInitialized = true;
      }
    } catch (e) {
      if (kReleaseMode) {
        debugPrint("Error initializing TabController in UnitsPage: $e");
      }
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        ),
      );
    }

    if (_tabController == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const SecondaryAppBarWidget(title: ""),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            /// ========== Tabs للأقسام (سحب جانبي) ==========
            SizedBox(
              height: 46.h,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: AppColors.primaryColor,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: AppColors.fontColor,
                tabs: sections
                    .map(
                      (section) => Tab(
                    text: section.name,
                  ),
                )
                    .toList(),
              ),
            ),

            /// ========== TabBarView (تمرير جانبي بين الأقسام) ==========
            Expanded(
              child: PageStorage(
                bucket: _pageStorageBucket,
                child: TabBarView(
                  controller: _tabController,
                  children: sections.map((section) {
                    final scrollController =
                    _getScrollControllerForSection(section.id);

                    return UnitsSectionInUnitsPage(
                      scrollController: scrollController,
                      propertyId: widget.propertyId,
                      sectionId: section.id,
                      image: widget.image,
                      location: widget.location,
                      nameProp: widget.nameProp,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class UnitsSectionInUnitsPage extends ConsumerStatefulWidget {
  const UnitsSectionInUnitsPage({
    super.key,
    required this.propertyId,
    required this.sectionId,
    required this.scrollController,
    required this.image,
    required this.location,
    required this.nameProp,
  });

  final int propertyId;
  final int sectionId;
  final ScrollController scrollController;
  final String nameProp;
  final String location;
  final String image;

  @override
  ConsumerState<UnitsSectionInUnitsPage> createState() =>
      _UnitsSectionInUnitsPageState();
}

class _UnitsSectionInUnitsPageState
    extends ConsumerState<UnitsSectionInUnitsPage>
    with AutomaticKeepAliveClientMixin<UnitsSectionInUnitsPage> {
  Timer? _debounceTimer;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;

    if (widget.scrollController.position.pixels >=
        widget.scrollController.position.maxScrollExtent) {
      if (!isLoadingMore) {
        setState(() {
          isLoadingMore = true;
        });

        _debounceTimer?.cancel();
        _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
          try {
            await ref
                .read(
              getAllUnitsProvider(
                Tuple2(widget.propertyId, widget.sectionId),
              ).notifier,
            )
                .getData(moreData: true);
          } finally {
            if (mounted) {
              setState(() {
                isLoadingMore = false;
              });
            }
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final state = ref.watch(
      getAllUnitsProvider(
        Tuple2(widget.propertyId, widget.sectionId),
      ),
    );

    final units = state.data.units.data;

    return RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(
          getAllUnitsProvider(
            Tuple2(widget.propertyId, widget.sectionId),
          ).notifier,
        )
            .getData(isRefresh: true);
      },
      child: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfData: ListView.builder(
          controller: widget.scrollController,
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
              image: widget.image,
              location: widget.location,
              nameProp: widget.nameProp,
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
// class UnitsPage extends ConsumerStatefulWidget {
//   final int propertyId;
//   final String nameProp;
//   final String location;
//   final String image;
//
//   const UnitsPage(
//       {super.key,
//       required this.propertyId,
//       required this.location,
//       required this.nameProp,
//       required this.image});
//
//   @override
//   ConsumerState<UnitsPage> createState() => _UnitsPageState();
// }
//
// class _UnitsPageState extends ConsumerState<UnitsPage> {
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//   }
//
//   void _onScroll() {
//     // ============ Pagination ============
//     if (_scrollController.position.pixels >=
//         _scrollController.position.maxScrollExtent - 100) {
//       final state = ref.read(getAllUnitsProvider(1));
//       if (state.stateData != States.loadingMore) {
//         ref
//             .read(getAllUnitsProvider(widget.propertyId).notifier)
//             .getData(moreData: true);
//       }
//     }
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const SecondaryAppBarWidget(title: ""),
//       body: SafeArea(
//         top: false,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding:
//                   EdgeInsets.symmetric(horizontal: 14.w).copyWith(top: 6.h),
//               child: AutoSizeTextWidget(
//                 text: "${S.of(context).roomsFor} ${widget.nameProp}",
//                 fontSize: 13.6.sp,
//                 fontWeight: FontWeight.w500,
//                 maxLines: 2,
//                 minFontSize: 12,
//               ),
//             ),
//             8.h.verticalSpace,
//             ListOfUnitsWidget(
//               scrollController: _scrollController,
//               propertyId: widget.propertyId,
//               image: widget.image,
//               location: widget.location,
//               nameProp: widget.nameProp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
