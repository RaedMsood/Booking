import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  Future<void> _openUri(Uri uri) async {
    final success = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!success) {
      debugPrint('Could not launch $uri');
    }
  }

  Future<void> _openEmail(String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await _openUri(uri);
  }

  Future<void> _callPhone(String phoneNumber) async {
    final sanitized = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri(
      scheme: 'tel',
      path: sanitized,
    );
    await _openUri(uri);
  }

  Future<void> _openWhatsApp(String phoneWithCountryCode) async {
    final sanitized = phoneWithCountryCode.replaceAll(RegExp(r'[^0-9]'), '');
    final uri = Uri.parse('https://wa.me/$sanitized');
    await _openUri(uri);
  }

  @override
  Widget build(BuildContext context) {
    const email = 'support@algo-nest.com';
    const phone = '785050302';
    const whatsapp = '775076388';

    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).contactUs),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                leading: SvgPicture.asset(AppIcons.email),
                title: AutoSizeTextWidget(
                  text: email,
                  colorText: const Color(0xff001A33),
                  fontSize: 11.sp,
                ),
                trailing: SvgPicture.asset(AppIcons.arrowLeft),
                onTap: () => _openEmail(email),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                leading: SvgPicture.asset(AppIcons.phone),
                title: AutoSizeTextWidget(
                  text: phone,
                  colorText: const Color(0xff001A33),
                  fontSize: 11.sp,
                ),
                trailing: SvgPicture.asset(AppIcons.arrowLeft),
                onTap: () => _callPhone(phone),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                leading: SvgPicture.asset(AppIcons.whatsapp),
                title: AutoSizeTextWidget(
                  text: whatsapp,
                  colorText: const Color(0xff001A33),
                  fontSize: 11.sp,
                ),
                trailing: SvgPicture.asset(AppIcons.arrowLeft),
                onTap: () => _openWhatsApp('967$whatsapp'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
