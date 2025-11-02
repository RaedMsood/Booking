import 'package:booking/core/widgets/secondary_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../riverpod/unit_riverpod.dart';
import '../widgets/list_of_units_widget.dart';

class UnitsPage extends ConsumerStatefulWidget {
  final int propertyId;
  final String nameProp;
  final String location;
  final String image;

  const UnitsPage(
      {super.key,
      required this.propertyId,
      required this.location,
      required this.nameProp,
      required this.image});

  @override
  ConsumerState<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends ConsumerState<UnitsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // ============ Pagination ============
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final state = ref.read(getAllUnitsProvider(1));
      if (state.stateData != States.loadingMore) {
        ref
            .read(getAllUnitsProvider(widget.propertyId).notifier)
            .getData(moreData: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondaryAppBarWidget(title: ""),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 14.w).copyWith(top: 6.h),
              child: AutoSizeTextWidget(
                text: "${S.of(context).roomsFor} ${widget.nameProp}",
                fontSize: 13.6.sp,
                fontWeight: FontWeight.w500,
                maxLines: 2,
                minFontSize: 12,
              ),
            ),
            8.h.verticalSpace,
            ListOfUnitsWidget(
              scrollController: _scrollController,
              propertyId: widget.propertyId,
              image: widget.image,
              location: widget.location,
              nameProp: widget.nameProp,
            ),
          ],
        ),
      ),
    );
  }
}
