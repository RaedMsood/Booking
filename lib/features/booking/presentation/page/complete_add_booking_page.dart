import 'package:booking/core/state/check_state_in_post_api_data_widget.dart';
import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:booking/features/booking/data/booking_model/booking_model.dart';
import 'package:booking/features/booking/presentation/page/show_last_details_in_add_booking_page.dart';
import 'package:booking/features/properties/cities/presentation/widget/city_widget.dart';
import 'package:booking/services/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../properties/cities/presentation/riverpod/cities_riverpod.dart';
import '../riverpod/booking_riverpod.dart';
import '../widget/desgin_button_in_add_booking_widget.dart';
import '../widget/hotel_summary_card_widget.dart';

class CompleteAddBookingPage extends ConsumerStatefulWidget {
  const CompleteAddBookingPage(
      {super.key,
      required this.idBooking,
      required this.location,
      required this.nameProp,
      required this.imageUrl});

  final String nameProp;
  final String location;
  final String? imageUrl;
  final int idBooking;

  @override
  ConsumerState<CompleteAddBookingPage> createState() =>
      _CompleteAddBookingPageState();
}

class _CompleteAddBookingPageState
    extends ConsumerState<CompleteAddBookingPage> {
  @override
  void initState() {
    // TODO: implement initState
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
                              controller: name,
                              type: TextInputType.name,
                              prefix: Icon(Icons.person_2_outlined,
                                  size: 20.sp, color: AppColors.primaryColor),
                              fieldValidator: (value) {
                                if ((value == null ||
                                    value.toString().isEmpty)) {
                                  return 'قم بتسجيل الاسم ';
                                }
                              }),
                          6.verticalSpace,
                          AutoSizeTextWidget(
                            text: 'البريد الالكتروني',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            colorText: Color(0xff2E3333),
                          ),
                          6.verticalSpace,
                          TextFormFieldWidget(
                              controller: email,
                              prefix: Icon(Icons.email_outlined,
                                  size: 20.sp, color: AppColors.primaryColor),
                              type: TextInputType.emailAddress,
                              fieldValidator: (value) {
                                if ((value == null ||
                                    value.toString().isEmpty)) {
                                  return 'قم بتسجيل الايميل ';
                                }
                                final emails = email.text.trim() ?? '';
                                final emailRegex =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegex.hasMatch(emails)) {
                                  return 'الرجاء إدخال بريد إلكتروني صالح';
                                }
                              }),
                          6.verticalSpace,
                          AutoSizeTextWidget(
                            text: 'الرقم',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            colorText: Color(0xff2E3333),
                          ),
                          6.verticalSpace,
                          TextFormFieldWidget(
                              controller: phone,
                              maxLength: 9,
                              buildCounter: false,
                              prefix: Icon(Icons.phone_outlined,
                                  size: 20.sp, color: AppColors.primaryColor),
                              type: TextInputType.number,
                              fieldValidator: (value) {
                                if ((value == null ||
                                    value.toString().isEmpty)) {
                                  return 'قم بتسجيل الرقم  ';
                                }
                                final phone = value.trim();
                                if (!phone.startsWith('7')) {
                                  return "رقم الهاتف يجب أن يبدأ بـ 7 (اليمن)";
                                }
                                if (phone.length < 9) {
                                  return "رقم الهاتف يجب ألا يقل عن 9 أرقام";
                                }
                              }),
                          7.verticalSpace,
                          CityWidget(),
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
                          bookingData: state.data,
                          nameProp: widget.nameProp,
                          location: widget.location,
                          image: widget.imageUrl ?? '',
                        ));
                  },
                  bottonWidget: DefaultButtonWidget(
                      isLoading: state.stateData == States.loading,
                      text: "التالي",
                      onPressed: () {
                        final isValid = _formKey.currentState!.validate();

                        initialCity =
                            ref.read(selectedCityProvider.notifier).state!;
                        print(initialCity.name);
                        if (isValid) {
                          final custemor = Customer(
                            email: email.text,
                            name: name.text,
                            phone: phone.text,
                            address: initialCity.name,
                            bookingId: widget.idBooking,
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
    );
  }
}
