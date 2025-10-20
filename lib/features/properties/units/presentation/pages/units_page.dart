import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
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
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        toolbarHeight: 56.h,
        leadingWidth: 65.2.w,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.5.h),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20.r,
            child: const IconButtonWidget(
              icon: AppIcons.arrowBack,
              iconColor: AppColors.fontColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 14.w).copyWith(top: 6.h),
              child: AutoSizeTextWidget(
                text: "الغرف الخاصة بفندق أم القرى السياحي",
                fontSize: 13.6.sp,
                fontWeight: FontWeight.w500,
                maxLines: 2,
                minFontSize: 12,
              ),
            ),
            12.h.verticalSpace,
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
