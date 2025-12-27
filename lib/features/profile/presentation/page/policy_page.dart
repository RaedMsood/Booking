import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';

/// صفحة سياسة الخصوصية لتطبيق مزاجي
///
/// ملاحظة: تم كتابة المحتوى بالعربية مباشرةً لتجنب كسر مفاتيح الترجمة الحالية.
class PolicyPage extends StatelessWidget {
  const PolicyPage({super.key});

  static const String supportEmail = 'support@mazaji.app';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).privacyPolicyTitle),
      body: const PolicyBodyWidget(),
    );
  }
}

class PolicyBodyWidget extends StatelessWidget {
  const PolicyBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PolicyIntroCardWidget(),
            const SizedBox(height: 12),
            PolicySectionWidget(
              title: s.privacyPolicySection1Title,
              children: [
                PolicySubTitleWidget(s.privacyPolicySection1aTitle),
                PolicyBulletWidget(s.privacyPolicySection1aItem1),
                PolicyBulletWidget(s.privacyPolicySection1aItem2),
                PolicyBulletWidget(s.privacyPolicySection1aItem3),
                PolicyBulletWidget(s.privacyPolicySection1aItem4),
                PolicyBulletWidget(s.privacyPolicySection1aItem5),
                PolicyBulletWidget(s.privacyPolicySection1aItem6),
                PolicySubTitleWidget(s.privacyPolicySection1bTitle),
                PolicyBulletWidget(s.privacyPolicySection1bItem1),
                PolicyBulletWidget(s.privacyPolicySection1bItem2),
                PolicyBulletWidget(s.privacyPolicySection1bItem3),
                PolicyBulletWidget(s.privacyPolicySection1bItem4),
                PolicySubTitleWidget(s.privacyPolicySection1cTitle),
                PolicyBulletWidget(s.privacyPolicySection1cItem1),
                PolicyBulletWidget(s.privacyPolicySection1cItem2),
                PolicyBulletWidget(s.privacyPolicySection1cItem3),
                PolicyBulletWidget(s.privacyPolicySection1cItem4),
              ],
            ),
            const SizedBox(height: 10),
            PolicySectionWidget(
              title: s.privacyPolicySection2Title,
              children: [
                PolicyBulletWidget(s.privacyPolicySection2Item1),
                PolicyBulletWidget(s.privacyPolicySection2Item2),
                PolicyBulletWidget(s.privacyPolicySection2Item3),
                PolicyBulletWidget(s.privacyPolicySection2Item4),
                PolicyBulletWidget(s.privacyPolicySection2Item5),
              ],
            ),
            const SizedBox(height: 10),
            PolicySectionWidget(
              title: s.privacyPolicySection3Title,
              children: [
                PolicyBodyTextWidget(s.privacyPolicySection3Note1),
                PolicyBodyTextWidget(s.privacyPolicySection3Note2),
                PolicyBulletWidget(s.privacyPolicySection3Item1),
                PolicyBulletWidget(s.privacyPolicySection3Item2),
                PolicyBulletWidget(s.privacyPolicySection3Item3),
              ],
            ),
            const SizedBox(height: 10),
            PolicySectionWidget(
              title: s.privacyPolicySection4Title,
              children: [
                PolicyBodyTextWidget(s.privacyPolicySection4Note1),
                PolicyBulletWidget(s.privacyPolicySection4Item1),
                PolicyBulletWidget(s.privacyPolicySection4Item2),
                PolicyBulletWidget(s.privacyPolicySection4Item3),
                PolicyBodyTextWidget(s.privacyPolicySection4Note2),
              ],
            ),
            const SizedBox(height: 10),
            PolicySectionWidget(
              title: s.privacyPolicySection5Title,
              children: [
                PolicyBulletWidget(s.privacyPolicySection5Item1),
                PolicyBulletWidget(s.privacyPolicySection5Item2),
                PolicyBulletWidget(s.privacyPolicySection5Item3),
              ],
            ),
            const SizedBox(height: 10),
            PolicySectionWidget(
              title: s.privacyPolicySection6Title,
              children: [
                PolicyBulletWidget(s.privacyPolicySection6Item1),
                PolicyBulletWidget(s.privacyPolicySection6Item2),
                PolicyBulletWidget(s.privacyPolicySection6Item3),
              ],
            ),
            const SizedBox(height: 10),
            PolicySectionWidget(
              title: s.privacyPolicySection7Title,
              children: [
                PolicyBodyTextWidget(s.privacyPolicySection7Note),
                PolicyBulletWidget(s.privacyPolicySection7Item1),
                PolicyBulletWidget(s.privacyPolicySection7Item2),
                PolicyBulletWidget(s.privacyPolicySection7Item3),
                PolicyBulletWidget(s.privacyPolicySection7Item4),
                PolicyBodyTextWidget(s.privacyPolicySection7Footer),
              ],
            ),
            const SizedBox(height: 10),
            PolicySectionWidget(
              title: s.privacyPolicySection8Title,
              children: [
                PolicyBodyTextWidget(s.privacyPolicySection8Note1),
                PolicyBodyTextWidget(s.privacyPolicySection8Note2),
              ],
            ),
            const SizedBox(height: 10),
            const PolicyContactSectionWidget(),
            const SizedBox(height: 10),
            const PolicyFooterNoteWidget(),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class PolicyIntroCardWidget extends StatelessWidget {
  const PolicyIntroCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: s.privacyPolicyHeaderTitle,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            colorText: const Color(0xff001A33),
            maxLines: 2,
          ),
          SizedBox(height: 10.h),
          AutoSizeTextWidget(
            text: s.privacyPolicyIntro,
            fontSize: 11.2.sp,
            fontWeight: FontWeight.w300,
            colorText: const Color(0xff292D32),
            maxLines: 12,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16.sp,
                color: AppColors.greySwatch.shade600,
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: AutoSizeTextWidget(
                  text: s.privacyPolicyConsentNote,
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w300,
                  colorText: AppColors.greySwatch.shade700,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PolicySectionWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const PolicySectionWidget({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: title,
            fontSize: 12.8.sp,
            fontWeight: FontWeight.w600,
            colorText: const Color(0xff001A33),
            maxLines: 2,
          ),
          SizedBox(height: 10.h),
          ...children.map(
            (w) => Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: w,
            ),
          ),
        ],
      ),
    );
  }
}

