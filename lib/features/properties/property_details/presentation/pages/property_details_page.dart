import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../riverpod/property_details_riverpod.dart';
import '../widgets/property_location_widget.dart';
import '../widgets/shimmer_property_details_widget.dart';
import '../widgets/sliver_app_bar_details_widget.dart';
import '../widgets/deposit_widget.dart';
import '../widgets/name_and_description_and_rating_widget.dart';
import '../widgets/property_details_tab_bar_widget.dart';
import '../../../units/presentation/widgets/show_units_in_hotel_details_widget.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      length: 2,
      child: Scaffold(
        body: CheckStateInGetApiDataWidget(
          state: state,
          widgetOfLoading: ShimmerPropertyDetailsWidget(images: widget.images),
          widgetOfData: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBarDetailsWidget(
                  images: state.data.images,
                ),
                SliverToBoxAdapter(
                  child: NameAndDescriptionAndRatingWidget(
                    name: state.data.name,
                    description: state.data.description,
                    features: state.data.features,
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: PropertyDetailsTabBarWidget(
                    _tabController,
                    context,
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PropertyLocationWidget(address: state.data.address),
                      DepositWidget(deposit: state.data.deposit),
                      TermsPolicyWidget(policy: state.data.policies),
                      ShowUnitsInHotelDetailsWidget(
                        units: state.data.units,
                        propertyId: state.data.id,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
