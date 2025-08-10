import 'dart:ui' as ui;
import 'package:booking/core/state/state.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
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

  final List<_MarkerData> _markerData = [
    _MarkerData(id: 'sanaacenter', position: LatLng(15.3694, 44.1910)),
    _MarkerData(id: 'oldcity', position: LatLng(15.3608, 44.1910)),
    _MarkerData(id: 'main_district', position: LatLng(15.3389, 44.2100)),
    _MarkerData(id: 'northeast', position: LatLng(15.3800, 44.2250)),
    _MarkerData(id: 'westside', position: LatLng(15.3570, 44.1600)),
  ];

  bool _showCard = false;

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
    setState(() {
      _markerIcon = icon;
    });
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromAsset(
    String assetPath, {
    required int width,
  }) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    Uint8List bytes = (await fi.image.toByteData(
      format: ui.ImageByteFormat.png,
    ))!
        .buffer
        .asUint8List();
    return BitmapDescriptor.fromBytes(bytes);
  }

  @override
  Widget build(BuildContext context) {
    final positionState = ref.watch(positionProvider);
    final propertyFromPositionState = ref.watch(propertyFromPositionProvider);

    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeTextWidget(text: 'الخريطة'),
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
                  text: 'أطلع على المنشآت في الخريطة',
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                ),
                6.verticalSpace,
                AutoSizeTextWidget(
                  text:
                      'استخدم أداة البحث عن خريطة لتحديد المواقع بسهولة وسرعة.',
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
                    markers: positionState.data.map((m) {
                      return Marker(
                        markerId: MarkerId(m.id.toString()),
                        position: LatLng(double.tryParse(m.lat) ?? 0,
                            double.tryParse(m.lng) ?? 0),
                        icon: _markerIcon,
                        onTap: () {
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
                if (_showCard)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.w,
                          right: 16.w,
                          bottom: kBottomNavigationBarHeight.h,
                        ),
                        child: Visibility(
                          visible: propertyFromPositionState.stateData !=
                              States.loading,
                          replacement: const ShimmerCardInMapWidget(),
                          child: PropertyFavoriteAndMapWidget(
                            property: propertyFromPositionState.data,
                            imageHeight: 90,
                            spaceHeight: 10,
                          ),
                        )),
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

  _MarkerData({required this.id, required this.position});
}
