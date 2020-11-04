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

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
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