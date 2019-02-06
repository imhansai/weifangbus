import 'package:dio/dio.dart';

Options options = Options(baseUrl: "http://122.4.254.30:1001", connectTimeout: 5000, receiveTimeout: 3000);
Dio dio = Dio(options);
