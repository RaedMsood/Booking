import 'dart:async';
import 'dart:ui' as ui;
import 'package:booking/core/state/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../notifications/presentation/widget/notifications_button_widget.dart';
import '../../../profile/presentation/widget/property _fav_card.dart';
import '../riverpod/map_riverpod.dart';
import '../widgets/card_in_map_widget.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  GoogleMapController? _mapController;
  bool _showCard = false;

  bool _userGestureInProgress = false;

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    super.build(context);

    final positionState = ref.watch(positionProvider);
    final propertyFromPositionState = ref.watch(propertyFromPositionProvider);

    final markers = positionState.data
        .map(
          (m) => Marker(
            markerId: MarkerId(m.id.toString()),
            position: LatLng(
              double.tryParse(m.lat) ?? 0,
              double.tryParse(m.lng) ?? 0,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
            anchor: const Offset(0.5, 1.0),
            onTap: () {
              _userGestureInProgress = false;
              ref
                  .read(propertyFromPositionProvider.notifier)
                  .getPropertiesFromPosition(idProperty: m.id);
              setState(() => _showCard = true);
            },
          ),
        )
        .toSet();

    final initialTarget = markers.isNotEmpty
        ? markers.first.position
        : const LatLng(15.3694, 44.1910); // fallback

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeTextWidget(text: S.of(context).mapTitle),
        actions: const [NotificationsButtonWidget()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: S.of(context).mapHeadline,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
                6.verticalSpace,
                AutoSizeTextWidget(
                  text: S.of(context).mapSubhead,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                  colorText: const Color(0xff757575),
                ),
              ],
            ),
          ),
          18.verticalSpace,
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18.r),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: initialTarget,
                      zoom: 11,
                    ),
                    onMapCreated: (ctrl) => _mapController = ctrl,
                    onCameraMoveStarted: () {
                      if (_userGestureInProgress && _showCard) {
                        setState(() => _showCard = false);
                      }
                    },
                    onTap: (_) {
                      if (_showCard) {
                        setState(() => _showCard = false);
                      }
                    },

                    markers: markers,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  ),
                ),
                Listener(
                  behavior: HitTestBehavior.translucent,
                  onPointerDown: (_) => _userGestureInProgress = true,
                  onPointerUp: (_) => _userGestureInProgress = false,
                  onPointerCancel: (_) => _userGestureInProgress = false,
                  child: const SizedBox.expand(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      bottom: kBottomNavigationBarHeight.h,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      child: _showCard
                          ? Visibility(
                              key: const ValueKey('card'),
                              visible: propertyFromPositionState.stateData !=
                                  States.loading,
                              replacement: const ShimmerCardInMapWidget(),
                              child: PropertyFavoriteAndMapWidget(
                                property: propertyFromPositionState.data,
                                imageHeight: 90,
                                spaceHeight: 10,
                              ),
                            )
                          : const SizedBox.shrink(key: ValueKey('empty')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
