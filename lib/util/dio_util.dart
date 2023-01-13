import 'package:dio/dio.dart';

var dio = new Dio(
  BaseOptions(
    baseUrl: "http://122.4.254.30:7501",
  ),
);

/// error统一处理
String getErrorMsg(DioError e, {String msg = ''}) {
  var errorMsg = msg;
  if (e.type == DioErrorType.connectTimeout) {
    errorMsg += '连接超时,请检查网络后重试';
  } else if (e.type == DioErrorType.sendTimeout) {
    errorMsg += '请求超时,请检查网络后重试';
  } else if (e.type == DioErrorType.receiveTimeout) {
    errorMsg += '响应超时,请检查网络后重试';
  } else if (e.type == DioErrorType.response) {
    errorMsg += '出现异常,请稍后再试';
  } else if (e.type == DioErrorType.cancel) {
    errorMsg += '请求取消';
  } else {
    errorMsg += "未知错误,请稍后再试";
  }
  return errorMsg;
}
