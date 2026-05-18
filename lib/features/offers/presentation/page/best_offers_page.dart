import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../properties/property_details/presentation/pages/property_details_page.dart';
import '../../../properties/units/presentation/pages/unit_details_page.dart';
import '../riverpod/offers_riverpod.dart';
import '../widget/card_of_best_offers_widget.dart';

class BestOffersPage extends ConsumerStatefulWidget {
  const BestOffersPage({super.key});

  @override
  ConsumerState<BestOffersPage> createState() => _BestOffersPageState();
}

class _BestOffersPageState extends ConsumerState<BestOffersPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await ref.read(getBestOffersProvider.notifier).refresh();
  }

  Future<void> _loadMoreIfNeeded() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    try {
      await ref.read(getBestOffersProvider.notifier).getBestOffers(moreData: true);
    } finally {
      _isLoadingMore = false;
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final reachedBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 24;

    if (reachedBottom) {
      _loadMoreIfNeeded();
    }
  }

  String _formatPrice(num value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getBestOffersProvider);
    final offers = state.data.data;

    return Scaffold(
      appBar: SecondaryAppBarWidget(title: 'افضل العروض'),
      body: CheckStateInGetApiDataWidget(
        state: state,
        refresh: () => ref.read(getBestOffersProvider.notifier).getBestOffers(),
        widgetOfData: RefreshIndicator(
          onRefresh: _onRefresh,
          color: AppColors.primaryColor,
          child: offers.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 14.h),
                  children: [
                    SizedBox(height: 120.h),
                    Center(
                      child: Text(
                        'لا توجد عروض حالياً',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Center(
                      child: Text(
                        'اسحب للأسفل للتحديث',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(bottom: 14.h),
                  itemCount: offers.length,
                  itemBuilder: (context, index) {
                    final offer = offers[index];

                    void openDetails() {
                      navigateTo(
                        context,
                        // PropertyDetailsPage(
                        //   propertyId: offer.propertyId,
                        //   images: offer.image.isNotEmpty ? [offer.image] : [],
                       // ),
                        UnitDetailsPage(unitId: offer.id),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0.w,
                        vertical: 8.0.h,
                      ),
                      child: CardOfBestOffersWidget(
                        isAllBestOffers: true,
                        height: 140.h,
                        imageUrl: offer.image,
                        title: offer.propertyName.isNotEmpty
                            ? offer.propertyName
                            : offer.name,
                        subTitle: offer.unitType,
                        offerText:
                             offer.offerDescription,
                        currentPrice: _formatPrice(offer.effectivePrice),
                        originalPrice: offer.originalPriceBeforeDiscount == null
                            ? null
                            : _formatPrice(offer.originalPriceBeforeDiscount!),
                        onTap: openDetails,
                        onBookNowTap: openDetails,
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
