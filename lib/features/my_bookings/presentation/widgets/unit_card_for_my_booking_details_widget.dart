import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';
import '../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../properties/units/data/model/units_model.dart';
import '../../../properties/units/presentation/pages/unit_details_page.dart';

class UnitCardForMyBookingDetailsWidget extends StatelessWidget {
  final UnitsModel units;

  const UnitCardForMyBookingDetailsWidget({super.key, required this.units});

  String _guestsText() {
    if (units.maxGuests == 1) {
      return S.current.personOne;
    } else if (units.maxGuests == 2) {
      return S.current.personTwo;
    } else {
      return '${units.maxGuests} ${S.current.personOther}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
          context,
          UnitDetailsPage(unitId: units.id),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .02),
              blurRadius: 1.r,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            OnlineImagesWidget(
              imageUrl: units.image.toString(),
              size: Size(88.w, 76.h),
              fit: BoxFit.cover,
              borderRadius: 12.r,
              logoWidth: 28.w,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    6.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: units.name,
                      fontSize: 10.6.sp,
                      maxLines: 2,
                    ),
                    6.h.verticalSpace,
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.gender,
                          height: 12.h,
                          color: const Color(0xff605A65),
                        ),
                        4.w.horizontalSpace,
                        Flexible(
                          child: AutoSizeTextWidget(
                            text: _guestsText(),
                            fontSize: 9.sp,
                            colorText: const Color(0xff605A65),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    6.h.verticalSpace,
                    PriceAndCurrencyWidget(
                      price: units.price,
                      fontSize: 11.sp,
                      fontSizeSecondText: 9.sp,
                      secondColor: AppColors.primaryColor,
                      fontWeightSecondText: FontWeight.w500,
                    ),
                    6.h.verticalSpace,
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
