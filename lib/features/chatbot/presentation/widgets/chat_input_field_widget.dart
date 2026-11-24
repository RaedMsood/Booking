import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class ChatInputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isSending;
  final ValueChanged<String> onSend;

  const ChatInputFieldWidget({
    super.key,
    required this.controller,
    required this.isSending,
    required this.onSend,
  });

  void _handleSend() {
    final text = controller.text.trim();
    if (text.isNotEmpty && !isSending) {
      onSend(text);
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h).copyWith(
        bottom: MediaQuery.of(context).viewInsets.bottom > 0
            ? 10.h
            : 16.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.scaffoldColor,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: AppColors.greySwatch.shade200,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 12.w),
                    Icon(
                      Icons.auto_awesome,
                      size: 18.sp,
                      color: AppColors.primaryColor,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        minLines: 1,
                        maxLines: 4,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _handleSend(),
                        decoration: InputDecoration(
                          hintText: 'اسأل مستشار مزاجي عن أي فندق أو جناح...',
                          hintStyle: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.fontColor2,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: isSending ? null : _handleSend,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isSending
                        ? [Colors.grey, Colors.blueGrey]
                        : [AppColors.primaryColor, const Color(0xff0042CC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: isSending
                      ? SizedBox(
                          width: 18.r,
                          height: 18.r,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Icon(
                          Icons.send_rounded,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
