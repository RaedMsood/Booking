import 'package:booking/core/theme/app_colors.dart';
import 'package:booking/core/widgets/auto_size_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/state/state.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../data/model/property_model.dart';
import 'property_card_widget.dart';

class PropertySliverListWidget extends StatelessWidget {
  final List<PropertyModel> properties;
  final States state;
  final bool hasMore;

  const PropertySliverListWidget({
    super.key,
    required this.properties,
    required this.state,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 14.w)
          .copyWith(bottom: 94.h, top: 12.h),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == properties.length) {
              if (state == States.loadingMore) {
                return const CircularProgressIndicatorWidget();
              } else if (!hasMore) {
                return Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Center(
                    child: AutoSizeTextWidget(
                      text:
                          "انتهت قائمة الفنادق المتوفرة، نتمنى لك إقامة سعيدة.",
                      fontSize: 10.8.sp,
                      fontWeight: FontWeight.w500,
                      colorText: AppColors.fontColor2,
                    ),
                  ),
                );
              }
            }
            return PropertyCardWidget(
              property: properties[index],
            );
          },
          childCount: properties.length +
              ((state == States.loadingMore || !hasMore) ? 1 : 0),
        ),
      ),
    );
  }
}
