import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/state/state.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../../../properties/cities/data/model/city_model.dart';
import '../../../properties/cities/presentation/riverpod/cities_riverpod.dart';
import '../../../properties/cities/presentation/widget/design_for_cities_widget.dart';

final selectedCityProviders = StateProvider<CityModel?>((ref) => Auth().city);

class UpdateCityWidget extends ConsumerWidget {
  /// يُنادى عند اختيار مدينة جديدة
  final VoidCallback onChanged;

  const UpdateCityWidget({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityState = ref.watch(getAllCitiesProvider);
    final selectedCity = ref.watch(selectedCityProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        Text(S.of(context).governorate, style: TextStyle(fontSize: 11.5.sp)),
        SizedBox(height: 6.h),
        InkWell(
          onTap: cityState.stateData == States.loaded
              ? () {
            showModalBottomSheetWidget(
              context: context,
              page: ListToViewAllCitiesWidgets(
                cities: cityState.data!,
                onCitySelected: (c) {
                  ref.read(selectedCityProvider.notifier).state = c;
                  onChanged();
                },
              ),
            );
          }
              : null,
          child: Container(
            height: 42.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppIcons.location, height: 18.h),
                SizedBox(width: 8.w),
                Text(
                  selectedCity?.name ?? S.of(context).selectGovernorate,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: selectedCity == null ? Colors.grey : Colors.black87,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(AppIcons.arrowBottom, height: 18.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



class ListToViewAllCitiesWidgets extends StatefulWidget {
  /// قائمة المدن المحمّلة
  final List<CityModel> cities;

  /// يستدعى عند اختيار المدينة
  final ValueChanged<CityModel> onCitySelected;

  const ListToViewAllCitiesWidgets({
    Key? key,
    required this.cities,
    required this.onCitySelected,
  }) : super(key: key);

  @override
  State<ListToViewAllCitiesWidgets> createState() =>
      _ListToViewAllCitiesWidgetState();
}

class _ListToViewAllCitiesWidgetState
    extends State<ListToViewAllCitiesWidgets> {
  late List<CityModel> _filtered;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filtered = widget.cities;
    _searchCtrl.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final q = _searchCtrl.text.trim().toLowerCase();
    setState(() {
      if (q.isEmpty) {
        _filtered = widget.cities;
      } else {
        _filtered = widget.cities
            .where((c) => c.name.toLowerCase().contains(q))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchCtrl.removeListener(_onSearchChanged);
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.h,
      child: Column(
        children: [
          SizedBox(height: 14.h),
          // SearchForACityWidget(
          //   controller: _searchCtrl,
          //   hintText: 'ابحث عن المحافظة…',
          // ),
          if (_filtered.isEmpty)
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: Text('لا توجد نتائج',
                  style: TextStyle(color: Colors.grey)),
            )
          else
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 8.h),
                itemCount: _filtered.length,
                itemBuilder: (ctx, idx) {
                  final city = _filtered[idx];
                  return DesignForCitiesWidget(
                    name: city.name,
                    onTap: () {
                      widget.onCitySelected(city);
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
