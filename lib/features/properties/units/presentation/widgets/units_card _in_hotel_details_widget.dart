import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/units_model.dart';
import '../pages/unit_details_page.dart';

class UnitsCardInHotelDetailsWidget extends StatelessWidget {
  final UnitsModel unit;
  final String nameProp;
  final String location;
  final String image;

  const UnitsCardInHotelDetailsWidget(
      {super.key,
      required this.unit,
      required this.location,
      required this.nameProp,
      required this.image});

  String _guestsText() {
    if (unit.maxGuests == 1) {
      return S.current.personOne;
    } else if (unit.maxGuests == 2) {
      return S.current.personTwo;
    } else {
      return '${unit.maxGuests} ${S.current.personOther}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
          // color: const Color(0xfff9f9f9),
          color: AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.greySwatch.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: OnlineImagesWidget(
              imageUrl: unit.image.toString(),
              size: Size(double.infinity, 90.h),
              borderRadius: 8.r,
            ),
          ),
          4.h.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PriceAndCurrencyWidget(
                price: unit.price,
                fontSize: 12.sp,
                fontSizeSecondText: 11.4.sp,
              ),
              2.h.verticalSpace,
              AutoSizeTextWidget(
                text: unit.name,
                fontSize: 10.sp,
                colorText: AppColors.greySwatch.shade700,
                fontWeight: FontWeight.w400,
                maxLines: 2,
              ),
              6.h.verticalSpace,
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.gender,
                    height: 11.4.h,
                    color: Colors.black,
                  ),
                  4.w.horizontalSpace,
                  Flexible(
                    child: AutoSizeTextWidget(
                      text: _guestsText(),
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              4.h.verticalSpace,
              Divider(color: AppColors.greySwatch.shade200,thickness: 1.h,),
              4.h.verticalSpace,

              DefaultButtonWidget(
                text: S.of(context).viewDetails,
                background: Colors.white70,
                border: Border.all(color: AppColors.greySwatch.shade200),
                textColor: AppColors.greySwatch.shade700,
                height: 28.h,
                textSize: 8.6.sp,
                borderRadius: 14.r,
                fontWeight: FontWeight.w400,
                onPressed: () {
                  navigateTo(
                    context,
                    UnitDetailsPage(
                      unitId: unit.id,
                      location: location,
                      image: image,
                      nameProp: nameProp,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
