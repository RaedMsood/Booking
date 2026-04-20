import 'package:booking/core/helpers/navigateTo.dart';
import 'package:flutter/material.dart';

import '../../../property_details/presentation/pages/property_details_page.dart';
import '../../data/model/property_data_model.dart';
import '../riverpod/home_riverpod.dart';
import 'property_card_shell.dart';
import 'property_grid_card_body.dart';
import 'property_vertical_card_body.dart';

class PropertyCardWidget extends StatelessWidget {
  final PropertyDataModel property;
  final int viewType;
  final bool propertiesByCity;

  const PropertyCardWidget({
    super.key,
    required this.property,
    this.viewType = 2,
    this.propertiesByCity = false,
  });

  @override
  Widget build(BuildContext context) {
    final isGridView = viewType == HomePropertyViewType.grid;

    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          PropertyDetailsPage(
            propertyId: property.id,
            images: property.mainImageUrls,
          ),
        );
      },
      child: PropertyCardShell(
        propertiesByCity: propertiesByCity,
        child: isGridView
            ? PropertyGridCardBody(property: property)
            : PropertyVerticalCardBody(property: property),
      ),
    );
  }
}