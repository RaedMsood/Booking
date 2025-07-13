import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../riverpod/home_riverpod.dart';
import '../widgets/app_bar_home_widget.dart';
import '../widgets/offers_widget.dart';
import '../widgets/property_list_widget.dart';
import '../widgets/search_and_filter_design_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  static final ValueNotifier<bool> showSearchIconStatic = ValueNotifier(false);

  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  ScrollController _scrollController = ScrollController();
  final GlobalKey _searchKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    final initialOffset = ref.read(scrollOffsetProvider);
    _scrollController = ScrollController(initialScrollOffset: initialOffset);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    ref.read(scrollOffsetProvider.notifier).state = _scrollController.offset;

    // ============ Control the appearance and disappearance of the search icon ============
    final context = _searchKey.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox?;
      if (box != null && box.attached) {
        final position = box.localToGlobal(Offset.zero).dy;
        final height = box.size.height;
        final bottom = position + height;

        final double screenTopVisibleArea =
            MediaQuery.of(context).padding.top + kToolbarHeight;

        final double margin = 22.h;
        final bool shouldShow = bottom <= screenTopVisibleArea + margin;

        if (HomePage.showSearchIconStatic.value != shouldShow) {
          HomePage.showSearchIconStatic.value = shouldShow;
        }
      }
    }

    // ============ Pagination ============
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      ref.read(getPropertyProvider.notifier).getData(moreData: true);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getPropertyProvider);

    return Scaffold(
      appBar: AppBarHomeWidget(),
      body: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfData: RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: Colors.white,
          displacement: 40,
          strokeWidth: 2.5,
          onRefresh: () async {
            await ref.read(getPropertyProvider.notifier).getData();
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SearchAndFilterDesignWidget(key: _searchKey),
                    14.h.verticalSpace,
                    const OffersWidget(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                            height: 7.h,
                            width: 120.w,
                            margin: EdgeInsets.only(top: 10.h, right: 4.w),
                            decoration: BoxDecoration(
                              color: AppColors.primarySwatch.shade100,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          AutoSizeTextWidget(
                            text: " وجهتك الفندقية",
                            fontSize: 13.sp,
                            colorText: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              PropertySliverListWidget(
                properties: state.data.data,
                state: state.stateData,
                hasMore: state.data.currentPage < state.data.lastPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
