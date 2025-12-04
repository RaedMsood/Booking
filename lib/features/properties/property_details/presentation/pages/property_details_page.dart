import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../units/presentation/widgets/units_in_property_details_tab_widget.dart';
import '../../../units/presentation/widgets/sections_tabs_widget.dart';
import '../riverpod/property_details_riverpod.dart';
import '../widgets/list_of_all_scores_custemor_widget.dart';
import '../widgets/property_location_widget.dart';
import '../widgets/shimmer_property_details_widget.dart';
import '../widgets/sliver_app_bar_details_widget.dart';
import '../widgets/deposit_widget.dart';
import '../widgets/name_and_description_and_rating_widget.dart';
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
  late TabController _tabController;
  double _tabAnimationValue = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      length: 3,
      child: Scaffold(
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
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBarDetailsWidget(
                    images: state.data.images,
                    idProperties: state.data.id,
                    title: state.data.name,
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DepositWidget(deposit: state.data.deposit),
                        TermsPolicyWidget(policy: state.data.policies),
                        PropertyLocationWidget(address: state.data.address),
                        12.h.verticalSpace,
                      ],
                    ),
                  ),
                  UnitsInPropertyDetailsTab(
                    propertyId: state.data.id,
                    nameProp: state.data.name,
                    location:
                        '${state.data.address.city} ,${state.data.address.district}',
                    image:
                        state.data.images.isEmpty ? '' : state.data.images[0],
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
  }
}
