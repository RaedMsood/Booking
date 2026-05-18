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
    final isGridView = provider.viewType == HomePropertyViewType.grid;
    final listCardExtent = 212.h;
    final listCardExtentWithOffer = 252.h;
    final gridCardExtent = 178.h;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 14.w)
          .copyWith(bottom: 14.h, top: 6.h),
      sliver: isGridView
          ? SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return isLoading
                      ? ShimmerPropertyCardWidget(viewType: provider.viewType)
                      : PropertyCardWidget(
                             key: ValueKey('property-${properties[index].id}'),
                          property: properties[index],
                          viewType: provider.viewType,
                          propertiesByCity: propertiesByCity,
                        );
                },
                childCount: isLoading ? 4 : properties.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                mainAxisExtent: gridCardExtent,
              ),
            )
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final property = isLoading ? null : properties[index];

                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: SizedBox(
                      height: property?.hasOffer == true
                          ? listCardExtentWithOffer
                          : listCardExtent,
                      child: isLoading
                          ? ShimmerPropertyCardWidget(
                              viewType: provider.viewType,
                            )
                          : PropertyCardWidget(
                              key: ValueKey('property-${property!.id}'),
                              property: property,
                              viewType: provider.viewType,
                              propertiesByCity: propertiesByCity,
                            ),
                    ),
                  );
                },
                childCount: isLoading ? 4 : properties.length,
              ),
            ),
    );
  }
}
