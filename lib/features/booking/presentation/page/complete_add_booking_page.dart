import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:booking/features/booking/presentation/page/show_last_details_in_add_booking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../widget/desgin_button_in_add_booking_widget.dart';
import '../widget/hotel_summary_card_widget.dart';
import '../widget/select_filed_widget.dart';

class CompleteAddBookingPage extends StatelessWidget {
  CompleteAddBookingPage({super.key});

  final TextEditingController x = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const AutoSizeTextWidget(
          text: 'حجز الفندق',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HotelSummaryCard(
                    name: "فندق ام القرى السياحي",
                    location: "هبرة , سعوان",
                    imageUrl: '',
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        12.verticalSpace,
                        const AutoSizeTextWidget(
                          text: 'بيانات الشخص',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        8.verticalSpace,
                        AutoSizeTextWidget(
                          text: 'الاسم',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          colorText: Color(0xff2E3333),
                        ),
                        6.verticalSpace,
                        TextFormFieldWidget(
                          controller: x,
                        ),
                        6.verticalSpace,
                        AutoSizeTextWidget(
                          text: 'البريد الالكتروني',
                          fontSize:11.sp,
                          fontWeight: FontWeight.w400,
                          colorText: Color(0xff2E3333),
                        ),
                        6.verticalSpace,
                        TextFormFieldWidget(
                          controller: x,
                        ),
                        6.verticalSpace,
                        AutoSizeTextWidget(
                          text: 'الرقم',
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          colorText: Color(0xff2E3333),
                        ),
                        6.verticalSpace,
                        TextFormFieldWidget(
                          controller: x,
                        ),
                        6.verticalSpace,
                        SelectFieldWidget(
                          fontSizeLabel: 11.sp,
                          fontSizeValue: 11.sp,
                          label: 'المحافظة',
                          value: "صنعاء",
                          fontColorLabel: Color(0xff2E3333),
                          selectFiledColor: Colors.white,
                          onTap: () => showModalBottomSheetWidget(
                            page: Column(
                              mainAxisSize: MainAxisSize.min,
                              children:
                                  ['هبرة', 'ذمار', 'اب', 'صنعاء'].map((opt) {
                                return ListTile(
                                  title: Center(
                                    child: AutoSizeTextWidget(
                                      text: opt,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            context: context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          DesginButtonInAddBookingWidget(
           button: DefaultButtonWidget(text: "التالي",onPressed: (){
             navigateTo(context, ShowLastDetailsInAddBookingPage());
           },),
          ),
        ],
      ),
    );
  }
}
