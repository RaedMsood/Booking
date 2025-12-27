import 'package:booking/core/constants/app_images.dart';
import 'package:booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../widget/social_button_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _openUrl(String url) async {
    final success = await launchUrlString(
      url,
      mode: LaunchMode.externalApplication,
    );

    if (!success) {
      debugPrint('Could not launch $url');
    }
  }

  void _openFacebook() {
    _openUrl(
        'https://www.facebook.com/profile.php?id=61584304702177&mibextid=ZbWKwL');
  }

  void _openInstagram() {
    _openUrl('https://www.instagram.com/algonest.ye?igsh=MWwxbm5lbnFrNXZwdg==');
  }

  void _openTwitter() {
    _openUrl('https://x.com/your_page_here');
  }

  void _openWhatsApp() {
    _openUrl('https://wa.me/967785050302');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).aboutApp),
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
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,

                        image: DecorationImage(
                          image: AssetImage(
                            AppImages.logo,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16.w),
                      child: AutoSizeTextWidget(
                        text:S.of(context).aboutMazaji,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                        colorText: const Color(0xff292D32),
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
                    onTap: _openWhatsApp,
                  ),
                  SocialButtonWidget(
                    icon: SvgPicture.asset(
                      AppIcons.instagram,
                    ),
                    onTap: _openInstagram,
                  ),
                  SocialButtonWidget(
                    icon: SvgPicture.asset(
                      AppIcons.twitter,
                    ),
                    onTap: _openTwitter,
                  ),
                  SocialButtonWidget(
                    icon: SvgPicture.asset(
                      AppIcons.facebook,
                    ),
                    onTap: _openFacebook,
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
