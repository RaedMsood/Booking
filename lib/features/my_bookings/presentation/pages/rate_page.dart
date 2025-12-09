import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../../../booking/presentation/riverpod/booking_riverpod.dart';
import '../../data/model/rate_model.dart';
import '../widgets/rating_row_widget.dart';
import '../riverpod/my_bookings_riverpod.dart';

class AddYourRatingSection extends ConsumerStatefulWidget {
  const AddYourRatingSection({
    super.key,
    required this.rateData,
    required this.propertyId,
    required this.bookingId,
  });

  final int propertyId;
  final int bookingId;
  final List<RateModel> rateData;

  @override
  ConsumerState<AddYourRatingSection> createState() =>
      _AddYourRatingSectionState();
}

class _AddYourRatingSectionState extends ConsumerState<AddYourRatingSection> {
  @override
  Widget build(BuildContext context) {
    final rateState = ref.watch(ratePropertyProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text: S.of(context).addYourRating,
                fontSize: 12.sp,
              ),
              SizedBox(height: 18.h),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 8.0.h),
                  child: RatingRowWidget(
                    title: widget.rateData[index].nameOfRate ?? '',
                    value: widget.rateData[index].numberOfRate ?? 0,
                    onChanged: (v) =>
                        setState(() => widget.rateData[index].numberOfRate = v),
                  ),
                ),
                itemCount: widget.rateData.length,
              ),
              SizedBox(height: 8.h),
              CheckStateInPostApiDataWidget(
                state: rateState,
                functionSuccess: () {
                  ref
                      .read(getIfPropertyRatedProvider(
                        Tuple2(widget.propertyId, widget.bookingId),
                      ).notifier)
                      .setIfPropertyRatedNumber(true);
                  ref.read(getBookingProvider(2).notifier).getDataBookingType();
                },
                bottonWidget: DefaultButtonWidget(
                  text: S.of(context).send,
                  isLoading: rateState.stateData == States.loading,
                  textColor: AppColors.primaryColor,
                  background: const Color(0xffDCE6FF),
                  onPressed: () {
                    ref.read(ratePropertyProvider.notifier).rateProperty(
                        idBooking: widget.bookingId,
                        rate: widget.rateData,
                        idProperty: widget.propertyId);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
