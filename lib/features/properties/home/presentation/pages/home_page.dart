import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../riverpod/home_riverpod.dart';
import '../widgets/shimmer_home_widget.dart';
import '../widgets/sliver_app_bar_home_widget.dart';
import '../../../cities/presentation/widget/discover_destinations_widget.dart';
import '../widgets/offers_widget.dart';
import '../widgets/property_list_widget.dart';
import '../widgets/property_view_type_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final initialOffset = ref.read(scrollOffsetProvider);
    _scrollController = ScrollController(initialScrollOffset: initialOffset);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    ref.read(scrollOffsetProvider.notifier).state = _scrollController.offset;
    // ============ Pagination ============
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final state = ref.read(getAllPropertyProvider);
      if (state.stateData != States.loadingMore) {
        ref.read(getAllPropertyProvider.notifier).getData(moreData: true);
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
    var state = ref.watch(getAllPropertyProvider);

    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        backgroundColor: Colors.white,
        displacement: 40,
        strokeWidth: 2.5,
        onRefresh: () async {
          ref.invalidate(getAllPropertyProvider);
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: SliverAppBarHomeWidget(),
            ),
            SliverToBoxAdapter(
              child: CheckStateInGetApiDataWidget(
                state: state,
                refresh: (){
                  ref.invalidate(getAllPropertyProvider);
                },
                widgetOfLoading: const ShimmerHomeWidget(),
                widgetOfData: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    4.5.h.verticalSpace,
                    const OffersWidget(),
                    4.5.h.verticalSpace,
                    DiscoverDestinationsWidget(
                      cities: state.data.cities,
                    ),
                    6.h.verticalSpace,
                    const PropertyViewTypeWidget(),
                  ],
                ),
              ),
            ),
            if (state.stateData == States.error)
              const SliverToBoxAdapter(child: SizedBox.shrink())
            else
              PropertySliverListWidget(
                properties: state.data.property.data,
                isLoading: state.stateData == States.loading,
              ),
            if (state.stateData == States.loadingMore)
              const SliverToBoxAdapter(child: CircularProgressIndicatorWidget()),
          ],
        ),
      ),
    );
  }
}
