import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? type;
  final Color? fillColor;
  final bool? isPassword;
  final String? label;
  final String? hintText;
  final Color? hintTextColor;
  final Color? labelTextColor;
  final double? hintFontSize;
  final double? labelFontSize;
  final TextAlign? textAlign;
  final BorderSide? borderSide;
  final BorderSide? borderSideError;
  final FormFieldValidator? fieldValidator;
  final ValueChanged? onSubmit;
  final ValueChanged<String>? onChanged;
  final Function()? onTap;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool? expanded;
  final bool? autofocus;
  final int? maxLine;
  final int? maxLength;
  final bool? buildCounter;
  final bool? enable;

  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;

  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      this.type,
      this.fillColor,
      this.hintText,
      this.hintTextColor,
      this.hintFontSize,
      this.label,
      this.labelTextColor,
      this.labelFontSize,
      this.textAlign,
      this.borderSide,
      this.borderSideError,
      this.fieldValidator,
      this.isPassword,
      this.prefix,
      this.suffixIcon,
      this.expanded,
      this.autofocus,
      this.maxLine,
      this.maxLength,
      this.onTap,
      this.onChanged,
      this.onSubmit,
      this.cursorColor,
      this.contentPadding,
      this.buildCounter = true,this.enable});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine ?? 1,
      maxLength: maxLength,
      buildCounter: buildCounter == true
          ? null
          : (
              BuildContext context, {
              required int currentLength,
              required int? maxLength,
              required bool isFocused,
            }) {
              return null; // يخفي العداد
            },
      controller: controller,
      keyboardType: type ?? TextInputType.text,
      validator: fieldValidator,
      obscureText: isPassword ?? false,
      autofocus: autofocus ?? false,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      onChanged: onChanged,
      cursorColor: cursorColor ?? AppColors.primaryColor,
      style: TextStyle(fontSize: 12.5.sp, fontFamily: "ReadexPro"),
      decoration: InputDecoration(

        fillColor: fillColor ?? Colors.white,
        filled: true,
        hintText: hintText,
        labelText: label,
        hintStyle: TextStyle(
          fontSize: hintFontSize ?? 10.5.sp,
          color: hintTextColor ?? AppColors.fontColor2,
          fontWeight: FontWeight.w400,
        ),

        labelStyle: TextStyle(
          fontSize: labelFontSize ?? 10.sp,
          color: labelTextColor ?? AppColors.fontColor2,
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: borderSideError ?? BorderSide.none,
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: borderSideError ?? BorderSide.none,
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: borderSide ?? BorderSide.none,
          borderRadius: BorderRadius.circular(8.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: borderSide ?? BorderSide.none,
          borderRadius: BorderRadius.circular(8.r),
        ),

        prefixIcon: prefix,
        suffixIcon: suffixIcon,
        contentPadding: contentPadding ?? EdgeInsets.all(11.sp),
      ),
      expands: expanded ?? false,
      enabled: enable??true,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
