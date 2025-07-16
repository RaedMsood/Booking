import 'package:booking/core/helpers/navigateTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../widget/booking_card_widget.dart';
import 'details_info_booking_page.dart';
import 'details_of_book_in_add_page.dart';

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
                  children: [
                    ListView.builder(
                      itemBuilder: (context, index) => BookingCard(
                        rating: 4,
                        bookingId: '1-2347373',
                        onCopyBookingId: () {
                          Clipboard.setData(ClipboardData(text: '1-2347373'));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم نسخ رقم الحجز')),
                          );
                        },
                        statusLabel: 'ملغية',
                        statusColor: Color(0xffFFF3CD),
                        title: 'فندق أم القرى السياحي',
                        locationText: 'سعوان , هبرة',
                        count: 2,
                        price: 50000,
                        imageUrl: 'https://your-server.com/images/hotel.jpg',
                        onTap: () {
                          navigateTo(
                            context,
                            BookingDetailPage(
                              hotelName: 'فندق أم القرى السياحي',
                              hotelLocation: 'سعوان , هبرة',
                              hotelImageUrl:
                                  'https://your-server.com/images/umAlQura.jpg',
                              bookingId: '1-2347373',
                              bookingDate: DateTime(2025, 7, 1, 8, 17),
                              bookingStatusLabel: 'ملغية',
                              bookingStatusColor: Colors.red,
                              adults: 4,
                              children: 2,
                              startDate: DateTime(2025, 7, 1),
                              endDate: DateTime(2025, 7, 5),
                              onPolicyTap: () {
                                // افتح تفاصيل سياسة الشراء والإلغاء
                              },
                              onViewFacilityDetails: () {
                                navigateTo(
                                  context,
                                  DetailsOfBookInAddPage(),
                                );
                                // افتح صفحة تفاصيل المنشأة
                              },
                            ),
                          );
                        },
                      ),
                      itemCount: 3,
                    ), // صفحة "من اجلك"
                    Container(color: Colors.blue), // صفحة "مدخلات جديدة"
                    Container(color: Colors.yellow), // صفحة "خصومات"
                    Container(color: Colors.orange), // صفحة "الاكثر مبيعا"
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
