import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
import '../widgets/app_bar_top_trends_widget.dart';
import '../widgets/pictures_of_property_details_widget.dart';

class PropertyDetailsPage extends StatefulWidget {
  const PropertyDetailsPage({super.key});

  @override
  State<PropertyDetailsPage> createState() => _PropertyDetailsPageState();
}

class _PropertyDetailsPageState extends State<PropertyDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  Color appBarBackgroundColor = AppColors.transparent;

  // late AnimationController _animationController;
  //  Animation<double>? _textOffsetAnimation; // حركة النص من اليمين إلى اليسار
  // Animation<double>?
  //     _containerOffsetAnimation; // حركة الكونتينر من اليسار إلى اليمين
  // Animation<double>? _containerWidthAnimation; // توسيع عرض الكونتينر
  // bool showText = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > kToolbarHeight + 40.h) {
      if (appBarBackgroundColor == AppColors.transparent) {
        setState(() {
          appBarBackgroundColor = AppColors.primarySwatch.shade900;
        });
      }
    } else {
      if (appBarBackgroundColor == AppColors.primarySwatch.shade900) {
        setState(() {
          appBarBackgroundColor = AppColors.transparent;
        });
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
      extendBodyBehindAppBar: true,
      appBar: AppBarTopTrendsWidget(
        backgroundColor: appBarBackgroundColor,
        // textOffsetAnimation: _textOffsetAnimation,
        // // تمرير حركة النص
        // containerOffsetAnimation: _containerOffsetAnimation,
        // // تمرير حركة الكونتينر
        // containerWidthAnimation: _containerWidthAnimation,
        // // تمرير توسيع الكونتينر
        // showText: showText,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const PicturesOfPropertyDetailsWidget(),

            Container(
              color: Colors.red,
              width: 100,
              height: 1000,
            ),
          ],
        ),
      ),
    );
  }
}
