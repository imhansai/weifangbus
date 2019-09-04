import 'package:dio/dio.dart';

var dio = new Dio(
  BaseOptions(
    baseUrl: "http://122.4.254.30:1001",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  ),
);
