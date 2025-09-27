import 'package:booking/core/state/check_state_in_get_api_data_widget.dart';
import 'package:booking/core/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/property_list_widget.dart';
import '../riverpod/search_and_filter_riverpod.dart';
import '../widgets/search_and_filter_widget.dart';

class SearchAndFilterPage extends ConsumerStatefulWidget {
  const SearchAndFilterPage({super.key});

  @override
  ConsumerState<SearchAndFilterPage> createState() =>
      _SearchAndFilterPageState();
}

class _SearchAndFilterPageState extends ConsumerState<SearchAndFilterPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // ============ Pagination ============
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final state = ref.read(searchAndFilterPropertiesProvider);
      if (state.stateData != States.loadingMore) {
        ref
            .read(searchAndFilterPropertiesProvider.notifier)
            .getData(moreData: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(searchAndFilterPropertiesProvider);
    var provider = ref.read(searchAndFilterPropertiesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 72.w,
        toolbarHeight: 58.h,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h).copyWith(top: 4.4.h),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const IconButtonWidget(),
          ),
        ),
      ),
      // body: CustomScrollView(
      //   controller: _scrollController,
      //   slivers: [
      //     SliverPersistentHeader(
      //       pinned: true,
      //       delegate: _SearchHeaderDelegate(
      //         child: Padding(
      //           padding: EdgeInsets.all(14.sp),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               AutoSizeTextWidget(
      //                 text: "أبحث عن المكان المناسب لك",
      //                 textAlign: TextAlign.start,
      //                 fontSize: 14.6.sp,
      //               ),
      //               8.h.verticalSpace,
      //               AutoSizeTextWidget(
      //                 text: "بامكانك البحث بأسم منشأة وفلترة النتائج الخاصة بك",
      //                 colorText: AppColors.fontColor2,
      //                 fontSize: 10.4.sp,
      //                 textAlign: TextAlign.start,
      //               ),
      //               16.h.verticalSpace,
      //               SearchAndFilterDesignWidget(),
      //               12.h.verticalSpace,
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //
      //     SliverToBoxAdapter(
      //       child: CheckStateInGetApiDataWidget(
      //         state: state,
      //         widgetOfData: PropertySliverListWidget(
      //           properties: state.data.data,
      //           state: state.stateData,
      //           hasMore: state.data.currentPage <
      //               state.data.lastPage,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(14.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: S.of(context).findTheRightPlaceForYou,
                  textAlign: TextAlign.start,
                  fontSize: 14.6.sp,
                ),
                8.h.verticalSpace,
                AutoSizeTextWidget(
                  text: S.of(context).searchSubtitle,
                  colorText: AppColors.fontColor2,
                  fontSize: 10.4.sp,
                  textAlign: TextAlign.start,
                ),
                16.h.verticalSpace,
                SearchAndFilterWidget(controller: provider),
              ],
            ),
          ),
          Expanded(
            child: CheckStateInGetApiDataWidget(
              state: state,
              refresh: () {
                ref.refresh(searchAndFilterPropertiesProvider);
              },
              widgetOfLoading: CustomScrollView(
                controller: _scrollController,
                slivers: const [
                  PropertySliverListWidget(
                    properties: [],
                    isLoading: true,
                  ),
                ],
              ),
              widgetOfData: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  if (state.data.data.isEmpty)
                    const SliverToBoxAdapter(
                      child: EmptyWidget(title: "لايوجد نتائج للبحث"),
                    ),
                  PropertySliverListWidget(
                    properties: state.data.data,
                  ),
                  if (state.stateData == States.loadingMore)
                    const SliverToBoxAdapter(
                      child: CircularProgressIndicatorWidget(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SearchHeaderDelegate({required this.child});

  @override
  double get minExtent => 180.h;

  @override
  double get maxExtent => 180.h;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white, // تأكد من وجود خلفية لتثبيتها فوق المحتوى
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _SearchHeaderDelegate oldDelegate) => false;
}
