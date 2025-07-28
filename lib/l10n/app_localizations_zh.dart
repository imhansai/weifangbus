// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '潍坊公交';

  @override
  String get home => '首页';

  @override
  String get explore => '探索';

  @override
  String get more => '更多';

  @override
  String get exitApp => '再次点击退出应用';

  @override
  String get routeQuery => '线路查询';

  @override
  String get guide => '导 乘';

  @override
  String get news => '资 讯';

  @override
  String get homeNews => '资讯';

  @override
  String get noNews => '暂无资讯信息';

  @override
  String get noPictures => '暂无图片展示';

  @override
  String get searchLine => '搜索线路';

  @override
  String get searchHistory => '这是一个即将完善的搜索记录';

  @override
  String get refreshSuccess => '刷新成功!';

  @override
  String get requestDataFailure => '请求数据失败，请尝试切换网络后重试!';

  @override
  String get notConnectedToAnyNetwork => '设备未连接到任何网络,请连接网络后重试!';

  @override
  String get newsDate => 'yyyy年MM月dd日';

  @override
  String get newsDetail => '资讯详情';

  @override
  String get releaseTime => '发布时间: ';

  @override
  String get newsDetailDate => 'yyyy年MM月dd日';

  @override
  String get backToTop => '返回顶部';

  @override
  String get reversing => '换向';

  @override
  String get reversingComplete => '换向完成';

  @override
  String arriveAtStation(Object num) {
    return '$num辆到站';
  }

  @override
  String awayFromTheStation(Object num) {
    return '$num辆离站';
  }

  @override
  String get loading => '加载中...';

  @override
  String get settings => '设置';

  @override
  String get settingsDesc => '完美调控，尽在您的掌握';

  @override
  String get qQGroup => 'QQ群';

  @override
  String get qQGroupDesc => '加入QQ群交流反馈';

  @override
  String get company => '潍坊市公共交通总公司';

  @override
  String get companyDesc => '关于潍坊市公共交通总公司';

  @override
  String get aboutSoftWare => '关于潍坊公交';

  @override
  String get softWare => '潍坊公交';

  @override
  String get author => '走近作者';

  @override
  String get notInstalledQQ => '抱歉，检测到您还未安装QQ客户端';

  @override
  String get ok => '确定';

  @override
  String get languageSettings => '语言设置';

  @override
  String get appearanceManagement => '外观管理';

  @override
  String get auto => '跟随系统';

  @override
  String get english => '英语';

  @override
  String get chinese => '中文';

  @override
  String get japanese => '日语';

  @override
  String get selected => '已选择';

  @override
  String get light => '浅色模式';

  @override
  String get dark => '暗黑模式';

  @override
  String get appDesc => '此 App 是个人工作之余通过 Flutter 技术制作。目的是奔着现代一点去的,希望大家喜欢😜。';

  @override
  String get specialInstructions => '特别声明: API 由【潍坊掌上公交】提供，如有侵权，请联系我。';

  @override
  String get viewLicenses => '查看许可';

  @override
  String get close => '关闭';

  @override
  String get seeSource => '要查看此应用程序的源代码，请访问：';

  @override
  String get repo => '代码库';

  @override
  String get name => '姓名';

  @override
  String get nameDesc => '韩塞';

  @override
  String get age => '年龄';

  @override
  String get ageDesc => '岁';

  @override
  String get city => '所在城市';

  @override
  String get cityDesc => '重庆南川';

  @override
  String get phone => '手机号';

  @override
  String get eMail => '邮件';
}
