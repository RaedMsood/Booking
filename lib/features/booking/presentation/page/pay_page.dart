import 'package:booking/core/state/check_state_in_get_api_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/booking_model/booking_data.dart';
import '../../data/booking_model/pay_spec.dart';
import '../riverpod/booking_riverpod.dart';
import '../widget/bill_summary_widget.dart';
import '../widget/deposit_in_last_details_widget.dart';
import '../widget/desgin_button_in_add_booking_widget.dart';
import '../widget/discount_code_widget.dart';
import '../widget/general_design_for_booking_widget.dart';
import '../widget/pay_method_widget.dart';
import '../widget/list_of_pay_method_widget.dart';

class PayPage extends ConsumerWidget {
  final BookingData bookingData;

  const PayPage({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var payState = ref.watch(getAllPaymentMethodsProvider);
    final errorMessage = ref.watch(selectedPayMethodErrorProvider);

    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).payDeposit),
      body: CheckStateInGetApiDataWidget(
        state: payState,
        refresh: () {
          ref.refresh(getAllPaymentMethodsProvider);
        },
        widgetOfData: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeTextWidget(
                          text: S.of(context).confirmDepositTitle,
                          fontSize: 12.6.sp,
                        ),
                        6.verticalSpace,
                        AutoSizeTextWidget(
                          text: S.of(context).hotelPaymentNote,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          colorText: const Color(0xff605A65),
                        ),
                        14.verticalSpace,
                        DepositInLastDetailsWidget(
                          deposit: bookingData.deposit,
                        ),
                        14.verticalSpace,
                        const DiscountCodeWidget(),
                        14.verticalSpace,
                        if (errorMessage != null)
                          Padding(
                            padding: EdgeInsets.only(bottom: 6.h),
                            child: AutoSizeTextWidget(
                              text: errorMessage,
                              fontSize: 10.sp,
                              colorText: AppColors.dangerColor,
                            ),
                          ),
                        GeneralDesignForBookingWidget(
                          title: S.of(context).paymentMethods,
                          child: ListOfPaymentMethodWidget(
                            paymentData: payState.data,
                          ),
                        ),
                        14.verticalSpace,
                        BillSummaryWidget(
                          totalPrice: bookingData.totalPrice,
                          deposit: bookingData.deposit,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              DesginButtonInAddBookingWidget(
                button: DefaultButtonWidget(
                  text: S.of(context).payAction,
                  onPressed: () {
                    final selectedPayMethod =
                        ref.read(selectedPayMethodProvider);

                    bool hasError = false;
                    if (selectedPayMethod == null) {
                      ref.read(selectedPayMethodErrorProvider.notifier).state =
                          S.of(context).pleaseSelectPaymentMethod;
                      hasError = true;
                    } else {
                      ref.read(selectedPayMethodErrorProvider.notifier).state =
                          null;
                    }

                    if (hasError) return;

                    showTitledBottomSheet(
                      context: context,
                      title: paySpecs[selectedPayMethod!.name]!.codeLabel,
                      page: const PayMethodWidget(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
