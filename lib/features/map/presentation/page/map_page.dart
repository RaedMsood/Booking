import 'dart:ui' as ui;
import 'package:booking/core/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
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

  late GoogleMapController mapCtrl;

  BitmapDescriptor _markerIcon = BitmapDescriptor.defaultMarker;

  final List<_MarkerData> _markerData = const [
    _MarkerData(id: 'sanaacenter', position: LatLng(15.3694, 44.1910)),
    _MarkerData(id: 'oldcity', position: LatLng(15.3608, 44.1910)),
    _MarkerData(id: 'main_district', position: LatLng(15.3389, 44.2100)),
    _MarkerData(id: 'northeast', position: LatLng(15.3800, 44.2250)),
    _MarkerData(id: 'westside', position: LatLng(15.3570, 44.1600)),
  ];

  bool _showCard = false;

  /// يحدد إن كانت الحركة بدأت من المستخدم (سحب/لمس) وليس برمجياً
  bool _userGestureInProgress = false;

  @override
  void initState() {
    super.initState();
    _loadMarkerIcon();
  }

  Future<void> _loadMarkerIcon() async {
    final BitmapDescriptor icon = await _bitmapDescriptorFromAsset(
      'assets/images/loc.png',
      width: 70.w.toInt(),
    );
    if (mounted) {
      setState(() {
        _markerIcon = icon;
      });
    }
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromAsset(
      String assetPath, {
        required int width,
      }) async {
    final ByteData data = await rootBundle.load(assetPath);
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    final ui.FrameInfo fi = await codec.getNextFrame();
    final Uint8List bytes = (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!
        .buffer
        .asUint8List();
    return BitmapDescriptor.fromBytes(bytes);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final positionState = ref.watch(positionProvider);
    final propertyFromPositionState = ref.watch(propertyFromPositionProvider);

    return Scaffold(
      appBar: AppBar(
        title: AutoSizeTextWidget(text: S.of(context).mapTitle),
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
                      target: _markerData.first.position,
                      zoom: 11,
                    ),
                    onMapCreated: (ctrl) => mapCtrl = ctrl,

                    // إخفاء الكارد فقط إذا بدأ التحريك نتيجة إيماءة مستخدم
                    onCameraMoveStarted: () {
                      if (_userGestureInProgress && _showCard) {
                        setState(() => _showCard = false);
                      }
                    },

                    // إخفاء الكارد عند الضغط في الخريطة (مكان فارغ)
                    onTap: (_) {
                      if (_showCard) {
                        setState(() => _showCard = false);
                      }
                    },

                    markers: positionState.data.map((m) {
                      return Marker(
                        markerId: MarkerId(m.id.toString()),
                        position: LatLng(
                          double.tryParse(m.lat) ?? 0,
                          double.tryParse(m.lng) ?? 0,
                        ),
                        icon: _markerIcon,
                        onTap: () {
                          // تأكد أن الإيماءة لا تُخفي الكارد مباشرة بعد تحريك برمجي
                          _userGestureInProgress = false;
                          ref
                              .read(propertyFromPositionProvider.notifier)
                              .getPropertiesFromPosition(idProperty: m.id);
                          setState(() => _showCard = true);
                        },
                      );
                    }).toSet(),

                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                  ),
                ),

                /// طبقة شفافة تلتقط اللمس بدون تعطيل الخريطة:
                /// نضبط الفلاغ عند بداية/نهاية اللمس
                Listener(
                  behavior: HitTestBehavior.translucent,
                  onPointerDown: (_) => _userGestureInProgress = true,
                  onPointerUp: (_) => _userGestureInProgress = false,
                  onPointerCancel: (_) => _userGestureInProgress = false,
                  child: const SizedBox.expand(),
                ),

                /// الكارد في الأسفل: يظهر عند اختيار ماركر ويختفي بالحركة أو بالنقر على الخريطة
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

class _MarkerData {
  final String id;
  final LatLng position;
  const _MarkerData({required this.id, required this.position});
}
