import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../riverpod/chatbot_riverpod.dart';
import '../widgets/chat_bubble_widget.dart';
import '../widgets/chat_empty_state_widget.dart';
import '../widgets/chat_input_field_widget.dart';
import '../widgets/chat_typing_indicator_widget.dart';

class ChatbotPage extends ConsumerStatefulWidget {
  const ChatbotPage({super.key});

  @override
  ConsumerState<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends ConsumerState<ChatbotPage> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutQuad,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatbotProvider);
    final notifier = ref.read(chatbotProvider.notifier);

    // Auto-scroll when messages change or typing status changes
    ref.listen(chatbotProvider, (previous, next) {
      if (previous?.messages.length != next.messages.length ||
          previous?.isSending != next.isSending) {
        _scrollToBottom();
      }
    });

    final hasMessages = chatState.messages.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: const SecondaryAppBarWidget(
        title: 'مستشار مزاجي الذكي',
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Clear / New Chat Action Strip (Only when there are messages)
          if (hasMessages)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8.r,
                        height: 8.r,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'متصل بالذكاء الاصطناعي',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.fontColor,
                        ),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () => notifier.clearConversation(),
                    icon: Icon(
                      Icons.refresh_rounded,
                      size: 14.sp,
                      color: AppColors.fontColor,
                    ),
                    label: Text(
                      'محادثة جديدة',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.fontColor,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ],
              ),
            ),

          // Chat Messages or Empty Welcome View
          Expanded(
            child: !hasMessages
                ? ChatEmptyStateWidget(
                    onSuggestionTap: (prompt) {
                      notifier.sendMessage(prompt);
                    },
                  )
                : ListView.builder(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    itemCount: chatState.messages.length +
                        (chatState.isSending ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < chatState.messages.length) {
                        final msg = chatState.messages[index];
                        return ChatBubbleWidget(message: msg);
                      } else {
                        return const ChatTypingIndicatorWidget();
                      }
                    },
                  ),
          ),

          // Bottom Input Bar
          ChatInputFieldWidget(
            controller: _textController,
            isSending: chatState.isSending,
            onSend: (text) {
              notifier.sendMessage(text);
              _scrollToBottom();
            },
          ),
        ],
      ),
    );
  }
}
