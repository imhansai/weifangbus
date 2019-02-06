import 'package:weifangbus/entity/home/startUpBasicInfo_entity.dart';
import 'package:weifangbus/entity/home/allRouteData_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "Headline") {
      return Headline.fromJson(json) as T;
    } else if (T.toString() == "StartUpBasicInfoEntity") {
      return StartUpBasicInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "AllroutedataEntity") {
      return AllroutedataEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}