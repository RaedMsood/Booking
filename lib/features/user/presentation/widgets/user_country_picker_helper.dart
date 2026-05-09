import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class UserCountrySelection {
  final String dialCode;
  final String flagEmoji;

  const UserCountrySelection({
    required this.dialCode,
    required this.flagEmoji,
  });
}

class UserCountryPickerHelper {
  static const List<String> arabCountryCodes = [
    'YE',
    'SA',
    'AE',
    'EG',
    'JO',
    'IQ',
    'SY',
    'LB',
    'PS',
    'OM',
    'QA',
    'KW',
    'BH',
    'DZ',
    'MA',
    'TN',
    'LY',
    'SD',
    'SO',
    'DJ',
    'MR',
    'KM',
  ];

  static void show({
    required BuildContext context,
    required ValueChanged<UserCountrySelection> onSelected,
  }) {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      favorite: arabCountryCodes,
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.82,
        flagSize: 20.sp,
        textStyle: TextStyle(
          fontSize: 12.sp,
          fontFamily: 'ReadexPro',
          color: AppColors.mainColorFont,
          fontWeight: FontWeight.w500,
        ),
        searchTextStyle: TextStyle(
          fontSize: 11.sp,
          fontFamily: 'ReadexPro',
          color: AppColors.mainColorFont,
          fontWeight: FontWeight.w400,
        ),
        inputDecoration: InputDecoration(
          hintText: 'ابحث عن الدولة',
          hintStyle: TextStyle(
            fontSize: 10.4.sp,
            fontFamily: 'ReadexPro',
            color: AppColors.fontColor2,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 18.sp,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      onSelect: (country) {
        onSelected(
          UserCountrySelection(
            dialCode: country.phoneCode,
            flagEmoji: country.flagEmoji,
          ),
        );
      },
    );
  }
}

