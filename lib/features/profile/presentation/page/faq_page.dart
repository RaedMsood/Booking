import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';

class FAQItem {
  final String question;
  final String answer;
  bool isExpanded;

  FAQItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final List<FAQItem> _faqs = [
    FAQItem(
      question: 'ماهو تطبيق نُزِل؟',
      answer:
          'تطبيق نُزِل هو تطبيق يمني مخصص لحجز الفنادق والشقق المفروشة، ويُعد من أبرز التطبيقات المحلية في هذا المجال، حيث يجمع بين سهولة الاستخدام وتنوع الخيارات مع تركيز خاص على السوق اليمني والخليجي.',
    ),
    FAQItem(
      question: 'هل يمكنني استخدام في أي محافظة؟',
      answer:
          'نعم، يمكنك استخدام التطبيق في أي محافظة مدعومة حاليًا، وسيُعرض لك الخيارات المتاحة في منطقتك.',
    ),
    FAQItem(
      question: 'كيف أضمن خصوصية بياناتي على نُزِل؟',
      answer:
          'نولي في نُزِل أهمية كبرى لخصوصية بيانات المستخدمين، حيث تُخزن جميع المعلومات مشفّرة وتُستخدم فقط لتسهيل تجربة الحجز.',
    ),
    FAQItem(
      question:
          'كيف يمكنني الحصول على الدعم الفني إذا واجهتني مشكلة في التطبيق؟',
      answer:
          'يمكنك التواصل مع فريق الدعم الفني عبر صفحة "اتصل بنا" في التطبيق أو عبر رقم الواتساب الظاهر في الأسفل.',
    ),
    FAQItem(
      question: 'كيف يمكنني تقديم شكوى عن التطبيق؟',
      answer:
          'يمكنك تقديم شكوى من خلال نموذج الشكاوى المتواجد في قسم "الدعم" داخل التطبيق، وسيتم متابعتها في أسرع وقت.',
    ),
    FAQItem(
      question: 'كيف يمكنني تعديل الطلب؟',
      answer:
          'لتعديل طلبك، انتقل إلى صفحة الحجوزات الخاصة بك واختر الحجز المراد تعديله ثم اضغط على "تعديل".',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).faq),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        child: Column(
          children: [
            for (int i = 0; i < _faqs.length; i++) ...[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _faqs[i].isExpanded = !_faqs[i].isExpanded;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 6.h,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 12.h,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: AutoSizeTextWidget(
                                    text: _faqs[i].question,
                                    maxLines: 3,
                                    fontSize: 12.sp,
                                    colorText: const Color(0xff001A33),
                                  ),
                                ),
                                10.horizontalSpace,
                                Icon(
                                  _faqs[i].isExpanded
                                      ? Icons.remove
                                      : Icons.add,
                                  size: 18.r,
                                  color: const Color(0xff757575),
                                ),
                                SizedBox(width: 12.w),
                              ],
                            ),
                            if (_faqs[i].isExpanded)
                              Container(
                                width: double.infinity,
                                color: AppColors.scaffoldColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 10.h,
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                ),
                                child: AutoSizeTextWidget(
                                  text: _faqs[i].answer,
                                  textAlign: TextAlign.justify,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w300,
                                  colorText: const Color(0xff292D32),
                                  maxLines: 10,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
