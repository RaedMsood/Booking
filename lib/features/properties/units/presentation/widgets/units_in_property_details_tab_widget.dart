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
import '../../../../../core/widgets/loading_widget.dart';
import '../riverpod/unit_riverpod.dart';
import 'unit_card_widget.dart';

class UnitsInPropertyDetailsTab extends ConsumerStatefulWidget {
  const UnitsInPropertyDetailsTab({super.key, required this.propertyId});

  final int propertyId;

  @override
  ConsumerState<UnitsInPropertyDetailsTab> createState() =>
      _UnitsInPropertyDetailsTabState();
}

class _UnitsInPropertyDetailsTabState
    extends ConsumerState<UnitsInPropertyDetailsTab>
    with AutomaticKeepAliveClientMixin<UnitsInPropertyDetailsTab> {
  @override
  void dispose() {
    super.dispose();
  }

  bool _isRequestingMore = false;

  void _handleScroll(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return;

    final maxScroll = notification.metrics.maxScrollExtent;
    final current = notification.metrics.pixels;

    // لو ما عندنا محتوى كفاية أصلاً للسكرول
    if (maxScroll == 0) return;

    if (maxScroll - current > 10.h) {
      return;
    }

    if (_isRequestingMore) return;

    final selectedSectionId =
        ref.read(selectedUnitsSectionIdProvider(widget.propertyId)) ?? 0;

    final currentState = ref.read(
      getAllUnitsProvider(
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
            getAllUnitsProvider(
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
        ref.watch(selectedUnitsSectionIdProvider(widget.propertyId)) ?? 0;

    final state = ref.watch(
      getAllUnitsProvider(
        Tuple2(widget.propertyId, selectedSectionId),
      ),
    );

    final units = state.data.units.data;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _handleScroll(notification);
        return false;
      },
      child: CheckStateInGetApiDataWidget(
        state: state,
        refresh: () async {
          _isRequestingMore = false;
          await ref
              .read(
                getAllUnitsProvider(
                  Tuple2(widget.propertyId, selectedSectionId),
                ).notifier,
              )
              .getData(isRefresh: true);
        },
        widgetOfLoading: ListView.builder(
          padding:
              EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 12.h),
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
                    color: AppColors.whiteColor.withValues(alpha: 0.7),
                  ),
                ],
              ),
            );
          },
        ),
        widgetOfData: ListView.builder(
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
