import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import '../../theme/app_colors.dart';
import '../auto_size_text_widget.dart';

class DefaultButtonWidget extends StatelessWidget {
  double? width = double.infinity;
  double? height;
  final Color? background;
  final Function()? onPressed;
  final String text;
  double? textSize;
  Color? textColor;
  double? borderRadius;
  double? maxFontSize;
  double? minFontSize;
  FontWeight? fontWeight;
  bool? isLoading;
  final Border? border;
  bool? withIcon=false;
  String? icon;

  DefaultButtonWidget(
      {super.key,
      this.width,
      this.height,
      this.background,
      this.onPressed,
      required this.text,
      this.textColor,
      this.textSize,
      this.fontWeight,
      this.borderRadius,
      this.maxFontSize,
      this.minFontSize,
      this.isLoading,
      this.border,
      this.withIcon,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLoading == true ? 0.5 : 1,
      child: Container(
        width: width,
        height: height ?? 44.h,
        decoration: BoxDecoration(
          color: background ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 20.r),
          border: border ??
              Border.all(
                color: Colors.transparent,
                width: 0,
              ),
        ),
        child: Center(
          child: MaterialButton(
            height: height ?? 40.h,
            minWidth: double.infinity,
            onPressed: onPressed,
            child: isLoading == true
                ? SpinKitCircle(
                    color: textColor ?? AppColors.whiteColor,
                    size: 20.r,
                  )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AutoSizeTextWidget(
                        text: text,
                        fontSize: textSize ?? 13.sp,
                        colorText: textColor ?? Colors.white,
                        textAlign: TextAlign.center,
                        fontWeight: fontWeight ?? FontWeight.w600,
                        maxFontSize: maxFontSize ?? 25,
                        minFontSize: minFontSize ?? 8,
                      ),

                      Visibility(
                        visible: withIcon==true,
                        child: Padding(
                          padding:  EdgeInsets.only(left: 8.0.sp,right: 8.sp),
                          child: SvgPicture.asset(
                            icon??'',
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
