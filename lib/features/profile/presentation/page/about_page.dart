import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../widget/social_button_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: AutoSizeTextWidget(
          text: 'عن التطبيق',
          fontSize: 14.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Container(
                      height: 160.h,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16.w),
                      child: AutoSizeTextWidget(
                        text:
                        'تطبيق نُزِل هو تطبيق يمني مخصص لحجز الفنادق والشقق المفروشة، ويُعد من أبرز التطبيقات المحلية في هذا المجال، حيث يجمع بين سهولة الاستخدام وتنوع الخيارات مع تركيز خاص على السوق اليمني والخليجي.',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                        colorText: Color(0xff292D32),
                        maxLines: 10,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: [
                  SocialButtonWidget(
                    icon: SvgPicture.asset(
                      AppIcons.whatsapp,
                    ),
                    onTap: () {
                      // TODO: افتح رابط واتساب
                    },
                  ),
                  SocialButtonWidget(
                    icon: SvgPicture.asset(
                      AppIcons.instagram,
                    ),
                    onTap: () {
                      // TODO: افتح رابط تيليجرام
                    },
                  ),
                  SocialButtonWidget(
                    icon: SvgPicture.asset(
                      AppIcons.twitter,
                    ),
                    onTap: () {
                      // TODO: افتح رابط إنستغرام
                    },
                  ),
                  SocialButtonWidget(
                    icon: SvgPicture.asset(
                      AppIcons.facebook,
                    ),
                    onTap: () {
                      // TODO: افتح رابط فيسبوك
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
