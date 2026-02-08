import 'package:booking/core/theme/app_colors.dart';
import 'package:booking/features/my_bookings/presentation/widgets/shimmer_booking_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../pages/my_booking_details_page.dart';
import '../riverpod/my_bookings_riverpod.dart';
import 'my_booking_card_widget.dart';

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
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await ref
        .read(getBookingProvider(widget.statusId).notifier)
        .getDataBookingType();
  }

  Future<void> _loadMoreIfNeeded() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    try {
      await ref
          .read(getBookingProvider(widget.statusId).notifier)
          .getDataBookingType(moreData: true);
    } finally {
      _isLoadingMore = false;
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final reachedBottom = _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 24;

    if (reachedBottom) {
      _loadMoreIfNeeded();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookingTypeState = ref.watch(getBookingProvider(widget.statusId));

    final bookings = bookingTypeState.data.data;
    final isEmpty = bookings.isEmpty;

    return CheckStateInGetApiDataWidget(
      state: bookingTypeState,
      widgetOfLoading: const ShimmerBookingCardWidget(),
      refresh: () {
        ref
            .read(getBookingProvider(widget.statusId).notifier)
            .getDataBookingType();
      },
      widgetOfData: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.primaryColor,
        child: isEmpty
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 14.h),
                children: [
                  SizedBox(height: 120.h),
                  Center(
                    child: Text(
                      'لا توجد حجوزات حالياً',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Center(
                    child: Text(
                      'اسحب للأسفل للتحديث',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              )
            : ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 14.h),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return MyBookingCardWidget(
                    bookData: booking,
                    onTap: () {
                      navigateTo(
                        context,
                        MyBookingDetailsPage(
                          bookingId: booking.id!,
                          isCompletedBook:
                              widget.statusId == 3 || booking.status == "مكتملة",
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
