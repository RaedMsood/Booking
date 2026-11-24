import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/chat_message_model.dart';
import 'chat_hotel_card_widget.dart';

class ChatBubbleWidget extends StatelessWidget {
  final ChatMessageModel message;

  const ChatBubbleWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    if (message.isUser) {
      return _buildUserBubble();
    } else {
      return _buildAssistantBubble();
    }
  }

  Widget _buildUserBubble() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(18.r).copyWith(
                  bottomLeft: Radius.circular(4.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: 13.5.sp,
                  color: Colors.white,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssistantBubble() {
    final hasHotels = message.suggestedHotels.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AI Avatar
              Container(
                margin: EdgeInsets.only(top: 4.h),
                padding: EdgeInsets.all(7.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: message.hasError
                        ? [AppColors.dangerColor, Colors.orange]
                        : [AppColors.primaryColor, AppColors.secondaryColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (message.hasError
                              ? AppColors.dangerColor
                              : AppColors.primaryColor)
                          .withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  message.hasError
                      ? Icons.error_outline_rounded
                      : Icons.auto_awesome,
                  size: 14.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.w),
              // Message Box
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.r).copyWith(
                      bottomRight: Radius.circular(4.r),
                    ),
                    border: Border.all(
                      color: message.hasError
                          ? AppColors.dangerColor.withOpacity(0.3)
                          : AppColors.greySwatch.shade200,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Assistant Badge Header
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AutoSizeTextWidget(
                            text: 'مستشار مزاجي الذكي',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            colorText: message.hasError
                                ? AppColors.dangerColor
                                : AppColors.primaryColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      // Reply Text
                      SelectableText(
                        message.text,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.mainColorFont,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Suggested Hotels Horizontal Slider
          if (hasHotels) ...[
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.only(right: 32.w),
              child: Row(
                children: [
                  Icon(
                    Icons.apartment_rounded,
                    size: 16.sp,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 6.w),
                  AutoSizeTextWidget(
                    text: 'الفنادق المقترحة لك (${message.suggestedHotels.length})',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    colorText: AppColors.mainColorFont,
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.only(right: 28.w),
              child: SizedBox(
                height: 220.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: message.suggestedHotels.length,
                  itemBuilder: (context, index) {
                    final hotel = message.suggestedHotels[index];
                    return ChatHotelCardWidget(property: hotel);
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
