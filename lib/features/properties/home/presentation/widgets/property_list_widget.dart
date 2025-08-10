import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/property_data_model.dart';
import '../riverpod/home_riverpod.dart';
import 'property_card_widget.dart';
import 'shimmer_property_card_widget.dart';

class PropertySliverListWidget extends ConsumerWidget {
  final List<PropertyDataModel> properties;
  final bool propertiesByCity;
  final bool isLoading;

  const PropertySliverListWidget({
    super.key,
    required this.properties,
    this.propertiesByCity = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    var provider = ref.read(getAllPropertyProvider.notifier);

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 14.w)
          .copyWith(bottom: 14.h, top: 6.h),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {

            return isLoading
                ? const ShimmerPropertyCardWidget()
                : PropertyCardWidget(
                    property: properties[index],
                    propertiesByCity: propertiesByCity,
                  );
          },
          childCount: isLoading
              ? 4
              : properties.length ,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: provider.viewType,
          mainAxisSpacing: 18.r,
          crossAxisSpacing: 21.w,
          childAspectRatio: provider.viewType == 2 ? 0.57.h : 1.28.h,
        ),
      ),
    );
  }
}
