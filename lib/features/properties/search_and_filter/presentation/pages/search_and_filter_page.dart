import 'dart:async';

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
import '../widgets/unit_search_list_widget.dart';

class SearchAndFilterPage extends ConsumerStatefulWidget {
  const SearchAndFilterPage({super.key});

  @override
  ConsumerState<SearchAndFilterPage> createState() =>
      _SearchAndFilterPageState();
}

class _SearchAndFilterPageState extends ConsumerState<SearchAndFilterPage> {
  final ScrollController _scrollController = ScrollController();
  late final TextEditingController _searchController;
  Timer? _searchDebounce;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController(
      text: ref.read(searchQueryProvider),
    );

    final initialQuery = _searchController.text;
    ref
        .read(searchAndFilterPropertiesProvider.notifier)
        .setSearchQuery(initialQuery);
    ref.read(searchAndFilterUnitsProvider.notifier).setSearchQuery(initialQuery);

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // ============ Pagination ============
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final mode = ref.read(appliedSearchResultModeProvider);

      if (mode == SearchFilterResultMode.property) {
        final state = ref.read(searchAndFilterPropertiesProvider);
        if (state.stateData != States.loadingMore &&
            state.stateData != States.loading) {
          ref
              .read(searchAndFilterPropertiesProvider.notifier)
              .getData(moreData: true);
        }
        return;
      }

      final state = ref.read(searchAndFilterUnitsProvider);
      if (state.stateData != States.loadingMore &&
          state.stateData != States.loading) {
        ref.read(searchAndFilterUnitsProvider.notifier).getData(moreData: true);
      }
    }
  }

  Widget _buildPropertyResults() {
    final state = ref.watch(searchAndFilterPropertiesProvider);

    return CheckStateInGetApiDataWidget(
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
              child: EmptyWidget(title: S.of(context).noSearchResults),
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
    );
  }

  Widget _buildUnitResults() {
    final state = ref.watch(searchAndFilterUnitsProvider);

    return CheckStateInGetApiDataWidget(
      state: state,
      refresh: () {
        ref.invalidate(searchAndFilterUnitsProvider);
      },
      widgetOfLoading: const Center(
        child: CircularProgressIndicatorWidget(),
      ),
      widgetOfData: CustomScrollView(
        controller: _scrollController,
        slivers: [
          if (state.data.data.isEmpty)
            SliverToBoxAdapter(
              child: EmptyWidget(title: S.of(context).noSearchResults),
            ),
          UnitSearchSliverListWidget(
            units: state.data.data,
          ),
          if (state.stateData == States.loadingMore)
            const SliverToBoxAdapter(
              child: CircularProgressIndicatorWidget(),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    ref.invalidate(searchAndFilterPropertiesProvider);
    ref.invalidate(searchAndFilterUnitsProvider);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(appliedSearchResultModeProvider);
    final isPropertyMode = mode == SearchFilterResultMode.property;
    final propertyNotifier = ref.read(searchAndFilterPropertiesProvider.notifier);
    final unitNotifier = ref.read(searchAndFilterUnitsProvider.notifier);

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
                  SearchAndFilterWidget(
                    controller: _searchController,
                    hintText: S.of(context).searchHotelPlaceholder,
                    onChanged: (value) {
                      _searchDebounce?.cancel();
                      ref.read(searchQueryProvider.notifier).state = value;
                      propertyNotifier.setSearchQuery(value);
                      unitNotifier.setSearchQuery(value);

                      _searchDebounce = Timer(
                        const Duration(milliseconds: 300),
                        () {
                          if (!mounted) return;

                          if (isPropertyMode) {
                            propertyNotifier.search();
                          } else {
                            unitNotifier.search();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: isPropertyMode
                  ? _buildPropertyResults()
                  : _buildUnitResults(),
            ),
          ],
        ),
      ),
    );
  }
}
