import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showModalBottomSheetWidget({
  required BuildContext context,
  required Widget page,
  Color? backgroundColor,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor:backgroundColor?? Colors.white,
    builder: (context) =>  Padding(
      padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: page,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14.sp),
        topRight: Radius.circular(14.sp),
      ),
    ),
  );
}
void scrollShowModalBottomSheetWidget({
  required BuildContext context,
  required Widget page,
  Color? backgroundColor,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: backgroundColor ?? Colors.white,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.9, // الحجم الابتدائي عند فتحه (50% من الشاشة)
      minChildSize: 0.5, // الحد الأدنى للحجم
      maxChildSize: 0.98, // الحد الأقصى للحجم عند السحب
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(14.sp)),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: page,
          ),
        );
      },
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(14.sp),
        topRight: Radius.circular(14.sp),
      ),
    ),
  );
}