import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/go_to_login_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../../../notifications/presentation/widget/notifications_button_widget.dart';
import '../widgets/list_of_type_all_my_bookings_widget.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({super.key});

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  List<String> _tabs(BuildContext context) => [
        S.of(context).all,
        S.of(context).currentFilter,
        S.of(context).completedFilter,
        S.of(context).canceledFilter,
      ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this)
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
    return Visibility(
      visible: Auth().loggedIn,
      replacement: const GoToLoginWidget(),
      child: Scaffold(
        appBar: AppBar(
          title: AutoSizeTextWidget(
            text: S.of(context).reservationsTitle,
            fontWeight: FontWeight.w500,
          ),
          actions: const [NotificationsButtonWidget()],
        ),
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              dividerHeight: 0,
              labelColor: Colors.black,
              unselectedLabelColor: const Color(0xff605A65),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              labelPadding: EdgeInsets.symmetric(horizontal: 9.6.w),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              tabs: List.generate(
                _tabs(context).length,
                (index) => _buildTab(_tabs(context)[index], index),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                  _tabs(context).length,
                  (i) => ListOfTypeAllMyBookingsWidget(statusId: i),
                ),
              ),
            ),
          ],
        ),
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
              color:
                  isSelected ? AppColors.primaryColor : const Color(0xff605A65),
            ),
          ),
        ),
      ),
    );
  }
}
