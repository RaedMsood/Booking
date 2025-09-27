import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../core/widgets/read_more_text_widget.dart';
import '../../../home/presentation/riverpod/home_riverpod.dart';
import '../riverpod/cities_riverpod.dart';
import '../widget/city_name_and_flag_widget.dart';
import '../../../home/presentation/widgets/property_list_widget.dart';
import '../../../home/presentation/widgets/property_view_type_widget.dart';
import '../widget/sliver_app_bar_pro_by_city_widget.dart';

class PropertiesByCityPage extends ConsumerStatefulWidget {
  final int cityId;

  const PropertiesByCityPage({super.key, required this.cityId});

  @override
  ConsumerState<PropertiesByCityPage> createState() =>
      _PropertiesByCityPagePageState();
}

class _PropertiesByCityPagePageState
    extends ConsumerState<PropertiesByCityPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      final state = ref.read(getPropertiesByCityProvider(widget.cityId));
      if (state.stateData != States.loadingMore) {
        ref
            .read(getPropertiesByCityProvider(widget.cityId).notifier)
            .getData(moreData: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getPropertiesByCityProvider(widget.cityId));
    ref.watch(getAllPropertyProvider);

    final hasDestination = state.data.cities.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfLoading: const CircularProgressIndicatorWidget(),
        widgetOfData: RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: Colors.white,
          displacement: 40,
          strokeWidth: 2.5,
          onRefresh: () async {
            await ref
                .read(getPropertiesByCityProvider(widget.cityId).notifier)
                .getData();
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              if (hasDestination)
                SliverAppBarProByCityWidget(
                  images: state.data.cities[0].image,
                  cityName: state.data.cities[0].name,
                ),
              if (hasDestination)
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CityNameAndFlagWidget(
                          cityName: state.data.cities[0].name,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        12.h.verticalSpace,
                        ReadMoreTextWidget(
                          text: state.data.cities[0].description,
                          style: TextStyle(
                            fontSize: 12.6.sp,
                            height: 1.18.h,
                            fontWeight: FontWeight.w400,
                            color: AppColors.mainColorFont,
                            fontFamily: 'ReadexPro',
                          ),
                        ),
                        10.h.verticalSpace,
                        Container(
                          height: 1.h,
                          width: double.infinity,
                          color: AppColors.fontColor2.withOpacity(.2),
                          margin: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                      ],
                    ),
                  ),
                ),
              const SliverToBoxAdapter(
                child: PropertyViewTypeWidget(),
              ),
              PropertySliverListWidget(
                properties: state.data.property.data,

                propertiesByCity: true,
              ),
              if (state.stateData == States.loadingMore)
                const SliverToBoxAdapter(
                  child: CircularProgressIndicatorWidget(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
