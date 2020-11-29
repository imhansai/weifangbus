// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `潍坊公交`
  String get AppName {
    return Intl.message(
      '潍坊公交',
      name: 'AppName',
      desc: '',
      args: [],
    );
  }

  /// `首页`
  String get Home {
    return Intl.message(
      '首页',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `探索`
  String get Explore {
    return Intl.message(
      '探索',
      name: 'Explore',
      desc: '',
      args: [],
    );
  }

  /// `更多`
  String get More {
    return Intl.message(
      '更多',
      name: 'More',
      desc: '',
      args: [],
    );
  }

  /// `再次点击退出应用`
  String get ExitApp {
    return Intl.message(
      '再次点击退出应用',
      name: 'ExitApp',
      desc: '',
      args: [],
    );
  }

  /// `线路查询`
  String get RouteQuery {
    return Intl.message(
      '线路查询',
      name: 'RouteQuery',
      desc: '',
      args: [],
    );
  }

  /// `导 乘`
  String get Guide {
    return Intl.message(
      '导 乘',
      name: 'Guide',
      desc: '',
      args: [],
    );
  }

  /// `资 讯`
  String get News {
    return Intl.message(
      '资 讯',
      name: 'News',
      desc: '',
      args: [],
    );
  }

  /// `资\n讯`
  String get HomeNews {
    return Intl.message(
      '资\n讯',
      name: 'HomeNews',
      desc: '',
      args: [],
    );
  }

  /// `暂无资讯信息`
  String get NoNews {
    return Intl.message(
      '暂无资讯信息',
      name: 'NoNews',
      desc: '',
      args: [],
    );
  }

  /// `暂无图片展示`
  String get NoPictures {
    return Intl.message(
      '暂无图片展示',
      name: 'NoPictures',
      desc: '',
      args: [],
    );
  }

  /// `搜索线路`
  String get SearchLine {
    return Intl.message(
      '搜索线路',
      name: 'SearchLine',
      desc: '',
      args: [],
    );
  }

  /// `这是一个即将完善的搜索记录`
  String get SearchHistory {
    return Intl.message(
      '这是一个即将完善的搜索记录',
      name: 'SearchHistory',
      desc: '',
      args: [],
    );
  }

  /// `刷新成功!`
  String get RefreshSuccess {
    return Intl.message(
      '刷新成功!',
      name: 'RefreshSuccess',
      desc: '',
      args: [],
    );
  }

  /// `请求数据失败，请尝试切换网络后重试!`
  String get RequestDataFailure {
    return Intl.message(
      '请求数据失败，请尝试切换网络后重试!',
      name: 'RequestDataFailure',
      desc: '',
      args: [],
    );
  }

  /// `设备未连接到任何网络,请连接网络后重试!`
  String get NotConnectedToAnyNetwork {
    return Intl.message(
      '设备未连接到任何网络,请连接网络后重试!',
      name: 'NotConnectedToAnyNetwork',
      desc: '',
      args: [],
    );
  }

  /// `yyyy年MM月dd日`
  String get NewsDate {
    return Intl.message(
      'yyyy年MM月dd日',
      name: 'NewsDate',
      desc: '',
      args: [],
    );
  }

  /// `资讯详情`
  String get NewsDetail {
    return Intl.message(
      '资讯详情',
      name: 'NewsDetail',
      desc: '',
      args: [],
    );
  }

  /// `发布时间: `
  String get ReleaseTime {
    return Intl.message(
      '发布时间: ',
      name: 'ReleaseTime',
      desc: '',
      args: [],
    );
  }

  /// `yyyy年MM月dd日 HH点mm分ss秒`
  String get NewsDetailDate {
    return Intl.message(
      'yyyy年MM月dd日 HH点mm分ss秒',
      name: 'NewsDetailDate',
      desc: '',
      args: [],
    );
  }

  /// `返回顶部`
  String get BackToTop {
    return Intl.message(
      '返回顶部',
      name: 'BackToTop',
      desc: '',
      args: [],
    );
  }

  /// `换向`
  String get Reversing {
    return Intl.message(
      '换向',
      name: 'Reversing',
      desc: '',
      args: [],
    );
  }

  /// `换向完成`
  String get ReversingComplete {
    return Intl.message(
      '换向完成',
      name: 'ReversingComplete',
      desc: '',
      args: [],
    );
  }

  /// `{num}辆到站`
  String ArriveAtStation(Object num) {
    return Intl.message(
      '$num辆到站',
      name: 'ArriveAtStation',
      desc: '',
      args: [num],
    );
  }

  /// `{num}辆离站`
  String AwayFromTheStation(Object num) {
    return Intl.message(
      '$num辆离站',
      name: 'AwayFromTheStation',
      desc: '',
      args: [num],
    );
  }

  /// `加载中...`
  String get Loading {
    return Intl.message(
      '加载中...',
      name: 'Loading',
      desc: '',
      args: [],
    );
  }

  /// `设置`
  String get Settings {
    return Intl.message(
      '设置',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `完美调控，尽在您的掌握`
  String get SettingsDesc {
    return Intl.message(
      '完美调控，尽在您的掌握',
      name: 'SettingsDesc',
      desc: '',
      args: [],
    );
  }

  /// `QQ群`
  String get QQGroup {
    return Intl.message(
      'QQ群',
      name: 'QQGroup',
      desc: '',
      args: [],
    );
  }

  /// `加入QQ群交流反馈`
  String get QQGroupDesc {
    return Intl.message(
      '加入QQ群交流反馈',
      name: 'QQGroupDesc',
      desc: '',
      args: [],
    );
  }

  /// `潍坊市公共交通总公司`
  String get Company {
    return Intl.message(
      '潍坊市公共交通总公司',
      name: 'Company',
      desc: '',
      args: [],
    );
  }

  /// `关于潍坊市公共交通总公司`
  String get CompanyDesc {
    return Intl.message(
      '关于潍坊市公共交通总公司',
      name: 'CompanyDesc',
      desc: '',
      args: [],
    );
  }

  /// `关于潍坊公交`
  String get AboutSoftWare {
    return Intl.message(
      '关于潍坊公交',
      name: 'AboutSoftWare',
      desc: '',
      args: [],
    );
  }

  /// `潍坊公交`
  String get SoftWare {
    return Intl.message(
      '潍坊公交',
      name: 'SoftWare',
      desc: '',
      args: [],
    );
  }

  /// `走近作者`
  String get Author {
    return Intl.message(
      '走近作者',
      name: 'Author',
      desc: '',
      args: [],
    );
  }

  /// `抱歉，检测到您还未安装QQ客户端`
  String get NotInstalledQQ {
    return Intl.message(
      '抱歉，检测到您还未安装QQ客户端',
      name: 'NotInstalledQQ',
      desc: '',
      args: [],
    );
  }

  /// `确定`
  String get Ok {
    return Intl.message(
      '确定',
      name: 'Ok',
      desc: '',
      args: [],
    );
  }

  /// `语言设置`
  String get LanguageSettings {
    return Intl.message(
      '语言设置',
      name: 'LanguageSettings',
      desc: '',
      args: [],
    );
  }

  /// `外观管理`
  String get AppearanceManagement {
    return Intl.message(
      '外观管理',
      name: 'AppearanceManagement',
      desc: '',
      args: [],
    );
  }

  /// `跟随系统`
  String get Auto {
    return Intl.message(
      '跟随系统',
      name: 'Auto',
      desc: '',
      args: [],
    );
  }

  /// `英语`
  String get English {
    return Intl.message(
      '英语',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `中文`
  String get Chinese {
    return Intl.message(
      '中文',
      name: 'Chinese',
      desc: '',
      args: [],
    );
  }

  /// `日语`
  String get Japanese {
    return Intl.message(
      '日语',
      name: 'Japanese',
      desc: '',
      args: [],
    );
  }

  /// `已选择`
  String get Selected {
    return Intl.message(
      '已选择',
      name: 'Selected',
      desc: '',
      args: [],
    );
  }

  /// `浅色模式`
  String get Light {
    return Intl.message(
      '浅色模式',
      name: 'Light',
      desc: '',
      args: [],
    );
  }

  /// `暗黑模式`
  String get Dark {
    return Intl.message(
      '暗黑模式',
      name: 'Dark',
      desc: '',
      args: [],
    );
  }

  /// `此 App 是个人工作之余通过 Flutter 技术制作。目的是奔着现代一点去的,希望大家喜欢😜。`
  String get AppDesc {
    return Intl.message(
      '此 App 是个人工作之余通过 Flutter 技术制作。目的是奔着现代一点去的,希望大家喜欢😜。',
      name: 'AppDesc',
      desc: '',
      args: [],
    );
  }

  /// `特别说明: 接口由【潍坊掌上公交】提供，如有侵权，请联系我。`
  String get SpecialInstructions {
    return Intl.message(
      '特别说明: 接口由【潍坊掌上公交】提供，如有侵权，请联系我。',
      name: 'SpecialInstructions',
      desc: '',
      args: [],
    );
  }

  /// `要查看此应用的源代码，请访问: `
  String get SeeSource {
    return Intl.message(
      '要查看此应用的源代码，请访问: ',
      name: 'SeeSource',
      desc: '',
      args: [],
    );
  }

  /// `代码库`
  String get Repo {
    return Intl.message(
      '代码库',
      name: 'Repo',
      desc: '',
      args: [],
    );
  }

  /// `姓名`
  String get Name {
    return Intl.message(
      '姓名',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `韩塞`
  String get NameDesc {
    return Intl.message(
      '韩塞',
      name: 'NameDesc',
      desc: '',
      args: [],
    );
  }

  /// `年龄`
  String get Age {
    return Intl.message(
      '年龄',
      name: 'Age',
      desc: '',
      args: [],
    );
  }

  /// `25岁`
  String get AgeDesc {
    return Intl.message(
      '25岁',
      name: 'AgeDesc',
      desc: '',
      args: [],
    );
  }

  /// `所在城市`
  String get City {
    return Intl.message(
      '所在城市',
      name: 'City',
      desc: '',
      args: [],
    );
  }

  /// `山东潍坊`
  String get CityDesc {
    return Intl.message(
      '山东潍坊',
      name: 'CityDesc',
      desc: '',
      args: [],
    );
  }

  /// `手机号`
  String get Phone {
    return Intl.message(
      '手机号',
      name: 'Phone',
      desc: '',
      args: [],
    );
  }

  /// `邮件`
  String get EMail {
    return Intl.message(
      '邮件',
      name: 'EMail',
      desc: '',
      args: [],
    );
  }

  /// `当前未连接到任何异步计算。`
  String get NonWidgetLabel {
    return Intl.message(
      '当前未连接到任何异步计算。',
      name: 'NonWidgetLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}