import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../widget/list_of_type_booking_widget.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final List<String> _tabs = ['الكل', 'الحالية', 'مكتملة', 'ملغية'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this)
      ..addListener(() {
        if (_tabController.index != _tabController.previousIndex) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeTextWidget(
          text: "الحجوزات",
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            dividerHeight: 0,
            labelColor: Colors.black,
            unselectedLabelColor: Color(0xff605A65),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            tabs: List.generate(
              _tabs.length,
              (index) => _buildTab(_tabs[index], index),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              children: List.generate(
                _tabs.length,
                (i) => ListOfTypeAllBookingWidget(statusId: i),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    bool isSelected = _tabController.index == index;

    return Tab(
      child: Container(
        height: 30.h,
        width: 70.w,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.05)
              : Colors.white,
          // نصف القطر يختلف بين المختار وغير المختار
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color:
                isSelected ? AppColors.primaryColor : const Color(0xFFE0E0E0),
            width: 0.5,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? AppColors.primaryColor
                  : Color(
                      0xff605A65),
            ),
          ),
        ),
      ),
    );
  }
}
