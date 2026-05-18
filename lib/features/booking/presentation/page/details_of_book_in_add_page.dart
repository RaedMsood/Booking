import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/flash_bar_helper.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../offers/data/model/offer_pricing_model.dart';
import '../../../properties/home/presentation/widgets/property_offer_banner_widget.dart';
import '../../data/booking_model/booking_data.dart';
import '../riverpod/booking_riverpod.dart';
import '../widget/desgin_button_in_add_booking_widget.dart';
import '../widget/hotel_summary_card_widget.dart';
import '../widget/range_calender_widget.dart';
import '../widget/select_booking_details_widget.dart';
import 'complete_add_booking_page.dart';

class DetailsOfBookInAddPage extends ConsumerStatefulWidget {
  final String nameProp;
  final String location;
  final String image;
  final int unitId;
  final String totalPrice;
  final String price;
  final bool hasDiscount;
  final OfferPricingModel? offerPricing;

  const DetailsOfBookInAddPage({
    required this.image,
    required this.nameProp,
    required this.location,
    required this.unitId,
    required this.totalPrice,
    required this.price,
    required this.hasDiscount,
    required this.offerPricing,
    super.key,
  });

  @override
  ConsumerState<DetailsOfBookInAddPage> createState() =>
      _DetailsOfBookInAddPageState();
}

class _DetailsOfBookInAddPageState
    extends ConsumerState<DetailsOfBookInAddPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _bookingDetailsKey = GlobalKey();

  DateTime? startDate;
  DateTime? endDate;
  String typeBook = S.current.purposeLeisure;
  int rooms = 0, adults = 0, children = 0;

  Future<void> _scrollToBookingDetails() async {
    final targetContext = _bookingDetailsKey.currentContext;
    if (targetContext == null) return;

    await Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      alignment: 0.2,
    );
  }

  Future<void> _validateBookingCounts() async {
    await _scrollToBookingDetails();

    if (!mounted) return;

    if (rooms <= 0) {
      showFlashBarWarring(
        context: context,
        message: S.of(context).validationRoomsRequired,
      );
      return;
    }

    if (adults <= 0) {
      showFlashBarWarring(
        context: context,
        message: S.of(context).validationMinOneAdult,
      );
    }
  }

  DateTime? _parseOfferDate(String value) {
    final raw = value.trim();
    if (raw.isEmpty) return null;

    final direct = DateTime.tryParse(raw);
    if (direct != null) {
      return DateTime(direct.year, direct.month, direct.day);
    }

    for (final pattern in ['yyyy-MM-dd HH:mm:ss', 'yyyy-MM-dd']) {
      try {
        final parsed = DateFormat(pattern, 'en_US').parseStrict(raw);
        return DateTime(parsed.year, parsed.month, parsed.day);
      } catch (_) {}
    }

    return null;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var checkBookingState = ref.watch(checkBookingProvider);
    final currentOffer = widget.offerPricing?.offer;
    final hasActiveOffer = widget.offerPricing?.hasActiveOffer ?? false;
    final offerStartDate = _parseOfferDate(widget.offerPricing?.startsAt ?? '');
    final offerEndDate = _parseOfferDate(widget.offerPricing?.endsAt ?? '');
    final bookingOfferText = (currentOffer?.giftDescription?.trim().isNotEmpty ?? false)
        ? currentOffer!.giftDescription!.trim()
        : ((currentOffer?.title.trim().isNotEmpty ?? false)
            ? currentOffer!.title.trim()
            : '');

    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).hotelBookingTitle),
      body: SafeArea(
        top: false,

        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    6.h.verticalSpace,
                    HotelSummaryCard(
                      name: widget.nameProp,
                      location: widget.location,
                      imageUrl: widget.image,
                    ),
                    if (hasActiveOffer && bookingOfferText.trim().isNotEmpty)
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                        child: PropertyOfferBannerWidget(
                          text: bookingOfferText,
                        ),
                      ),
                    RangeCalendarWidget(
                      offerStartDate: offerStartDate,
                      offerEndDate: offerEndDate,
                      onRangeSelected: (start, end) {
                        setState(() {
                          startDate = start;
                          endDate = end;
                        });
                      },
                    ),
                    KeyedSubtree(
                      key: _bookingDetailsKey,
                      child: SelectBookingDetailsWidget(countAdult: (adult) {
                        adults = adult!;
                      }, countChild: (child) {
                        children = child!;
                      }, countRoom: (room) {
                        rooms = room!;
                      }, onTypeSelected: (type) {
                        typeBook = type!;
                      }),
                    ),
                  ],
                ),
              ),
            ),
            CheckStateInPostApiDataWidget(
              hasMessageSuccess: false,
              state: checkBookingState,
              functionSuccess: () {
                navigateTo(
                    context,
                    CompleteAddBookingPage(
                      nameProp: widget.nameProp,
                      location: widget.location,
                      imageUrl: widget.image,
                      booking: checkBookingState.data,
                    ));
              },
              bottonWidget: DesginButtonInAddBookingWidget(
                button: DefaultButtonWidget(
                    text: S.of(context).next,
                    height: 42.h,
                    width: double.infinity,
                    borderRadius: 15.r,
                    isLoading: checkBookingState.stateData == States.loading,
                    onPressed: () {
                      if (startDate == null || endDate == null) {
                        showFlashBarWarring(
                            context: context,
                            message: S.of(context).validationSelectDate);
                      } else if (rooms <= 0 || adults <= 0) {
                        _validateBookingCounts();
                      } else {
                        final bookingData = BookingData(
                          checkIn: DateFormat('yyyy-MM-dd', 'en_US')
                              .format(startDate!)
                              .toString(),
                          checkOut: DateFormat('yyyy-MM-dd', 'en_US')
                              .format(endDate!)
                              .toString(),
                          type: typeBook,
                          unitCount: rooms,
                          childCount: children,
                          adultCount: adults,
                          guests: children+adults,
                          totalPrice: widget.totalPrice,
                          price: widget.price,
                          hasDiscount: widget.hasDiscount,
                          offerPricing: widget.offerPricing,
                          unitId: widget.unitId,
                        );
                        ref
                            .read(checkBookingProvider.notifier)
                            .checkBookingInHotel(bookingData: bookingData);
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
