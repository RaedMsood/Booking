import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/models/policy_model.dart';
import 'general_container_for_details_widget.dart';


class TermsPolicyWidget extends StatefulWidget {
  final List<PolicyModel> policy;

  const TermsPolicyWidget({super.key, required this.policy});

  @override
  State<TermsPolicyWidget> createState() => _TermsPolicyWidgetState();
}

class _TermsPolicyWidgetState extends State<TermsPolicyWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  static const int _initialItemCount = 2;

  @override
  Widget build(BuildContext context) {
    final allPolicies = widget.policy;
    final displayCount = _isExpanded
        ? allPolicies.length
        : min(allPolicies.length, _initialItemCount);
    final policiesToShow = allPolicies.take(displayCount).toList();

    return GeneralContainerForDetailsWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: S.of(context).hotelTermsAndPolicies,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
          12.h.verticalSpace,
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Column(
              children: [
                for (var policy in policiesToShow) ...[
                  _buildItem(policy.all),
                  4.h.verticalSpace,
                ],
              ],
            ),
          ),
          if (allPolicies.length > _initialItemCount)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w).copyWith(top: 6.h),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: AutoSizeTextWidget(
                  text: _isExpanded ? S.of(context).showLess : S.of(context).viewMore,
                  fontSize: 10.4.sp,
                  colorText: AppColors.primaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.check_box_rounded,
          color: Colors.green,
          size: 20,
        ),
        6.w.horizontalSpace,
        Expanded(
          child: AutoSizeTextWidget(
            text: text,
            fontSize: 11.5.sp,
            colorText: AppColors.greySwatch.shade700,
            fontWeight: FontWeight.w400,
            maxLines: 8,
          ),
        ),
      ],
    );
  }
}
