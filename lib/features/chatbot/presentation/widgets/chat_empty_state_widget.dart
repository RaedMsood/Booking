import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class ChatEmptyStateWidget extends StatelessWidget {
  final ValueChanged<String> onSuggestionTap;

  const ChatEmptyStateWidget({
    super.key,
    required this.onSuggestionTap,
  });

  static const List<Map<String, String>> _suggestions = [
    {
      'title': 'أفضل فنادق عائلية في صنعاء',
      'icon': '🏨',
    },
    {
      'title': 'شاليهات هادئة مع مسبح خاص',
      'icon': '🏊‍♂️',
    },
    {
      'title': 'فندق اقتصادي نظيف قريب من الخدمات',
      'icon': '💰',
    },
    {
      'title': 'أفضل فندق بإطلالة بحرية في عدن',
      'icon': '🌊',
    },
    {
      'title': 'شقة فندقية راقية 3 غرف للأهل',
      'icon': '✨',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // AI Icon Card
            Container(
              padding: EdgeInsets.all(18.r),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor.withOpacity(0.12),
                    AppColors.secondaryColor.withOpacity(0.15),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.auto_awesome_rounded,
                size: 42.sp,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 16.h),
            AutoSizeTextWidget(
              text: 'أهلاً بك في مستشار مزاجي الذكي',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              colorText: AppColors.mainColorFont,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'أنا هنا لمساعدتك في اختيار أفضل الفنادق والشاليهات في اليمن بما يتناسب مع ميزانيتك ومزاجك وعائلتك.',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.fontColor,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Align(
              alignment: Alignment.centerRight,
              child: AutoSizeTextWidget(
                text: 'جرّب أن تسأل عن:',
                fontSize: 12.5.sp,
                fontWeight: FontWeight.bold,
                colorText: AppColors.mainColorFont,
              ),
            ),
            SizedBox(height: 10.h),
            // Suggestion Chips
            ..._suggestions.map((item) {
              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                width: double.infinity,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.r),
                    onTap: () => onSuggestionTap(item['title']!),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.greySwatch.shade200,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            item['icon']!,
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: AutoSizeTextWidget(
                              text: item['title']!,
                              fontSize: 12.sp,
                              colorText: AppColors.mainColorFont,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 12.sp,
                            color: AppColors.fontColor2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
