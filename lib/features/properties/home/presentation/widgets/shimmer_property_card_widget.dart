import 'package:flutter/material.dart';

import '../riverpod/home_riverpod.dart';
import 'property_card_shell.dart';
import 'shimmer_property_grid_card_body.dart';
import 'shimmer_property_vertical_card_body.dart';


class ShimmerPropertyCardWidget extends StatelessWidget {
  final bool propertiesByCity;
  final int viewType;

  const ShimmerPropertyCardWidget({
    super.key,
    this.propertiesByCity = false,
    this.viewType = 1,
  });

  @override
  Widget build(BuildContext context) {
    final isGridView = viewType == HomePropertyViewType.grid;

    return PropertyCardShell(
      propertiesByCity: propertiesByCity,
      child: isGridView
          ? const ShimmerPropertyGridCardBody()
          : const ShimmerPropertyVerticalCardBody(),
    );
  }
}
