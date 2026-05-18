import 'package:booking/core/constants/app_icons.dart';
import 'package:booking/core/widgets/shimmer_widget.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../units/presentation/riverpod/unit_riverpod.dart';
import '../../../units/presentation/widgets/unit_card_widget.dart';

class PropertyOfferTabWidget extends ConsumerStatefulWidget {
  const PropertyOfferTabWidget({
    super.key,
    required this.propertyId,
  });

  final int propertyId;

  @override
  ConsumerState<PropertyOfferTabWidget> createState() =>
      _PropertyOfferTabWidgetState();
}

class _PropertyOfferTabWidgetState extends ConsumerState<PropertyOfferTabWidget>
    with AutomaticKeepAliveClientMixin<PropertyOfferTabWidget> {
  bool _isRequestingMore = false;

  void _handleScroll(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return;

    final maxScroll = notification.metrics.maxScrollExtent;
    final current = notification.metrics.pixels;

    if (maxScroll == 0) return;
    if (maxScroll - current > 10.h) return;
    if (_isRequestingMore) return;

    final selectedSectionId =
        ref.read(selectedOfferUnitsSectionIdProvider(widget.propertyId)) ?? 0;

    final currentState = ref.read(
      getAllOfferUnitsProvider(
        Tuple2(widget.propertyId, selectedSectionId),
      ),
    );

    if (currentState.stateData == States.loading ||
        currentState.stateData == States.loadingMore) {
      return;
    }

    _isRequestingMore = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;

      await ref
          .read(
            getAllOfferUnitsProvider(
              Tuple2(widget.propertyId, selectedSectionId),
            ).notifier,
          )
          .getData(moreData: true);

      _isRequestingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final selectedSectionId =
        ref.watch(selectedOfferUnitsSectionIdProvider(widget.propertyId)) ?? 0;

    final state = ref.watch(
      getAllOfferUnitsProvider(
        Tuple2(widget.propertyId, selectedSectionId),
      ),
    );
    final units = state.data.units.data;

    Future<void> onRefresh() async {
      _isRequestingMore = false;
      await ref
          .read(
            getAllOfferUnitsProvider(
              Tuple2(widget.propertyId, selectedSectionId),
            ).notifier,
          )
          .getData(isRefresh: true);
    }

    Widget emptyWidget() {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(14.w, 18.h, 14.w, 18.h),
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 28.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.local_offer_outlined,
                  color: AppColors.greyColor,
                  size: 28.sp,
                ),
                10.h.verticalSpace,
                AutoSizeTextWidget(
                  text: 'لا توجد وحدات عليها عروض حالياً',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  colorText: AppColors.mainColorFont,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _handleScroll(notification);
        return false;
      },
      child: CheckStateInGetApiDataWidget(
        state: state,
        refresh: onRefresh,
        widgetOfLoading: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 12.h),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h, top: 4.h),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ShimmerPlaceholderWidget(
                      height: 160.h,
                      borderRadius: 14.r,
                    ),
                    SvgPicture.asset(
                      AppIcons.logo,
                      height: 100.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.whiteColor.withValues(alpha: 0.7),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        widgetOfData: RefreshIndicator(
          onRefresh: onRefresh,
          child: units.isEmpty
              ? emptyWidget()
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 12.h),
                  itemCount:
                      units.length + ((state.stateData == States.loadingMore) ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == units.length) {
                      if (state.stateData == States.loadingMore) {
                        return const CircularProgressIndicatorWidget();
                      }
                      return const SizedBox.shrink();
                    }

                    return UnitCardWidget(units: units[index]);
                  },
                ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

