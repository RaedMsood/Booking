import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_svg_widget.dart';
import '../../../property_details/data/models/features_model.dart';
import '../../../property_details/presentation/widgets/general_container_for_details_widget.dart';

class UnitFeaturesWidget extends StatelessWidget {
  final List<FeaturesModel> features;

  const UnitFeaturesWidget({super.key, required this.features});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:  EdgeInsets.only(bottom: 12.h),
      child: GeneralContainerForDetailsWidget(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: "المميزات",
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
            8.h.verticalSpace,
            ...features.map(
              (f) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    OnlineSvgWidget(
                      imageUrl: f.icon,
                      color: const Color(0xff605a65),
                      size: Size(18.w, 14.h),
                      logoWidth: 0,
                    ),
                    8.w.horizontalSpace,
                    AutoSizeTextWidget(
                      text: f.name,
                      fontSize: 10.sp,
                      colorText: AppColors.greyColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}