import 'package:booking/core/widgets/auto_size_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/app_bar_home_widget.dart';
import '../widgets/real_estate_list_widget.dart';
import '../widgets/realty_card_widget.dart';
import '../widgets/search_and_filter_design_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHomeWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          8.h.verticalSpace,
          SearchAndFilterDesignWidget(),
           RealEstateListWidget()
          // RealtyCardWidget()
          // AutoSizeTextWidget(text: "وجهتك الفندقية"),
          // SingleChildScrollView(
          //   padding: EdgeInsets.all(14.sp),
          //   child: Column(
          //     children: [
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
