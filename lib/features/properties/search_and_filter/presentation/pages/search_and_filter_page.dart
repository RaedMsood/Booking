import 'package:booking/core/state/check_state_in_get_api_data_widget.dart';
import 'package:booking/core/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
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
      appBar: const SecondaryAppBarWidget(title: ''),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 8.h),
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
                  14.h.verticalSpace,
                  SearchAndFilterWidget(controller: provider),
                ],
              ),
            ),
            Expanded(
              child: CheckStateInGetApiDataWidget(
                state: state,
                refresh: () {
                  ref.invalidate(searchAndFilterPropertiesProvider);
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
                      SliverToBoxAdapter(
                        child:
                            EmptyWidget(title: S.of(context).noSearchResults),
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
      ),
    );
  }
}
