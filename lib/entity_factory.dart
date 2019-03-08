import 'package:weifangbus/entity/install_basic_info_entity.dart';
import 'package:weifangbus/entity/route_stat_data_entity.dart';
import 'package:weifangbus/entity/startup_basic_info_entity.dart';
import 'package:weifangbus/entity/all_route_data_entity.dart';
import 'package:weifangbus/entity/headline_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "InstallBasicInfoEntity") {
      return InstallBasicInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "RouteStatDataEntity") {
      return RouteStatDataEntity.fromJson(json) as T;
    } else if (T.toString() == "StartUpBasicInfoEntity") {
      return StartUpBasicInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "AllroutedataEntity") {
      return AllroutedataEntity.fromJson(json) as T;
    } else if (T.toString() == "Headline") {
      return Headline.fromJson(json) as T;
    } else {
      return null;
    }
  }
}