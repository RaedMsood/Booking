import 'package:booking/core/state/check_state_in_get_api_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../state_mangement/riverpod.dart';
import '../widget/property _fav_card.dart';

class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favoritesProvider.notifier).refresh();
    });
  }


  @override
  Widget build(BuildContext context) {
    final favoritesState = ref.watch(favoritesProvider);
    final favoriteState = favoritesState.listState;
    return Scaffold(
        appBar: SecondaryAppBarWidget(title: S.of(context).favorites),
        body: CheckStateInGetApiDataWidget(
          state: favoriteState,
          refresh: () {
            ref.read(favoritesProvider.notifier).refresh();
          },
          widgetOfData: ListView.builder(
            itemCount: favoriteState.data.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 6.h),
              child: PropertyFavoriteAndMapWidget(
                key: ValueKey('favorite-property-${favoriteState.data[index].id}'),
                viewType: 2,
                property: favoriteState.data[index],
                propertiesByCity: true,
              ),
            ),
          ),
        ));
  }
}
