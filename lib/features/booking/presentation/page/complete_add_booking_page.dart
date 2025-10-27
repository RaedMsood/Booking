import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../../../properties/cities/presentation/riverpod/cities_riverpod.dart';
import '../../../properties/cities/presentation/widget/city_widget.dart';
import '../../data/booking_model/booking_data.dart';
import '../../data/booking_model/booking_data_model.dart';
import '../riverpod/booking_riverpod.dart';
import '../widget/desgin_button_in_add_booking_widget.dart';
import '../widget/hotel_summary_card_widget.dart';
import 'show_last_details_in_add_booking_page.dart';

class CompleteAddBookingPage extends ConsumerStatefulWidget {
  const CompleteAddBookingPage({
    super.key,
    required this.booking,
    required this.location,
    required this.nameProp,
    required this.imageUrl,
  });

  final String nameProp;
  final String location;
  final String? imageUrl;
  final BookingData booking;

  @override
  ConsumerState<CompleteAddBookingPage> createState() =>
      _CompleteAddBookingPageState();
}

class _CompleteAddBookingPageState
    extends ConsumerState<CompleteAddBookingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selectedCityProvider.notifier).state = initialCity;
    });
  }

  final TextEditingController phone = TextEditingController();

  final TextEditingController name = TextEditingController();

  final TextEditingController email = TextEditingController();

  String? city;
  final _formKey = GlobalKey<FormState>();
  dynamic initialCity = Auth().city;

  @override
  Widget build(BuildContext context) {
    name.text = Auth().name;
    email.text = Auth().email;
    phone.text = Auth().phoneNumber;

    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).hotelBookingTitle),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    6.h.verticalSpace,
                    HotelSummaryCard(
                      name: widget.nameProp,
                      location: widget.location,
                      imageUrl: widget.imageUrl ?? '',
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            14.h.verticalSpace,
                            AutoSizeTextWidget(
                              text: "${S.of(context).personalInfoTitle} ${widget.booking.deposit}",
                              fontSize: 11.6.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            12.verticalSpace,
                            AutoSizeTextWidget(
                              text: S.of(context).fullName,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              colorText: const Color(0xff2E3333),
                            ),
                            6.verticalSpace,
                            TextFormFieldWidget(
                                controller: name,
                                type: TextInputType.name,
                                hintText: S.of(context).fullNamePlaceholder,
                                prefix: Icon(
                                  Icons.person_2_outlined,
                                  size: 20.sp,
                                  color: AppColors.primaryColor,
                                ),
                                fieldValidator: (value) {
                                  if (value == null || value.toString().isEmpty) {
                                    return S.of(context).nameRequired;
                                  }
        
                                  return null;
                                }),
                            12.verticalSpace,
                            AutoSizeTextWidget(
                              text: S.of(context).email,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              colorText: const Color(0xff2E3333),
                            ),
                            6.verticalSpace,
                            TextFormFieldWidget(
                                controller: email,
                                type: TextInputType.emailAddress,
                                hintText: S.of(context).emailPlaceholder,
                                prefix: Icon(
                                  Icons.email_outlined,
                                  size: 20.sp,
                                  color: AppColors.primaryColor,
                                ),
                                fieldValidator: (value) {
                                  if ((value == null ||
                                      value.toString().isEmpty)) {
                                    return S.of(context).emailRequired;
                                  }
                                  final emails = email.text.trim();
                                  final emailRegex =
                                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                  if (!emailRegex.hasMatch(emails)) {
                                    return S.of(context).invalidEmail;
                                  }
                                  return null;
                                }),
                            12.verticalSpace,
                            AutoSizeTextWidget(
                              text: S.of(context).phoneNumber,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              colorText: const Color(0xff2E3333),
                            ),
                            6.verticalSpace,
                            TextFormFieldWidget(
                              controller: phone,
                              maxLength: 9,
                              buildCounter: false,
                              type: TextInputType.phone,
                              prefix: Icon(
                                Icons.phone_outlined,
                                size: 20.sp,
                                color: AppColors.primaryColor,
                              ),
                              fieldValidator: (value) {
                                if (value == null || value.toString().isEmpty) {
                                  return S.of(context).phoneRequired;
                                }
                                final phone = value.trim();
                                if (!phone.startsWith('7')) {
                                  return S.of(context).phoneMustStartWith7;
                                }
                                if (phone.length < 9) {
                                  return S.of(context).phoneMustBe9Digits;
                                }
                                return null;
                              },
                            ),
                            CityWidget(
                              fontSize: 11.sp,
                              colorText: const Color(0xff2E3333),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(customerBookingProvider);
                return DesginButtonInAddBookingWidget(
                  button: CheckStateInPostApiDataWidget(
                    state: state,
                    hasMessageSuccess: false,
                    functionSuccess: () {
                      navigateTo(
                          context,
                          ShowLastDetailsInAddBookingPage(
                            bookingData: state.data.bookingData,
                            nameProp: widget.nameProp,
                            location: widget.location,
                            image: widget.imageUrl ?? '',
                          ));
                    },
                    bottonWidget: DefaultButtonWidget(
                        isLoading: state.stateData == States.loading,
                        text: S.of(context).next,
                        onPressed: () {
                          final isValid = _formKey.currentState!.validate();

                          initialCity =
                              ref.read(selectedCityProvider.notifier).state!;
                          if (isValid) {
                            final custemor = Customer(
                              email: email.text,
                              name: name.text,
                              phone: phone.text,
                              address: initialCity.name,
                              booking: widget.booking,
                            );
                            ref
                                .read(customerBookingProvider.notifier)
                                .customerBooking(customer: custemor);
                          }
                        }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
