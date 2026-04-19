import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../../../my_bookings/presentation/riverpod/my_bookings_riverpod.dart';
import '../../../user/presentation/widgets/verify_pinput_widget.dart';
import '../../data/booking_model/booking_data_model.dart';
import '../../data/booking_model/floosak_payment_session_model.dart';
import '../riverpod/booking_riverpod.dart';
import 'booking_success_dialog_widget.dart';

class FloosakPaymentOtpWidget extends ConsumerStatefulWidget {
  final BookingDataModel bookingData;
  final FloosakPaymentSessionModel session;

  const FloosakPaymentOtpWidget({
    super.key,
    required this.bookingData,
    required this.session,
  });

  @override
  ConsumerState<FloosakPaymentOtpWidget> createState() =>
      _FloosakPaymentOtpWidgetState();
}

class _FloosakPaymentOtpWidgetState
    extends ConsumerState<FloosakPaymentOtpWidget> with CodeAutoFill {
  static const _otpLen = 6;

  final TextEditingController _verifyController = TextEditingController();
  bool _canAutoSubmit = true;

  @override
  void initState() {
    super.initState();
    listenForCode();
    _verifyController.addListener(_maybeAutoSubmit);
  }

  @override
  void codeUpdated() {
    final c = code ?? '';
    if (c.isNotEmpty) {
      _verifyController.text = c;
    }
  }

  void _maybeAutoSubmit() {
    final text = _verifyController.text.trim();
    if (text.length < _otpLen) {
      _canAutoSubmit = true;
      return;
    }
    if (_canAutoSubmit && text.length == _otpLen) {
      _canAutoSubmit = false;
      FocusManager.instance.primaryFocus?.unfocus();
      ref.read(confirmFloosakPaymentProvider.notifier).confirmPayment(
            bookingData: widget.bookingData,
            session: widget.session,
            otp: text,
          );
    }
  }

  @override
  void dispose() {
    cancel();
    _verifyController.removeListener(_maybeAutoSubmit);
    _verifyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(confirmFloosakPaymentProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 14.w).copyWith(bottom: 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeTextWidget(
            text:
                '${S.of(context).codeHasBeenSendTo} ${widget.session.phoneNumber}',
            fontSize: 10.6.sp,
            fontWeight: FontWeight.w600,
            colorText: AppColors.fontColor,
            maxLines: 2,
          ),
          22.h.verticalSpace,
          VerifyPinputWidget(
            verifyController: _verifyController,
          ),
          22.h.verticalSpace,
          CheckStateInPostApiDataWidget(
            state: state,
            hasMessageSuccess: false,
            functionSuccess: () {
              CompleteBooking.successDialog(context, ref);
              ref.invalidate(getBookingProvider(0));
            },
            bottonWidget: DefaultButtonWidget(
              text: S.of(context).confirm,
              isLoading: state.stateData == States.loading,
              onPressed: () {
                final code = _verifyController.text.trim();
                if (code.length != _otpLen) return;
                FocusManager.instance.primaryFocus?.unfocus();
                ref.read(confirmFloosakPaymentProvider.notifier).confirmPayment(
                      bookingData: widget.bookingData,
                      session: widget.session,
                      otp: code,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}

