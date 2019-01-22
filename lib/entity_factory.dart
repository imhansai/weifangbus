import 'package:weifangbus/entity/home/startUpBasicInfo.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "StartUpBasicInfoEntity") {
      return StartUpBasicInfoEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}