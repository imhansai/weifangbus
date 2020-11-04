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

  /// `WeiFang Bus`
  String get AppName {
    return Intl.message(
      'WeiFang Bus',
      name: 'AppName',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get Explore {
    return Intl.message(
      'Explore',
      name: 'Explore',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get More {
    return Intl.message(
      'More',
      name: 'More',
      desc: '',
      args: [],
    );
  }

  /// `click again to exit the application`
  String get ExitApp {
    return Intl.message(
      'click again to exit the application',
      name: 'ExitApp',
      desc: '',
      args: [],
    );
  }

  /// `Route Query`
  String get RouteQuery {
    return Intl.message(
      'Route Query',
      name: 'RouteQuery',
      desc: '',
      args: [],
    );
  }

  /// `Guide`
  String get Guide {
    return Intl.message(
      'Guide',
      name: 'Guide',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get News {
    return Intl.message(
      'News',
      name: 'News',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get HomeNews {
    return Intl.message(
      'News',
      name: 'HomeNews',
      desc: '',
      args: [],
    );
  }

  /// `No News`
  String get NoNews {
    return Intl.message(
      'No News',
      name: 'NoNews',
      desc: '',
      args: [],
    );
  }

  /// `No Pictures`
  String get NoPictures {
    return Intl.message(
      'No Pictures',
      name: 'NoPictures',
      desc: '',
      args: [],
    );
  }

  /// `Search Line`
  String get SearchLine {
    return Intl.message(
      'Search Line',
      name: 'SearchLine',
      desc: '',
      args: [],
    );
  }

  /// `This is a search record that is about to be perfected`
  String get SearchHistory {
    return Intl.message(
      'This is a search record that is about to be perfected',
      name: 'SearchHistory',
      desc: '',
      args: [],
    );
  }

  /// `Refresh the success!`
  String get RefreshSuccess {
    return Intl.message(
      'Refresh the success!',
      name: 'RefreshSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Request data failed. Try switching network and retry!`
  String get RequestDataFailure {
    return Intl.message(
      'Request data failed. Try switching network and retry!',
      name: 'RequestDataFailure',
      desc: '',
      args: [],
    );
  }

  /// `The device is not connected to any network. Please try again after connecting to the network!`
  String get NotConnectedToAnyNetwork {
    return Intl.message(
      'The device is not connected to any network. Please try again after connecting to the network!',
      name: 'NotConnectedToAnyNetwork',
      desc: '',
      args: [],
    );
  }

  /// `yyyy-MM-dd`
  String get NewsDate {
    return Intl.message(
      'yyyy-MM-dd',
      name: 'NewsDate',
      desc: '',
      args: [],
    );
  }

  /// `News Detail`
  String get NewsDetail {
    return Intl.message(
      'News Detail',
      name: 'NewsDetail',
      desc: '',
      args: [],
    );
  }

  /// `Release Time: `
  String get ReleaseTime {
    return Intl.message(
      'Release Time: ',
      name: 'ReleaseTime',
      desc: '',
      args: [],
    );
  }

  /// `yyyy-MM-dd HH:mm:ss`
  String get NewsDetailDate {
    return Intl.message(
      'yyyy-MM-dd HH:mm:ss',
      name: 'NewsDetailDate',
      desc: '',
      args: [],
    );
  }

  /// `Back to top`
  String get BackToTop {
    return Intl.message(
      'Back to top',
      name: 'BackToTop',
      desc: '',
      args: [],
    );
  }

  /// `Reversing`
  String get Reversing {
    return Intl.message(
      'Reversing',
      name: 'Reversing',
      desc: '',
      args: [],
    );
  }

  /// `Reversing Complete`
  String get ReversingComplete {
    return Intl.message(
      'Reversing Complete',
      name: 'ReversingComplete',
      desc: '',
      args: [],
    );
  }

  /// `{num} arrive`
  String ArriveAtStation(Object num) {
    return Intl.message(
      '$num arrive',
      name: 'ArriveAtStation',
      desc: '',
      args: [num],
    );
  }

  /// `{num} leave`
  String AwayFromTheStation(Object num) {
    return Intl.message(
      '$num leave',
      name: 'AwayFromTheStation',
      desc: '',
      args: [num],
    );
  }

  /// `Loading...`
  String get Loading {
    return Intl.message(
      'Loading...',
      name: 'Loading',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Perfect regulation is under your control`
  String get SettingsDesc {
    return Intl.message(
      'Perfect regulation is under your control',
      name: 'SettingsDesc',
      desc: '',
      args: [],
    );
  }

  /// `QQ Group`
  String get QQGroup {
    return Intl.message(
      'QQ Group',
      name: 'QQGroup',
      desc: '',
      args: [],
    );
  }

  /// `Join QQ group to exchange feedback`
  String get QQGroupDesc {
    return Intl.message(
      'Join QQ group to exchange feedback',
      name: 'QQGroupDesc',
      desc: '',
      args: [],
    );
  }

  /// `Weifang Public Transportation Corporation`
  String get Company {
    return Intl.message(
      'Weifang Public Transportation Corporation',
      name: 'Company',
      desc: '',
      args: [],
    );
  }

  /// `About Weifang Public Transportation Corporation`
  String get CompanyDesc {
    return Intl.message(
      'About Weifang Public Transportation Corporation',
      name: 'CompanyDesc',
      desc: '',
      args: [],
    );
  }

  /// `About weifang Bus`
  String get AboutSoftWare {
    return Intl.message(
      'About weifang Bus',
      name: 'AboutSoftWare',
      desc: '',
      args: [],
    );
  }

  /// `Weifang Bus`
  String get SoftWare {
    return Intl.message(
      'Weifang Bus',
      name: 'SoftWare',
      desc: '',
      args: [],
    );
  }

  /// `Come to the author`
  String get Author {
    return Intl.message(
      'Come to the author',
      name: 'Author',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, I have detected that you have not installed the QQ client`
  String get NotInstalledQQ {
    return Intl.message(
      'Sorry, I have detected that you have not installed the QQ client',
      name: 'NotInstalledQQ',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get Ok {
    return Intl.message(
      'Ok',
      name: 'Ok',
      desc: '',
      args: [],
    );
  }

  /// `Language Settings`
  String get LanguageSettings {
    return Intl.message(
      'Language Settings',
      name: 'LanguageSettings',
      desc: '',
      args: [],
    );
  }

  /// `Appearance Management`
  String get AppearanceManagement {
    return Intl.message(
      'Appearance Management',
      name: 'AppearanceManagement',
      desc: '',
      args: [],
    );
  }

  /// `Follow the system`
  String get Auto {
    return Intl.message(
      'Follow the system',
      name: 'Auto',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Chinese`
  String get Chinese {
    return Intl.message(
      'Chinese',
      name: 'Chinese',
      desc: '',
      args: [],
    );
  }

  /// `Japanese`
  String get Japanese {
    return Intl.message(
      'Japanese',
      name: 'Japanese',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get Selected {
    return Intl.message(
      'Selected',
      name: 'Selected',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get Light {
    return Intl.message(
      'Light',
      name: 'Light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get Dark {
    return Intl.message(
      'Dark',
      name: 'Dark',
      desc: '',
      args: [],
    );
  }

  /// `This App was made by the technique of Flutter after personal work. The purpose is to run a bit more modern, I hope you like it😜。`
  String get AppDesc {
    return Intl.message(
      'This App was made by the technique of Flutter after personal work. The purpose is to run a bit more modern, I hope you like it😜。',
      name: 'AppDesc',
      desc: '',
      args: [],
    );
  }

  /// `Special note: The interface is provided by [Weifang Zhangshangbus]. If there is any infringement, please contact me。`
  String get SpecialInstructions {
    return Intl.message(
      'Special note: The interface is provided by [Weifang Zhangshangbus]. If there is any infringement, please contact me。',
      name: 'SpecialInstructions',
      desc: '',
      args: [],
    );
  }

  /// `View Licenses`
  String get ViewLicenses {
    return Intl.message(
      'View Licenses',
      name: 'ViewLicenses',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get Close {
    return Intl.message(
      'Close',
      name: 'Close',
      desc: '',
      args: [],
    );
  }

  /// `To view the source code for this application, visit: `
  String get SeeSource {
    return Intl.message(
      'To view the source code for this application, visit: ',
      name: 'SeeSource',
      desc: '',
      args: [],
    );
  }

  /// `code repository`
  String get Repo {
    return Intl.message(
      'code repository',
      name: 'Repo',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
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

  /// `Age`
  String get Age {
    return Intl.message(
      'Age',
      name: 'Age',
      desc: '',
      args: [],
    );
  }

  /// `25`
  String get AgeDesc {
    return Intl.message(
      '25',
      name: 'AgeDesc',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get City {
    return Intl.message(
      'City',
      name: 'City',
      desc: '',
      args: [],
    );
  }

  /// `ShanDong WeiFang`
  String get CityDesc {
    return Intl.message(
      'ShanDong WeiFang',
      name: 'CityDesc',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get Phone {
    return Intl.message(
      'Phone',
      name: 'Phone',
      desc: '',
      args: [],
    );
  }

  /// `e-mail`
  String get EMail {
    return Intl.message(
      'e-mail',
      name: 'EMail',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'zh'),
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