import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../services/auth/auth.dart';
import 'urls.dart';

class RemoteRequest {
  static late Dio dio;

  static initDio() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppURL.baseURL,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    dynamic query,
  }) async {

    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept-Language':await Auth().getLanguage(),
      'Authorization': 'Bearer ${Auth().token}',
    };
    final response = await dio.get(url, queryParameters: query);
    debugPrint(response.statusCode.toString());
    debugPrint(response.data.toString());

    if (response.statusCode == 200) {
      return response;
    } else {
      debugPrint(response.statusCode.toString());
      throw Exception();
    }
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept-Language':await Auth().getLanguage(),
      'Authorization': 'Bearer ${Auth().token}',
    };
    final response = await dio.post(
      path,
      queryParameters: query,
      data: jsonEncode(data),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      debugPrint(response.data.toString());
      debugPrint(response.statusCode.toString());
      return response;
    } else {
      debugPrint(response.statusCode.toString());

      throw Exception();
    }
  }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept-Language':await Auth().getLanguage(),
      'Authorization': 'Bearer ${Auth().token}',
    };
    final response = await dio.put(
      path,
      queryParameters: query,
      data: jsonEncode(data),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      debugPrint(response.data.toString());
      debugPrint(response.statusCode.toString());
      return response;
    } else {
      throw Exception();
    }
  }

  static Future<Response> deleteData({
    required String path,
    Map<String, dynamic>? query,
    dynamic data,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept-Language':await Auth().getLanguage(),
      'Authorization': 'Bearer ${Auth().token}',
    };
    final response =
        await dio.delete(path, queryParameters: query, data: jsonEncode(data));

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 202) {
      debugPrint(response.data.toString());
      debugPrint(response.statusCode.toString());
      return response;
    } else {
      throw Exception();
    }
  }
}
