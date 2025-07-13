import 'package:dio/dio.dart';
import 'state.dart';

class DataState<T> {
  States stateData;
  final DioException? exception;
  final T data;

  DataState({
    required this.stateData,
    this.exception,
    required this.data,
  });

  factory DataState.initial(T data) {
    return DataState(
      stateData: States.initial,
      data: data,
    );
  }

  DataState<T> copyWith({
    required States state,
    DioException? exception,
    T? data,
  }) {
    return DataState(
      stateData: state,
      exception: exception,
      data: data ?? this.data,
    );
  }
}
