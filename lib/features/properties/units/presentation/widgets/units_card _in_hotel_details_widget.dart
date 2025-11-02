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
      width: 160.w,
      decoration: BoxDecoration(
        color: const Color(0xfff9f9f9),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
              child: OnlineImagesWidget(
                imageUrl: unit.image.toString(),
                size: Size(double.infinity, 90.h),
                borderRadius: 0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PriceAndCurrencyWidget(
                  price: unit.price,
                  fontSize: 12.sp,
                  fontSizeSecondText: 11.4.sp,
                ),
                6.h.verticalSpace,
                AutoSizeTextWidget(
                  text: unit.name,
                  fontSize: 10.sp,
                  colorText: AppColors.greySwatch.shade700,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                ),
                8.h.verticalSpace,
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.gender,
                      height: 14.h,
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
                10.h.verticalSpace,
                DefaultButtonWidget(
                  text: S.of(context).viewDetails,
                  height: 32.h,
                  textSize: 9.sp,
                  borderRadius: 12.r,
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
          ),
        ],
      ),
    );
  }
}

