import 'package:booking/core/widgets/price_and_currency_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/units_model.dart';
import '../pages/unit_details_page.dart';

class UnitCardWidget extends StatelessWidget {
  final UnitsModel units;
  final String nameProp;
  final String location;
  final String image;

  const UnitCardWidget(
      {super.key,
      required this.units,
      required this.location,
      required this.nameProp,
      required this.image});

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
          UnitDetailsPage(
            unitId: units.id,
            image: image,
            location: location,
            nameProp: nameProp,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
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
              borderRadius: 10.r,
              logoWidth: 34.w,
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
                      fontSize: 10.8.sp,
                      colorText: AppColors.greySwatch.shade700,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                    ),
                    6.h.verticalSpace,
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.gender,
                          height: 13.5.h,
                          color: Colors.black,
                        ),
                        4.w.horizontalSpace,
                        Flexible(
                          child: AutoSizeTextWidget(
                            text: _guestsText(),
                            fontSize: 9.6.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    6.h.verticalSpace,
                    PriceAndCurrencyWidget(
                      price: units.price,
                      fontSize: 11.6.sp,
                      fontSizeSecondText: 10.5.sp,
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
