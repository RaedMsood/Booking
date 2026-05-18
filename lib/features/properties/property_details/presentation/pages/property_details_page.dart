import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/property_offer_banner_widget.dart';
import '../../../units/presentation/widgets/units_in_property_details_tab_widget.dart';
import '../../../units/presentation/widgets/sections_tabs_widget.dart';
import '../riverpod/property_details_riverpod.dart';
import '../widgets/list_of_all_scores_custemor_widget.dart';
import '../widgets/property_location_widget.dart';
import '../widgets/shimmer_property_details_widget.dart';
import '../widgets/sliver_app_bar_details_widget.dart';
import '../widgets/deposit_widget.dart';
import '../widgets/name_and_description_and_rating_widget.dart';
import '../widgets/property_offer_tab_widget.dart';
import '../widgets/property_details_tab_bar_widget.dart';
import '../widgets/terms_policy_widget.dart';

class PropertyDetailsPage extends ConsumerStatefulWidget {
  final List<String> images;

  final int propertyId;

  const PropertyDetailsPage({
    super.key,
    required this.propertyId,
    required this.images,
  });

  @override
  ConsumerState<PropertyDetailsPage> createState() =>
      _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends ConsumerState<PropertyDetailsPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _propertyDetailsTabBarKey = GlobalKey();
  late TabController _tabController;
  double _tabAnimationValue = 0;
  bool _isScrollingToUnitsTab = false;

  bool get _isUnitsTab => _tabController.index == 1;

  bool get _isOffersTab => _tabController.index == 2;

  bool get _hideBookingFab => _isUnitsTab || _isOffersTab;

  Future<void> _goToUnitsTab() async {
    if (_isUnitsTab || _isScrollingToUnitsTab) return;

    _isScrollingToUnitsTab = true;

    try {
      if (_scrollController.hasClients) {
        final tabBarContext = _propertyDetailsTabBarKey.currentContext;
        final renderObject = tabBarContext?.findRenderObject();

        if (renderObject is RenderBox) {
          final safeTop = MediaQuery.viewPaddingOf(context).top;
          final tabBarTop = renderObject.localToGlobal(Offset.zero).dy;
          final distanceToTop = tabBarTop - safeTop;

          if (distanceToTop > 1) {
            final targetOffset = (_scrollController.offset + distanceToTop)
                .clamp(0.0, _scrollController.position.maxScrollExtent);

            if ((targetOffset - _scrollController.offset).abs() > 1) {
              await _scrollController.animateTo(
                targetOffset,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
              );
            }
          }
        }
      }

      if (!mounted || _isUnitsTab) return;

      _tabController.animateTo(
        1,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    } finally {
      _isScrollingToUnitsTab = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabAnimationValue = _tabController.index.toDouble();

    //  هنا نسمع لتغيّر الأنيميشن (سحب جانبي أو ضغط
    _tabController.animation?.addListener(() {
      setState(() {
        _tabAnimationValue = _tabController.animation!.value;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getPropertyDetailsProvider(widget.propertyId));

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        floatingActionButton:
            state.stateData == States.loaded && !_hideBookingFab
                ? FloatingActionButton.extended(
                    onPressed: _goToUnitsTab,
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    extendedPadding: EdgeInsets.symmetric(horizontal: 20.w),
                    icon: const Icon(Icons.calendar_month_rounded),
                    label: Text(S.of(context).book),
                  )
                : null,
        body: SafeArea(
          top: false,
          child: CheckStateInGetApiDataWidget(
            state: state,
            refresh: () {
              ref.invalidate(getPropertyDetailsProvider(widget.propertyId));
            },
            widgetOfLoading:
                ShimmerPropertyDetailsWidget(images: widget.images),
            widgetOfData: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBarDetailsWidget(
                    images: state.data.images,
                    idProperties: state.data.id,
                    title: state.data.name,
                  ),
                  if (state.data.hasActivePaidOffer)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 0),
                        child: PropertyOfferBannerWidget(
                          text: state.data.offerDescription,
                          iconPath: 'assets/icons/pay.svg',
                          backgroundColor: const Color(0xffFEE2E2),
                          borderColor: const Color(0xffE1202E),
                          textColor: const Color(0xffE1202E),
                        ),
                      ),
                    ),

                  SliverToBoxAdapter(
                    child: NameAndDescriptionAndRatingWidget(
                      name: state.data.name,
                      description: state.data.description,
                      features: state.data.features,
                      rating:
                          double.parse(state.data.rating.toStringAsFixed(1)),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: PropertyDetailsTabBarWidget(
                      _tabController,
                      context,
                      _propertyDetailsTabBarKey,
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SectionsTabsPinnedHeaderDelegate(
                      tabAnimationValue: _tabAnimationValue,
                      propertyId: widget.propertyId,
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        DepositWidget(deposit: state.data.deposit),
                        if (state.data.policies.isNotEmpty)
                          TermsPolicyWidget(policy: state.data.policies),
                        PropertyLocationWidget(address: state.data.address),
                        12.h.verticalSpace,
                      ],
                    ),
                  ),
                  UnitsInPropertyDetailsTab(propertyId: state.data.id),
                  PropertyOfferTabWidget(
                    propertyId: state.data.id,
                  ),
                  ListOfAllScoresCustemorWidget(
                    rateOfScore: state.data.allScoreRateWithUser,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }}