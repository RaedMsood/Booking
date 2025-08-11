import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/units_model.dart';
import '../pages/units_page.dart';
import 'units_card _in_hotel_details_widget.dart';

class ShowUnitsInHotelDetailsWidget extends StatelessWidget {
  final List<UnitsModel> units;
  final int propertyId;
  final String nameProp;
  final String location;
  final String image;

  const ShowUnitsInHotelDetailsWidget(
      {super.key,
      required this.units,
      required this.propertyId,
      required this.location,
      required this.nameProp,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.h),
      padding: EdgeInsets.symmetric(vertical: 10.h),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeTextWidget(
                  text: S.of(context).hotelRooms,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
                InkWell(
                  onTap: () {
                    navigateTo(
                      context,
                      UnitsPage(
                        propertyId: propertyId,
                        image: image,
                        location: location,
                        nameProp: nameProp,
                      ),
                    );
                  },
                  child: AutoSizeTextWidget(
                    text: S.of(context).viewMore,
                    fontSize: 10.4.sp,
                    colorText: AppColors.primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          12.h.verticalSpace,
          SizedBox(
            height: 214.h,
            child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                children: units.map((unit) {
                  return Row(
                    children: [
                      UnitsCardInHotelDetailsWidget(
                        unit: unit,
                        location: location,
                        image: image,
                        nameProp: nameProp,
                      ),
                      10.w.horizontalSpace,
                    ],
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}
