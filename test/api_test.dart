import 'package:dio/dio.dart';
import 'package:weifangbus/util/dio_util.dart';
import 'package:weifangbus/util/request_params_util.dart';

Future main() async {
  try {
    Response response;
    var routeId = encryptedString("1601");
    // var segmentid = encryptedString("35505665");
    var ismainsubCombine = encryptedString("0");
    var stationId = encryptedString("55160716084151459000");
    var uri =
        '/Query_ByStationIDReturnAll?RouteID=$routeId&StationID=$stationId&IsmainsubCombine=$ismainsubCombine&${getSignString()}';
    print(uri);
    response = await dio.get(uri);
    print(response.data);
  } catch (e) {
    print('请求出现问题::: $e');
  }
}
