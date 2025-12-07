import 'package:booking/features/my_bookings/presentation/widgets/shimmer_booking_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../pages/my_booking_details_page.dart';
import 'my_booking_card_widget.dart';
import '../riverpod/my_bookings_riverpod.dart';

class ListOfTypeAllMyBookingsWidget extends ConsumerStatefulWidget {
  const ListOfTypeAllMyBookingsWidget({super.key, required this.statusId});

  final int statusId;

  @override
  ConsumerState<ListOfTypeAllMyBookingsWidget> createState() =>
      _ListOfTypeAllMyBookingsWidgetState();
}

class _ListOfTypeAllMyBookingsWidgetState
    extends ConsumerState<ListOfTypeAllMyBookingsWidget> {
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
      widgetOfLoading: const ShimmerBookingCardWidget(),
      refresh: () {
        ref
            .read(getBookingProvider(widget.statusId).notifier)
            .getDataBookingType();
      },
      widgetOfData: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.only(bottom: 14.h),
        itemBuilder: (context, index) => MyBookingCardWidget(
          bookData: bookingTypeState.data.data[index],
          onTap: () {
            print(bookingTypeState.data.data[index].id);
            navigateTo(
              context,
              MyBookingDetailsPage(
                bookingId: bookingTypeState.data.data[index].id!,
                isCompletedBook: widget.statusId == 2 ||
                    bookingTypeState.data.data[index].status == "منتهيه",
              ),
            );
          },
        ),
        itemCount: bookingTypeState.data.data.length,
      ),
    );
  }
}
