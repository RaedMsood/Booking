import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../helpers/flash_bar_helper.dart';
import '../network/errors/remote_exception.dart';
import '../state/state.dart';
import '../theme/app_colors.dart';
import '../widgets/no_internet_connection_widget.dart';
import 'state_data.dart';

class CheckStateInGetApiDataWidget extends StatelessWidget {
  final Widget? widgetOfData;
  final Widget? widgetOfLoading;

  final DataState state;

  const CheckStateInGetApiDataWidget({
    super.key,
    required this.state,
    this.widgetOfData,
    this.widgetOfLoading,
  });

  @override
  Widget build(BuildContext context) {
    print(state.stateData);

    if (state.stateData == States.loaded ||
        state.stateData == States.loadingMore) {
      // return state.data!.isEmpty?EmptyWalletWidget() :widgetOfData!;
      return widgetOfData!;
    } else if (state.stateData == States.error) {
      if (state.exception!.type == DioExceptionType.connectionError) {
        return NoInternetConnectionWidget();
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          showFlashBarError(
            context: context,
            title: MessageOfErorrApi.getExeptionMessage(state.exception!).first,
            text: MessageOfErorrApi.getExeptionMessage(state.exception!).last,
          );
          state.stateData = States.initial;
        });
      }
    } else if (state.stateData == States.loading) {
      return widgetOfLoading ??
          const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
    } else {
      return const SizedBox();
    }
    return const SizedBox();
  }
}
