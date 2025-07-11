import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';

class SelectFieldWidget extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const SelectFieldWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AutoSizeTextWidget(
            text: label, fontSize: 10, fontWeight: FontWeight.w400),
        6.verticalSpace,
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeTextWidget(
                      text: value, fontSize: 10, fontWeight: FontWeight.w400),
                ),
                const Icon(Icons.keyboard_arrow_left, color: Colors.black54),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
