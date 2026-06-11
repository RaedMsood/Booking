import 'package:booking/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../my_bookings/presentation/riverpod/my_bookings_riverpod.dart';
import '../../../payment/data/mapper/booking_payment_request_mapper.dart';
import '../../../payment/presentation/widget/payment_action_button_widget.dart';
import '../../../payment/presentation/widget/payment_methods_section_widget.dart';
import '../../data/booking_model/booking_data.dart';
import '../../data/booking_model/booking_data_model.dart';
import '../widget/audience_in_details_booking_widget.dart';
import '../widget/bill_summary_widget.dart';
import '../widget/booking_success_dialog_widget.dart';
import '../widget/confrim_booking_details_widget.dart';
import '../widget/deposit_in_last_details_widget.dart';
import '../widget/desgin_button_in_add_booking_widget.dart';

class ShowLastDetailsInAddBookingPage extends ConsumerStatefulWidget {
  const ShowLastDetailsInAddBookingPage({
    super.key,
    required this.bookingData,
    required this.bookingDataModel,
    required this.image,
    required this.nameProp,
    required this.location,
  });

  final BookingData bookingData;
  final BookingDataModel bookingDataModel;
  final String nameProp;
  final String location;
  final String image;

  @override
  ConsumerState<ShowLastDetailsInAddBookingPage> createState() =>
      _ShowLastDetailsInAddBookingPageState();
}

class _ShowLastDetailsInAddBookingPageState
    extends ConsumerState<ShowLastDetailsInAddBookingPage> {
  late BookingData _bookingData;
  late BookingDataModel _bookingDataModel;

  String? _validateBookingPhone(BuildContext context, String? value) {
    final phone = value?.trim() ?? '';
    if (!phone.startsWith('7')) {
      return S.of(context).phoneMustStartWith7;
    }
    if (phone.length < 9) {
      return S.of(context).phoneMustBe9Digits;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _bookingData = widget.bookingData;
    _bookingDataModel = widget.bookingDataModel;
  }

  void _handlePaymentSuccess(
    BuildContext context,
    WidgetRef ref,
    String? purchaseId,
  ) {
    final normalizedPurchaseId = purchaseId?.trim() ?? '';
    if (normalizedPurchaseId.isNotEmpty) {
      final updatedBookingData = _bookingData.copyWith(
        purchaseId: normalizedPurchaseId,
      );
      setState(() {
        _bookingData = updatedBookingData;
        _bookingDataModel = BookingDataModel(
          bookingData: updatedBookingData,
          customer: _bookingDataModel.customer,
        );
      });
    }
    CompleteBooking.successDialog(context, ref);
    ref.invalidate(getBookingProvider(0));
  }

  @override
  Widget build(BuildContext context) {
    final paymentRequest = _bookingDataModel.toPaymentRequest(
      initialPhoneNumber: Auth().phoneNumber,
      phoneValidator: _validateBookingPhone,
      floosakMinimumAmountErrorBuilder: (context) =>
          'يجب أن يكون المبلغ المدخل مساويًا أو أكبر من مبلغ العربون',
    );

    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).payDeposit),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    ConfrimBookingDetailsWidget(
                      unitCount: _bookingData.unitCount.toString(),
                      unitName: _bookingData.unitName.toString(),
                      bookAt: _bookingData.bookingAt.toString(),
                      checkIn: _bookingData.checkIn.toString(),
                      checkOut: _bookingData.checkOut.toString(),
                      displayPrice: _bookingData.resolvedTotalAfterOffer ?? 0.0,
                      originalPrice: _bookingData.resolvedTotalBeforeOffer,
                    ),
                    12.verticalSpace,
                    AudienceInDetailsBookingWidget(
                      numChild: _bookingData.childCount ?? 0,
                      numGuests: _bookingData.guests ?? 0,
                      type: _bookingData.type.toString(),
                    ),
                    12.verticalSpace,
                    DepositInLastDetailsWidget(
                      deposit: _bookingData.deposit,
                    ),
                    12.verticalSpace,
                    PaymentMethodsSectionWidget(
                      title: S.of(context).paymentMethods,
                    ),
                    12.verticalSpace,
                    BookingBillSummaryWidget(
                      totalPrice: _bookingData.displayPrice,
                      originalPrice: _bookingData.originalPriceBeforeDiscount,
                      totalBeforeOffer: _bookingData.resolvedTotalBeforeOffer,
                      totalAfterOffer: _bookingData.resolvedTotalAfterOffer,
                      totalDiscountAmount: _bookingData.resolvedTotalDiscountAmount,
                      deposit: _bookingData.deposit,
                    ),
                    12.verticalSpace,
                  ],
                ),
              ),
            ),
            DesginButtonInAddBookingWidget(
              button: PaymentActionButtonWidget(
                paymentRequest: paymentRequest,
                buttonText: S.of(context).payAction,
                height: 38.h,
                onPaymentSuccess: (_, paymentRef, purchaseId) {
                  _handlePaymentSuccess(context, paymentRef, purchaseId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
