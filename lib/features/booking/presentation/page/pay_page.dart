import 'package:booking/features/booking/presentation/page/show_last_details_in_add_booking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../widget/bill_summary_widget.dart';
import '../widget/deposit_in_last_details_widget.dart';
import '../widget/desgin_button_in_add_booking_widget.dart';
import '../widget/discount_code_widget.dart';
import '../widget/payment_method_widget.dart';

class PayPage extends StatelessWidget {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AutoSizeTextWidget(
          text: 'دفع العربون',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text: 'قم بدفع العبون لتاكيد الحجز',
                      fontSize: 13,
                    ),
                    4.verticalSpace,
                    AutoSizeTextWidget(
                      text: 'سيتوجب عليك دفع باقي المبلغ لصاحب الفندق عند الوصول',
                      fontSize: 12,
                      fontWeight: FontWeight.w300,colorText: Color(0xff605A65),
                    ),
                    14.verticalSpace,
                    DepositInLastDetailsWidget(
                      deposit: 50000,
                    ),
                    14.verticalSpace,
                    DiscountCodeWidget(),
                    14.verticalSpace,

                    PaymentMethodsWidget(),
                    14.verticalSpace,
                    BillSummaryWidget(),
                  ],
                ),
              ),
            ),
          ),
          DesginButtonInAddBookingWidget(
            button: DefaultButtonWidget(text: "الدفع"),
          ),
        ],
      ),
    );
  }
}



