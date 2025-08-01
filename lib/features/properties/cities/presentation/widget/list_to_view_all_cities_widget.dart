import 'package:booking/core/state/check_state_in_get_api_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/city_model.dart';
import '../riverpod/cities_riverpod.dart';
import 'design_for_cities_widget.dart';
import 'search_for_city_widget.dart';

class ListToViewAllCitiesWidget extends ConsumerStatefulWidget {
  const ListToViewAllCitiesWidget({super.key});

  @override
  ConsumerState<ListToViewAllCitiesWidget> createState() =>
      _ListToViewAllCitiesWidgetState();
}

class _ListToViewAllCitiesWidgetState
    extends ConsumerState<ListToViewAllCitiesWidget> {
  TextEditingController searchForACity = TextEditingController();
  List<CityModel> items = [];

  @override
  void initState() {
    items = ref.read(getAllCitiesProvider.notifier).state.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cities = ref.watch(getAllCitiesProvider);

    return CheckStateInGetApiDataWidget(
      state: cities,
      widgetOfData: SizedBox(
        height: 400.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            14.h.verticalSpace,
            SearchForACityWidget(
              search: searchForACity,
              onChanged: (searchItem) {
                setState(() {
                  items = cities.data
                      .where((element) => element.name
                          .toString()
                          .toUpperCase()
                          .contains(searchItem.toString().toUpperCase()))
                      .toList();
                });
              },
            ),
            if (items.isEmpty) const SearchResultsAreEmptyWidget(),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(14.sp),
                itemBuilder: (context, index) {
                  return DesignForCitiesWidget(
                    name: items[index].name.toString(),
                    onTap: () {
                      ref.read(selectedCityProvider.notifier).state =
                          items[index];
                      Navigator.of(context).pop();
                    },
                  );
                },
                itemCount: items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
