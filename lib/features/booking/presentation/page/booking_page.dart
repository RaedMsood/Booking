import 'package:booking/core/helpers/navigateTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../widget/list_of_type_booking_widget.dart';

class Booking {
  final String title;
  final String subtitle;
  final String date; // مثال: '12 يوليو 2025'
  final String time; // مثال: '14:00'
  final String status; // مثال: 'مؤكد', 'ملغي'
  final Color statusColor; // AppColors.successSwatch أو AppColors.dangerColor
  final Icon icon; // أيقونة تمثل نوع الجلسة

  const Booking({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.icon,
  });
}

// lib/ui/screens/bookings_page.dart

class BookingPage extends StatefulWidget {
  BookingPage();

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) setState(() {});
    });
    super.initState();
    // TODO: implement initState
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
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              TabBar(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  tabAlignment: TabAlignment.center,
                  dividerHeight: 0,
                  labelColor: Colors.black,
                  unselectedLabelColor: Color(0xff605A65),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tabs: [
                    _buildTab('الكل', 0),
                    _buildTab('الحالية', 1),
                    _buildTab('مكتملة', 2),
                    _buildTab('ملغية', 3),
                  ],
                  onTap: (index) {
                    tabController.index = index;
                  }),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children:const [
                    ListOfTypeAllBookingWidget(statusId: 0,),
                    ListOfTypeAllBookingWidget(statusId: 1,),
                    ListOfTypeAllBookingWidget(statusId: 2,),
                    ListOfTypeAllBookingWidget(statusId: 3,),

                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildTab(String label, int index) {
    bool isSelected =
        tabController.index == index; // تحقق مما إذا كان التاب مفعلًا

    return Tab(
      child: Container(
        height: 30.h,
        padding: EdgeInsets.symmetric(horizontal: 17.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color:
                  isSelected == true ? AppColors.primaryColor : Colors.white),
          borderRadius:
              BorderRadius.circular(25.r), // إضافة زاوية دائرية للمستطيل
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
                      0xff605A65), // النص داخل التاب المفعل أبيض وغير المفعل أسود
            ),
          ),
        ),
      ),
    );
  }
}
