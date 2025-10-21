import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
import 'general_design_for_booking_widget.dart';

class AudienceInDetailsBookingWidget extends StatelessWidget {
  const AudienceInDetailsBookingWidget({
    super.key,
    required this.numChild,
    required this.numGuests,
    required this.type,
  });

  final int numGuests;
  final int numChild;
  final String type;

  @override
  Widget build(BuildContext context) {
    return GeneralDesignForBookingWidget(
      title: S.of(context).guestsInfoTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.profile,
                height: 15.6.h,
                color: const Color(0xff605A65),
              ),
              10.horizontalSpace,
              AutoSizeTextWidget(
                text:type,
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w400,
                colorText: const Color(0xff757575),
              ),
            ],
          ),
          7.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(
                AppIcons.people,
                height: 17.h,
                color: const Color(0xff605A65),
              ),
              10.horizontalSpace,
              AutoSizeTextWidget(
                text:
                    '$numGuests ${S.of(context).personOne} ($numChild ${S.of(context).children})',
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w400,
                colorText: const Color(0xff757575),
              ),
            ],
          ),
          4.verticalSpace,
        ],
      ),
    );
  }
}
