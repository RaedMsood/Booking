import 'package:booking/core/theme/app_colors.dart';
import 'package:booking/core/widgets/auto_size_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/state.dart';
import '../../data/model/property_data_model.dart';
import '../riverpod/home_riverpod.dart';
import 'property_card_widget.dart';

class PropertySliverListWidget extends ConsumerWidget {
  final List<PropertyDataModel> properties;
  final States state;
  final bool hasMore;
  final bool propertiesByCity;

  const PropertySliverListWidget({
    super.key,
    required this.properties,
    required this.state,
    required this.hasMore,
    this.propertiesByCity = false,

  });

  @override
  Widget build(BuildContext context, ref) {
    var provider = ref.read(getAllPropertyProvider.notifier);

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 14.w)
          .copyWith(bottom: 14.h, top: 8.h),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == properties.length) {
              if (state == States.loadingMore) {
                return const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              else if (!hasMore) {
                return Center(
                  child: AutoSizeTextWidget(
                    text: "انتهت قائمة الفنادق المتوفرة، نتمنى لك إقامة سعيدة.",
                    fontSize: 10.8.sp,
                    fontWeight: FontWeight.w500,
                    colorText: AppColors.fontColor2,
                  ),
                );
              }
            }

            return PropertyCardWidget(
              property: properties[index],
              propertiesByCity: propertiesByCity,
            );
          },
          childCount: properties.length +
              ((state == States.loadingMore || !hasMore) ? 1 : 0),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: provider.viewType,
          mainAxisSpacing: 20.r,
          crossAxisSpacing: 21.w,
          childAspectRatio: provider.viewType == 2 ? 0.57.h : 1.28.h,
        ),
      ),
    );
  }
}

// return SliverPadding(
//   padding: EdgeInsets.symmetric(horizontal: 14.w)
//       .copyWith(bottom: 94.h,top: 2.h
//   ),
//   sliver: SliverList(
//     delegate: SliverChildBuilderDelegate(
//       (context, index) {
//         if (index == properties.length) {
//           if (state == States.loadingMore) {
//             return const CircularProgressIndicatorWidget();
//           } else if (!hasMore) {
//             return Padding(
//               padding: EdgeInsets.only(top: 4.h),
//               child: Center(
//                 child: AutoSizeTextWidget(
//                   text:
//                       "انتهت قائمة الفنادق المتوفرة، نتمنى لك إقامة سعيدة.",
//                   fontSize: 10.8.sp,
//                   fontWeight: FontWeight.w500,
//                   colorText: AppColors.fontColor2,
//                 ),
//               ),
//             );
//           }
//         }
//         return PropertyCardWidget(
//           property: properties[index],
//         );
//       },
//       childCount: properties.length +
//           ((state == States.loadingMore || !hasMore) ? 1 : 0),
//     ),
//   ),
// );
