import 'package:booking/core/state/check_state_in_get_api_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
import '../state_mangement/riverpod.dart';
import '../widget/property _fav_card.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final favoriteState = ref.watch(favoriteProvider);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title:  AutoSizeTextWidget(
            text: S.of(context).favorites,
          ),
        ),
        body: CheckStateInGetApiDataWidget(
          state: favoriteState,
          widgetOfData: ListView.builder(
            itemCount: favoriteState.data.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 6.h),
              child: PropertyFavoriteAndMapWidget(
                viewType: 2,
                property: favoriteState.data[index],
                propertiesByCity: true,
              ),
            ),
          ),
        ));
  }
}
