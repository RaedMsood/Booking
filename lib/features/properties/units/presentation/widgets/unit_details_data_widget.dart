import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/read_more_text_widget.dart';
import '../../data/model/attachments_model.dart';
import 'attachments_widget.dart';

class UnitDetailsDataWidget extends StatelessWidget {
  final String name;
  final String description;
  final int maxGuests;
  final List<AttachmentsModel> attachments;

  const UnitDetailsDataWidget({
    super.key,
    required this.name,
    required this.description,
    required this.maxGuests,
    required this.attachments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12.h),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.gender,
                      height: 14.h,
                    ),
                    4.w.horizontalSpace,
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: "شخصين",
                        fontSize: 9.6.sp,
                        colorText: AppColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                6.h.verticalSpace,
                AutoSizeTextWidget(
                  text: name,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w500,
                  maxLines: 2,
                  minFontSize: 12,
                ),
                if (description.isNotEmpty) ...[
                  8.h.verticalSpace,
                  ReadMoreTextWidget(
                    text: description,
                  ),
                ],
              ],
            ),
          ),
          6.h.verticalSpace,
          if (attachments.isNotEmpty)
            AttachmentsWidget(
              attachments: attachments,
            ),
        ],
      ),
    );
  }
}