class PolicyContactSectionWidget extends StatelessWidget {
  const PolicyContactSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return PolicySectionWidget(
      title: s.privacyPolicySection9Title,
      children: [
        PolicyBodyTextWidget(s.privacyPolicySection9Note),
        SizedBox(height: 8.h),
        PolicyCopyTileWidget(
          label: s.privacyPolicyEmailLabel,
          value: PolicyPage.supportEmail,
        ),
      ],
    );
  }
}

class PolicyCopyTileWidget extends StatelessWidget {
  final String label;
  final String value;

  const PolicyCopyTileWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: value));
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(s.copiedToClipboard)),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.scaffoldColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
        ),
        child: Row(
          children: [
            Container(
              height: 34.h,
              width: 34.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.email_outlined,
                color: AppColors.primaryColor,
                size: 18.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeTextWidget(
                    text: label,
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w400,
                    colorText: AppColors.greySwatch.shade700,
                    maxLines: 1,
                  ),
                  SizedBox(height: 2.h),
                  AutoSizeTextWidget(
                    text: value,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    colorText: const Color(0xff001A33),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.copy,
              size: 18.sp,
              color: AppColors.greySwatch.shade700,
            ),
          ],
        ),
      ),
    );
  }
}

class PolicyFooterNoteWidget extends StatelessWidget {
  const PolicyFooterNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: AutoSizeTextWidget(
        text: S.of(context).privacyPolicyFooterNote,
        fontSize: 10.2.sp,
        fontWeight: FontWeight.w300,
        colorText: AppColors.greySwatch.shade700,
        maxLines: 4,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class PolicySubTitleWidget extends StatelessWidget {
  final String text;

  const PolicySubTitleWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return AutoSizeTextWidget(
      text: text,
      fontSize: 11.6.sp,
      fontWeight: FontWeight.w600,
      colorText: const Color(0xff001A33),
      maxLines: 2,
    );
  }
}

class PolicyBodyTextWidget extends StatelessWidget {
  final String text;

  const PolicyBodyTextWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return AutoSizeTextWidget(
      text: text,
      fontSize: 11.2.sp,
      fontWeight: FontWeight.w300,
      colorText: const Color(0xff292D32),
      maxLines: 10,
    );
  }
}

class PolicyBulletWidget extends StatelessWidget {
  final String text;

  const PolicyBulletWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 4.h),
          height: 6.h,
          width: 6.h,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: AutoSizeTextWidget(
            text: text,
            fontSize: 11.2.sp,
            fontWeight: FontWeight.w300,
            colorText: const Color(0xff292D32),
            maxLines: 10,
          ),
        ),
      ],
    );
  }
}

