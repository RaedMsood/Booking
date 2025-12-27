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

  final List<String> _tabs = [
    S.current.all,
    'قيد المراجعة',
    S.current.currentFilter,
    S.current.completedFilter,
    S.current.canceledFilter,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this)
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
          text: S.of(context).reservationsTitle,
          fontWeight: FontWeight.w500,
        ),
        actions: const [NotificationsButtonWidget()],
      ),
      body: Visibility(
        visible: Auth().loggedIn,
        replacement: const GoToLoginWidget(),
        child: Column(
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
              tabs: [
                for (int i = 0; i < _tabs.length; i++)
                  AnimatedBuilder(
                    animation: _tabController.animation!,
                    builder: (context, _) {
                      final value = _tabController.animation?.value ??
                          _tabController.index.toDouble();
                      final selectness =
                          (1.0 - (value - i).abs()).clamp(0.0, 1.0);
                      final bgColor = Color.lerp(
                          Colors.white,
                          AppColors.primaryColor.withValues(alpha: 0.05),
                          selectness)!;
                      final borderColor = Color.lerp(const Color(0xFFE0E0E0),
                          AppColors.primaryColor, selectness)!;
                      final textColor = Color.lerp(const Color(0xff605A65),
                          AppColors.primaryColor, selectness)!;

                      return Container(
                        height: 30.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(25.r),
                          border: Border.all(
                            color: borderColor,
                            width: 0.5.w,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _tabs[i],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'ReadexPro',
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: textColor,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: List.generate(
                  _tabs.length,
                  (i) => ListOfTypeAllMyBookingsWidget(statusId: i),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
