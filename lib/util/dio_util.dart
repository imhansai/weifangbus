import 'package:dio/dio.dart';

var dio = new Dio(
  BaseOptions(
    baseUrl: "http://122.4.254.30:1001",
    connectTimeout: 8000,
    receiveTimeout: 5000,
  ),
);

/// error统一处理
String getErrorMsg(DioError e, {String msg}) {
  var errorMsg = msg.isNotEmpty ? msg : "";
  if (e.type == DioErrorType.CONNECT_TIMEOUT) {
    errorMsg += "连接超时,请检查网络后重试";
  } else if (e.type == DioErrorType.SEND_TIMEOUT) {
    errorMsg += "请求超时,请检查网络后重试";
  } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
    errorMsg += "响应超时,请检查网络后重试";
  } else if (e.type == DioErrorType.RESPONSE) {
    errorMsg += "出现异常,请稍后再试";
  } else if (e.type == DioErrorType.CANCEL) {
    errorMsg += "请求取消";
  } else {
    errorMsg += "未知错误,请稍后再试";
  }
  return errorMsg;
}
