import 'package:booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../widgets/app_bar_home_widget.dart';
import '../widgets/offers_widget.dart';
import '../widgets/real_estate_list_widget.dart';
import '../widgets/search_and_filter_design_widget.dart';

class HomePage extends StatefulWidget {
  static final ValueNotifier<bool> showSearchIconStatic = ValueNotifier(false);

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  final GlobalKey _searchKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    final context = _searchKey.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;

    final position = box.localToGlobal(Offset.zero).dy;
    final height = box.size.height;
    final bottom = position + height;

    final double screenTopVisibleArea =
        MediaQuery.of(context).padding.top + kToolbarHeight;

    final double margin = 22.h;
    final bool shouldShow = bottom <= screenTopVisibleArea + margin;

    if (HomePage.showSearchIconStatic.value != shouldShow) {
      HomePage.showSearchIconStatic.value = shouldShow;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    HomePage.showSearchIconStatic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarHomeWidget(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchAndFilterDesignWidget(key: _searchKey),
            14.h.verticalSpace,
            OffersWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    height: 7.h,
                    width: 120.w,
                    margin: EdgeInsets.only(top: 10.h, right: 4.w),
                    decoration: BoxDecoration(
                        color: AppColors.primarySwatch.shade100,
                        borderRadius: BorderRadius.circular(8.r)),
                  ),
                  AutoSizeTextWidget(
                    text: " وجهتك الفندقية",
                    fontSize: 13.sp,
                    colorText: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            6.h.verticalSpace,
            RealEstateListWidget(),
          ],
        ),
      ),
    );
  }
}


