import 'package:flutter/material.dart';
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

  final Color?cursorColor;
  final EdgeInsetsGeometry?contentPadding;
  const TextFormFieldWidget({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine ?? 1,
      maxLength:maxLength ,
      controller: controller,
      keyboardType: type ?? TextInputType.text,
      validator: fieldValidator,
      obscureText: isPassword ?? false,
      autofocus: autofocus ?? false,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      onChanged: onChanged,
      cursorColor:cursorColor?? AppColors.primaryColor,
      decoration: InputDecoration(
        fillColor: fillColor ?? Color(0xfff4f6f9),
        filled: true,
        hintText: hintText,
        labelText: label,
        hintStyle: TextStyle(
          fontSize: hintFontSize ?? 11.sp,
          color: hintTextColor ?? const Color(0xffa9a9a9),
          fontWeight: FontWeight.w400,
        ),
        labelStyle: TextStyle(
          fontSize: labelFontSize ?? 11.sp,
          color: labelTextColor ?? const Color(0xffa9a9a9),
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: borderSideError ?? BorderSide.none,
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: borderSideError ?? BorderSide.none,
          borderRadius: BorderRadius.circular(12.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: borderSide ?? BorderSide.none,
          borderRadius: BorderRadius.circular(12.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: borderSide ?? BorderSide.none,
          borderRadius: BorderRadius.circular(12.r),
        ),
        prefixIcon: prefix,
        suffixIcon: suffixIcon,
        contentPadding:contentPadding?? const EdgeInsets.all(12.0),
      ),
      expands: expanded ?? false,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
