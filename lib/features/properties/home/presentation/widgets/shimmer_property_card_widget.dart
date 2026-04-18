import 'package:flutter/material.dart';
import 'property_card_shell.dart';
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
    return PropertyCardShell(
      propertiesByCity: propertiesByCity,
      child: const ShimmerPropertyVerticalCardBody(),
    );
  }
}
