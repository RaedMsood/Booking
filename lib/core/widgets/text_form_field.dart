import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class TextFormFieldWidget extends StatefulWidget {
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
  final FocusNode? focusNode;
  final bool preserveFocusOnResume;

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
    this.buildCounter = true,
    this.enable,
    this.focusNode,
    this.preserveFocusOnResume = true,
  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget>
    with WidgetsBindingObserver {
  FocusNode? _internalFocus;

  FocusNode get _focus => widget.focusNode ?? _internalFocus!;

  bool _wasFocused = false;

  @override
  void initState() {
    super.initState();
    if (widget.preserveFocusOnResume) {
      WidgetsBinding.instance.addObserver(this);
    }
    _internalFocus ??= widget.focusNode ?? FocusNode();
    _focus.addListener(() {
      _wasFocused = _focus.hasFocus;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!widget.preserveFocusOnResume) return;
    if (state == AppLifecycleState.resumed && _wasFocused && mounted) {
      Future.microtask(() {
        if (!mounted) return;
        FocusScope.of(context).requestFocus(_focus);
        SystemChannels.textInput.invokeMethod('TextInput.show');
      });
    }
  }

  @override
  void dispose() {
    if (widget.preserveFocusOnResume) {
      WidgetsBinding.instance.removeObserver(this);
    }
    if (widget.focusNode == null) {
      _internalFocus?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLine ?? 1,
      maxLength: widget.maxLength,
      buildCounter: widget.buildCounter == true
          ? null
          : (
              BuildContext context, {
              required int currentLength,
              required int? maxLength,
              required bool isFocused,
            }) {
              return null;
            },
      controller: widget.controller,
      focusNode: _focus,
      keyboardType: widget.type ?? TextInputType.text,
      validator: widget.fieldValidator,
      obscureText: widget.isPassword ?? false,
      autofocus: widget.autofocus ?? false,
      onFieldSubmitted: widget.onSubmit,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      cursorColor: widget.cursorColor ?? AppColors.primaryColor,
      style: TextStyle(fontSize: 12.5.sp, fontFamily: "ReadexPro"),
      decoration: InputDecoration(
        fillColor: widget.fillColor ?? Colors.white,
        filled: true,
        hintText: widget.hintText,
        labelText: widget.label,
        hintStyle: TextStyle(
          fontSize: widget.hintFontSize ?? 10.5.sp,
          color: widget.hintTextColor ?? AppColors.fontColor2,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: TextStyle(
          fontSize: widget.labelFontSize ?? 10.sp,
          color: widget.labelTextColor ?? AppColors.fontColor2,
          fontWeight: FontWeight.w400,
        ),
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: widget.borderSideError ?? BorderSide.none,
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: widget.borderSideError ?? BorderSide.none,
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: widget.borderSide ?? BorderSide.none,
          borderRadius: BorderRadius.circular(8.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: widget.borderSide ?? BorderSide.none,
          borderRadius: BorderRadius.circular(8.r),
        ),
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffixIcon,
        contentPadding: widget.contentPadding ?? EdgeInsets.all(11.sp),
      ),
      expands: widget.expanded ?? false,
      enabled: widget.enable ?? true,
      textAlign: widget.textAlign ?? TextAlign.start,
    );
  }
}
