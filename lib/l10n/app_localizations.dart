import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('zh')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'WeiFang Bus'**
  String get appName;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'click again to exit the application'**
  String get exitApp;

  /// No description provided for @routeQuery.
  ///
  /// In en, this message translates to:
  /// **'Route Query'**
  String get routeQuery;

  /// No description provided for @guide.
  ///
  /// In en, this message translates to:
  /// **'Guide'**
  String get guide;

  /// No description provided for @news.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get news;

  /// No description provided for @homeNews.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get homeNews;

  /// No description provided for @noNews.
  ///
  /// In en, this message translates to:
  /// **'No News'**
  String get noNews;

  /// No description provided for @noPictures.
  ///
  /// In en, this message translates to:
  /// **'No Pictures'**
  String get noPictures;

  /// No description provided for @searchLine.
  ///
  /// In en, this message translates to:
  /// **'Search Line'**
  String get searchLine;

  /// No description provided for @searchHistory.
  ///
  /// In en, this message translates to:
  /// **'This is a search record that is about to be perfected'**
  String get searchHistory;

  /// No description provided for @refreshSuccess.
  ///
  /// In en, this message translates to:
  /// **'Refresh the success!'**
  String get refreshSuccess;

  /// No description provided for @requestDataFailure.
  ///
  /// In en, this message translates to:
  /// **'Request data failed. Try switching network and retry!'**
  String get requestDataFailure;

  /// No description provided for @notConnectedToAnyNetwork.
  ///
  /// In en, this message translates to:
  /// **'The device is not connected to any network. Please try again after connecting to the network!'**
  String get notConnectedToAnyNetwork;

  /// No description provided for @newsDate.
  ///
  /// In en, this message translates to:
  /// **'yyyy-MM-dd'**
  String get newsDate;

  /// No description provided for @newsDetail.
  ///
  /// In en, this message translates to:
  /// **'News Detail'**
  String get newsDetail;

  /// No description provided for @releaseTime.
  ///
  /// In en, this message translates to:
  /// **'Release Time: '**
  String get releaseTime;

  /// No description provided for @newsDetailDate.
  ///
  /// In en, this message translates to:
  /// **'yyyy-MM-dd'**
  String get newsDetailDate;

  /// No description provided for @backToTop.
  ///
  /// In en, this message translates to:
  /// **'Back to top'**
  String get backToTop;

  /// No description provided for @reversing.
  ///
  /// In en, this message translates to:
  /// **'Reversing'**
  String get reversing;

  /// No description provided for @reversingComplete.
  ///
  /// In en, this message translates to:
  /// **'Reversing Complete'**
  String get reversingComplete;

  /// No description provided for @arriveAtStation.
  ///
  /// In en, this message translates to:
  /// **'{num} arrive'**
  String arriveAtStation(Object num);

  /// No description provided for @awayFromTheStation.
  ///
  /// In en, this message translates to:
  /// **'{num} leave'**
  String awayFromTheStation(Object num);

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingsDesc.
  ///
  /// In en, this message translates to:
  /// **'Perfect regulation is under your control'**
  String get settingsDesc;

  /// No description provided for @qQGroup.
  ///
  /// In en, this message translates to:
  /// **'QQ Group'**
  String get qQGroup;

  /// No description provided for @qQGroupDesc.
  ///
  /// In en, this message translates to:
  /// **'Join QQ group to exchange feedback'**
  String get qQGroupDesc;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Weifang Public Transportation Corporation'**
  String get company;

  /// No description provided for @companyDesc.
  ///
  /// In en, this message translates to:
  /// **'About Weifang Public Transportation Corporation'**
  String get companyDesc;

  /// No description provided for @aboutSoftWare.
  ///
  /// In en, this message translates to:
  /// **'About weifang Bus'**
  String get aboutSoftWare;

  /// No description provided for @softWare.
  ///
  /// In en, this message translates to:
  /// **'Weifang Bus'**
  String get softWare;

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'Come to the author'**
  String get author;

  /// No description provided for @notInstalledQQ.
  ///
  /// In en, this message translates to:
  /// **'Sorry, I have detected that you have not installed the QQ client'**
  String get notInstalledQQ;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @languageSettings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// No description provided for @appearanceManagement.
  ///
  /// In en, this message translates to:
  /// **'Appearance Management'**
  String get appearanceManagement;

  /// No description provided for @auto.
  ///
  /// In en, this message translates to:
  /// **'Follow the system'**
  String get auto;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @chinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// No description provided for @japanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get japanese;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @appDesc.
  ///
  /// In en, this message translates to:
  /// **'This App was made by the technique of Flutter after personal work. The purpose is to run a bit more modern, I hope you like it😜。'**
  String get appDesc;

  /// No description provided for @specialInstructions.
  ///
  /// In en, this message translates to:
  /// **'Special note: The API is provided by [Weifang Zhangshangbus]. If there is any infringement, please contact me。'**
  String get specialInstructions;

  /// No description provided for @viewLicenses.
  ///
  /// In en, this message translates to:
  /// **'View Licenses'**
  String get viewLicenses;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @seeSource.
  ///
  /// In en, this message translates to:
  /// **'To view the source code for this application, visit: '**
  String get seeSource;

  /// No description provided for @repo.
  ///
  /// In en, this message translates to:
  /// **'code repository'**
  String get repo;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameDesc.
  ///
  /// In en, this message translates to:
  /// **'韩塞'**
  String get nameDesc;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @ageDesc.
  ///
  /// In en, this message translates to:
  /// **''**
  String get ageDesc;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @cityDesc.
  ///
  /// In en, this message translates to:
  /// **'ChongQing NanChuan'**
  String get cityDesc;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @eMail.
  ///
  /// In en, this message translates to:
  /// **'e-mail'**
  String get eMail;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
