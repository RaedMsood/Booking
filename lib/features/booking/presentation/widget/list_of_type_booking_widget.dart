import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../page/details_info_booking_page.dart';
import '../riverpod/booking_riverpod.dart';
import 'booking_card_widget.dart';

class ListOfTypeAllBookingWidget extends ConsumerStatefulWidget {
  const ListOfTypeAllBookingWidget({super.key, required this.statusId});

  final int statusId;

  @override
  ConsumerState<ListOfTypeAllBookingWidget> createState() =>
      _ListOfTypeBookingWidgetState();
}

class _ListOfTypeBookingWidgetState
    extends ConsumerState<ListOfTypeAllBookingWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(getBookingProvider(widget.statusId).notifier).getDataBookingType(
            moreData: true,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingTypeState = ref.watch(getBookingProvider(widget.statusId));
    return CheckStateInGetApiDataWidget(
      state: bookingTypeState,
      widgetOfData: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) => BookingCard(
          bookData: bookingTypeState.data.data[index],
          onTap: () {
            navigateTo(
              context,
              BookingDetailPage(
                bookData: bookingTypeState.data.data[index],
              ),
            );
          },
        ),
        itemCount: bookingTypeState.data.data.length,
      ),
    );
  }
}
