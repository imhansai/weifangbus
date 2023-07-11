import 'package:dio/dio.dart';

var dio = new Dio(
  BaseOptions(
    baseUrl: "http://122.4.254.30:7501/BusService",
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    // responseType: ResponseType.plain,
  ),
);

/// error统一处理
String getErrorMsg(DioException e, {String msg = ''}) {
  var errorMsg = msg;
  if (e.type == DioExceptionType.connectionTimeout) {
    errorMsg += '连接超时,请检查网络后重试';
  } else if (e.type == DioExceptionType.sendTimeout) {
    errorMsg += '请求超时,请检查网络后重试';
  } else if (e.type == DioExceptionType.receiveTimeout) {
    errorMsg += '响应超时,请检查网络后重试';
  } else if (e.type == DioExceptionType.badResponse) {
    errorMsg += '出现异常,请稍后再试';
  } else if (e.type == DioExceptionType.cancel) {
    errorMsg += '请求取消';
  } else {
    errorMsg += "未知错误,请稍后再试";
  }
  return errorMsg;
}
