// import 'package:dio/dio.dart';
//
// enum EnumNotifications {
//   initial,
//   loading,
//   loaded,
//   error,
// }
//
// class NotificationsState {
//   final EnumNotifications state;
//   final DioException? exeption;
//   final List<dynamic>? data;
//
//   NotificationsState({
//     required this.state,
//     this.exeption,
//     this.data,
//   });
//
//   factory NotificationsState.initial() {
//     return NotificationsState(state: EnumNotifications.initial);
//   }
//
//   NotificationsState copyWith({
//     required EnumNotifications state,
//     DioException? exeption,
//     List<dynamic>? data,
//   }) {
//     return NotificationsState(state: state, exeption: exeption, data: data);
//   }
// }
