import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/units_model.dart';
import '../pages/units_page.dart';
import 'units_card _in_hotel_details_widget.dart';

class ShowUnitsInHotelDetailsWidget extends StatefulWidget {
  final List<SectionsOfPropertyModel> sections;
  final int propertyId;
  final String nameProp;
  final String location;
  final String image;

  const ShowUnitsInHotelDetailsWidget(
      {super.key,
      required this.sections,
      required this.propertyId,
      required this.location,
      required this.nameProp,
      required this.image});

  @override
  State<ShowUnitsInHotelDetailsWidget> createState() =>
      _ShowUnitsInHotelDetailsWidgetState();
}

class _ShowUnitsInHotelDetailsWidgetState
    extends State<ShowUnitsInHotelDetailsWidget> {
  int _selectedSectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final sections = widget.sections;
    if (sections.isEmpty) {
      return const SizedBox.shrink();
    }

    final currentUnits = sections[_selectedSectionIndex].units ?? [];
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
                        propertyId: widget.propertyId,
                        image: widget.image,
                        location: widget.location,
                        nameProp: widget.nameProp,
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
          10.h.verticalSpace,
          SizedBox(
            height: 28.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              itemCount: sections.length,
              separatorBuilder: (_, __) => 8.w.horizontalSpace,
              itemBuilder: (context, index) {
                final section = sections[index];
                final bool isSelected = index == _selectedSectionIndex;

                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedSectionIndex = index;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 38.w, vertical: 4.h),
                    decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primarySwatch.shade50
                                .withValues(alpha: .15)
                            : AppColors.scaffoldColor,
                        borderRadius: BorderRadius.circular(20.r),
                        border: isSelected
                            ? Border.all(
                                color: AppColors.primaryColor, width: 0.6)
                            : Border.all(
                                color: AppColors.greySwatch.shade200,
                                width: 0.6)),
                    alignment: Alignment.center,
                    child: AutoSizeTextWidget(
                      text: section.name,
                      fontSize: 10.sp,
                      colorText: isSelected
                          ? AppColors.primaryColor
                          : AppColors.mainColorFont,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              },
            ),
          ),
          12.h.verticalSpace,
          SizedBox(
            height: 214.h,
            child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                children: currentUnits.map((unit) {
                  return Row(
                    children: [
                      UnitsCardInHotelDetailsWidget(
                        unit: unit,
                        location: widget.location,
                        image: widget.image,
                        nameProp: widget.nameProp,
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
