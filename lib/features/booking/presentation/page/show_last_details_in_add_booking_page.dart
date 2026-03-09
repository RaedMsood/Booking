import 'package:booking/core/helpers/navigateTo.dart';
import 'package:booking/core/state/check_state_in_get_api_data_widget.dart';
import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:booking/features/booking/presentation/page/pay_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../../data/booking_model/booking_data.dart';
import '../../data/booking_model/pay_spec.dart';
import '../riverpod/booking_riverpod.dart';
import '../widget/audience_in_details_booking_widget.dart';
import '../widget/bill_summary_widget.dart';
import '../widget/confrim_booking_details_widget.dart';
import '../widget/deposit_in_last_details_widget.dart';
import '../widget/desgin_button_in_add_booking_widget.dart';
import '../widget/discount_code_widget.dart';
import '../widget/general_design_for_booking_widget.dart';
import '../widget/hotel_summary_card_widget.dart';
import '../widget/list_of_pay_method_widget.dart';
import '../widget/pay_method_widget.dart';

class ShowLastDetailsInAddBookingPage extends ConsumerWidget {
  const ShowLastDetailsInAddBookingPage({
    super.key,
    required this.bookingData,
    required this.image,
    required this.nameProp,
    required this.location,
  });

  final BookingData bookingData;
  final String nameProp;
  final String location;
  final String image;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var payState = ref.watch(getAllPaymentMethodsProvider);
    final errorMessage = ref.watch(selectedPayMethodErrorProvider);
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).payDeposit),
      body: CheckStateInGetApiDataWidget(
        state: payState,
        refresh: () {
          ref.invalidate(getAllPaymentMethodsProvider);
        },
        widgetOfData: SafeArea(
          top: false,
          child: Column(
            children: [
              // 4.h.verticalSpace,
              // HotelSummaryCard(
              //   name: nameProp,
              //   location: location,
              //   imageUrl: image,
              // ),

              Expanded(
                child: SingleChildScrollView(
                  padding:    EdgeInsets.symmetric(horizontal: 16.w,),
                  child: Column(
                    children: [
                      ConfrimBookingDetailsWidget(
                        unitCount: bookingData.unitCount.toString(),
                        unitName: bookingData.unitName.toString(),
                        bookAt: bookingData.bookingAt.toString(),
                        checkIn: bookingData.checkIn.toString(),
                        checkOut: bookingData.checkOut.toString(),
                        totalPrice:
                            double.tryParse(bookingData.totalPrice.toString()) ??
                                0.0,
                      ),
                      // 18.verticalSpace,
                      // Consumer(
                      //   builder: (context, ref, child) {
                      //     return DefaultButtonWidget(
                      //       text: S.of(context).payDeposit,
                      //       textSize: 12.sp,
                      //       borderRadius: 12.r,
                      //       onPressed: () {
                      //         ref.read(selectedPayMethodProvider.notifier).state =
                      //             null;
                      //         ref
                      //             .read(selectedPayMethodErrorProvider.notifier)
                      //             .state = null;
                      //         navigateTo(
                      //             context, PayPage(bookingData: bookingData));
                      //       },
                      //       withIcon: true,
                      //       icon: AppIcons.pay,
                      //     );
                      //   },
                      // ),
                      // 6.verticalSpace,
                      // AutoSizeTextWidget(
                      //   text: S.of(context).payDepositNote,
                      //   fontSize: 9.8.sp,
                      //   fontWeight: FontWeight.w300,
                      //   colorText: const Color(0xff001A33),
                      // ),
                      12.verticalSpace,
                      AudienceInDetailsBookingWidget(
                        numChild: bookingData.childCount ?? 0,
                        numGuests: bookingData.guests ?? 0,
                        type: bookingData.type.toString(),
                      ),
                      12.verticalSpace,
                      DepositInLastDetailsWidget(
                        deposit: bookingData.deposit,
                      ),
                      // 14.verticalSpace,
                      // AutoSizeTextWidget(
                      //   text: S.of(context).confirmDepositTitle,
                      //   fontSize: 12.6.sp,
                      // ),
                      // 6.verticalSpace,
                      // AutoSizeTextWidget(
                      //   text: S.of(context).hotelPaymentNote,
                      //   fontSize: 10.sp,
                      //   fontWeight: FontWeight.w400,
                      //   colorText: const Color(0xff605A65),
                      // ),
                      12.verticalSpace,
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
                      12.verticalSpace,
                      BillSummaryWidget(
                        totalPrice: bookingData.totalPrice,
                        deposit: bookingData.deposit,
                      ),
                      12.verticalSpace,


                    ],
                  ),
                ),
              ),
              DesginButtonInAddBookingWidget(
                button: DefaultButtonWidget(
                  text: S.of(context).payAction,
                  height: 38.h,
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
