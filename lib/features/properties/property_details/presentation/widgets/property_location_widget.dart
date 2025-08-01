import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/models/address_model.dart';
import 'general_container_for_details_widget.dart';

class PropertyLocationWidget extends StatefulWidget {
  final AddressModel address;

  const PropertyLocationWidget({super.key, required this.address});

  @override
  State<PropertyLocationWidget> createState() => _PropertyLocationWidgetState();
}

class _PropertyLocationWidgetState extends State<PropertyLocationWidget> {
  late final LatLng _propertyPosition;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // _propertyPosition = LatLng(widget.address.lat, widget.address.lng);
    _propertyPosition = LatLng(15.369445, 44.191006);
    _markers.add(
      Marker(
        markerId: const MarkerId('property'),
        position: _propertyPosition,
        visible: false,
      ),
    );
  }

  Future<void> _openMapApp() async {
    // final lat = widget.address.lat;
    // final lng = widget.address.lng;
    final lat = 15.369445;
    final lng = 44.191006;
    // رابط Google Maps عام يعمل على Android و iOS
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذّر فتح تطبيق الخرائط')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return GeneralContainerForDetailsWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AutoSizeTextWidget(
                  text: "العنوان",
                  fontSize: 13.sp,
                ),
              ),
              InkWell(
                onTap: _openMapApp,
                child: AutoSizeTextWidget(
                  text: "العرض في الخريطة",
                  colorText: AppColors.primaryColor,
                  fontSize: 10.4.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          10.h.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.mapActive,
                color: AppColors.greyColor.withOpacity(.8),
                height: 15.h,
              ),
              3.w.horizontalSpace,
              Flexible(
                child: AutoSizeTextWidget(
                  text:
                      "${widget.address.city}, ${widget.address.district}, ${widget.address.address}",
                  fontSize: 10.5.sp,
                  colorText: AppColors.greyColor,
                ),
              ),
            ],
          ),
          10.h.verticalSpace,
          IgnorePointer(
            ignoring: true,
            child: SizedBox(
              height: 160.h,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: _propertyPosition,
                        zoom: 14,
                      ),
                      markers: _markers,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AppIcons.mapLocation,
                        color: AppColors.primaryColor,
                        height: 38.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
