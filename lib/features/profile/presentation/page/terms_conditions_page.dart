import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';

/// صفحة الشروط والأحكام لتطبيق مزاجي
///
/// - الكلاس الرئيسي ينتهي بـ Page.
/// - الكلاسات الفرعية تنتهي بـ Widget.
///
/// ملاحظة: النص عربي مباشر لتجنب تغيير ملفات الترجمة الحالية.
class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).termsTitle),
      body: const TermsConditionsBodyWidget(),
    );
  }
}

class TermsConditionsBodyWidget extends StatelessWidget {
  const TermsConditionsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TermsIntroCardWidget(),
            const SizedBox(height: 12),
            TermsSectionWidget(
              title: s.termsSection1Title,
              children: [
                TermsBulletWidget(s.termsSection1Item1),
                TermsBulletWidget(s.termsSection1Item2),
                TermsBulletWidget(s.termsSection1Item3),
              ],
            ),
            const SizedBox(height: 10),
            TermsSectionWidget(
              title: s.termsSection2Title,
              children: [
                TermsBulletWidget(s.termsSection2Item1),
                TermsBulletWidget(s.termsSection2Item2),
                TermsBulletWidget(s.termsSection2Item3),
              ],
            ),
            const SizedBox(height: 10),
            TermsSectionWidget(
              title: s.termsSection3Title,
              children: [
                TermsBulletWidget(s.termsSection3Item1),
                TermsBulletWidget(s.termsSection3Item2),
                TermsBulletWidget(s.termsSection3Item3),
              ],
            ),
            const SizedBox(height: 10),
            TermsSectionWidget(
              title: s.termsSection4Title,
              children: [
                TermsBulletWidget(s.termsSection4Item1),
                TermsBulletWidget(s.termsSection4Item2),
                TermsBulletWidget(s.termsSection4Item3),
              ],
            ),
            const SizedBox(height: 10),
            TermsSectionWidget(
              title: s.termsSection5Title,
              children: [
                TermsBulletWidget(s.termsSection5Item1),
                TermsBulletWidget(s.termsSection5Item2),
              ],
            ),
            const SizedBox(height: 10),
            TermsSectionWidget(
              title: s.termsSection6Title,
              children: [
                TermsBodyTextWidget(s.termsSection6Note),
              ],
            ),
            const SizedBox(height: 10),
            TermsSectionWidget(
              title: s.termsSection7Title,
              children: [
                TermsBulletWidget(s.termsSection7Item1),
                TermsBulletWidget(s.termsSection7Item2),
                TermsBulletWidget(s.termsSection7Item3),
                TermsBulletWidget(s.termsSection7Item4),
              ],
            ),
            const SizedBox(height: 10),
            TermsSectionWidget(
              title: s.termsSection8Title,
              children: [
                TermsBulletWidget(s.termsSection8Item1),
                TermsBulletWidget(s.termsSection8Item2),
                TermsBulletWidget(s.termsSection8Item3),
              ],
            ),
            const SizedBox(height: 10),
            TermsSectionWidget(
              title: s.termsSection9Title,
              children: [
                TermsBulletWidget(s.termsSection9Item1),
                TermsBulletWidget(s.termsSection9Item2),
                TermsBulletWidget(s.termsSection9Item3),
              ],
            ),
            const SizedBox(height: 10),
            const TermsFooterNoteWidget(),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class TermsIntroCardWidget extends StatelessWidget {
  const TermsIntroCardWidget({super.key});

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
          Row(
            children: [
              Container(
                height: 36.h,
                width: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.gavel_outlined,
                  color: AppColors.primaryColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: AutoSizeTextWidget(
                  text: s.termsTitle,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  colorText: const Color(0xff001A33),
                  maxLines: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          AutoSizeTextWidget(
            text: s.termsIntro,
            fontSize: 11.2.sp,
            fontWeight: FontWeight.w300,
            colorText: const Color(0xff292D32),
            maxLines: 6,
          ),
        ],
      ),
    );
  }
}

class TermsSectionWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const TermsSectionWidget({
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

class TermsBodyTextWidget extends StatelessWidget {
  final String text;

  const TermsBodyTextWidget(this.text, {super.key});

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

class TermsBulletWidget extends StatelessWidget {
  final String text;

  const TermsBulletWidget(this.text, {super.key});

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

class TermsFooterNoteWidget extends StatelessWidget {
  const TermsFooterNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: AutoSizeTextWidget(
        text: S.of(context).termsFooterNote,
        fontSize: 10.2.sp,
        fontWeight: FontWeight.w300,
        colorText: AppColors.greySwatch.shade700,
        maxLines: 4,
        textAlign: TextAlign.center,
      ),
    );
  }
}

