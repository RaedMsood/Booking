import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/specific_offer_item_model.dart';
import 'hotel_offer_chip_widget.dart';

class SpecificOffersHotelsChipsWidget extends StatelessWidget {
  const SpecificOffersHotelsChipsWidget({
    super.key,
    required this.hotels,
    required this.selectedIndex,
    required this.onSelect,
  });

  final List<SpecificOfferItemModel> hotels;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        scrollDirection: Axis.horizontal,
        itemCount: hotels.length,
        separatorBuilder: (_, __) => 8.w.horizontalSpace,
        itemBuilder: (context, index) {
          final item = hotels[index];

          return HotelOfferChipWidget(
            item: item,
            isSelected: selectedIndex == index,
            onTap: () => onSelect(index),
          );
        },
      ),
    );
  }
}

