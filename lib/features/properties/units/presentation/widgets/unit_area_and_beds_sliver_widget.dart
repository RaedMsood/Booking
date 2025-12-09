import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../property_details/presentation/widgets/general_container_for_details_widget.dart';

class UnitAreaAndBedsSliverWidget extends StatelessWidget {
  final num singleBed;
  final num doubleBed;
  final String? length;
  final String? width;

  const UnitAreaAndBedsSliverWidget({
    super.key,
    required this.singleBed,
    required this.doubleBed,
    this.length,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> bedParts = [];

    if (doubleBed > 0) {
      bedParts.add('${S.of(context).doubleBed} ${doubleBed.toInt()}');
    }

    if (singleBed > 0) {
      bedParts.add('${S.of(context).singleBed} ${singleBed.toInt()}');
    }

    final String? bedsText =
    bedParts.isEmpty ? null : bedParts.join(' - ');

    final bool hasLength =
        length != null && length!.trim().isNotEmpty;
    final bool hasWidth =
        width != null && width!.trim().isNotEmpty;

    final List<Widget> children = [];

    if (hasLength || hasWidth) {
      children.add(
        GeneralContainerForDetailsWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text: S.of(context).area,
                fontSize: 12.2.sp,
              ),
              6.h.verticalSpace,
              Row(
                children: [
                  Icon(
                    Icons.square_outlined,
                    size: 14.sp,
                    color: const Color(0xff605a65),
                  ),
                  4.w.horizontalSpace,
                  AutoSizeTextWidget(
                    text: [
                      if (hasLength)
                        '${S.of(context).length} $length',
                      if (hasWidth)
                        '${S.of(context).width} $width',
                    ].join(' - '),
                    fontSize: 10.2.sp,
                    colorText: AppColors.greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
    if (bedsText != null) {
      children.add(
        GeneralContainerForDetailsWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text: S.of(context).availableBedTypes,
                fontSize: 12.sp,
              ),
              6.h.verticalSpace,
              Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.bed,
                    height: 11.8.h,
                    color: const Color(0xff605a65),
                  ),
                  4.w.horizontalSpace,
                  Flexible(
                    child: AutoSizeTextWidget(
                      text: bedsText,
                      fontSize: 10.sp,
                      colorText: AppColors.greyColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    if (children.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    // نرجّعهم كسليفر واحد
    return SliverList(
      delegate: SliverChildListDelegate(children),
    );
  }
}
