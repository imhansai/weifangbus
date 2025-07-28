// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'WeiFang Bus';

  @override
  String get home => 'Home';

  @override
  String get explore => 'Explore';

  @override
  String get more => 'More';

  @override
  String get exitApp => 'click again to exit the application';

  @override
  String get routeQuery => 'Route Query';

  @override
  String get guide => 'Guide';

  @override
  String get news => 'News';

  @override
  String get homeNews => 'News';

  @override
  String get noNews => 'No News';

  @override
  String get noPictures => 'No Pictures';

  @override
  String get searchLine => 'Search Line';

  @override
  String get searchHistory =>
      'This is a search record that is about to be perfected';

  @override
  String get refreshSuccess => 'Refresh the success!';

  @override
  String get requestDataFailure =>
      'Request data failed. Try switching network and retry!';

  @override
  String get notConnectedToAnyNetwork =>
      'The device is not connected to any network. Please try again after connecting to the network!';

  @override
  String get newsDate => 'yyyy-MM-dd';

  @override
  String get newsDetail => 'News Detail';

  @override
  String get releaseTime => 'Release Time: ';

  @override
  String get newsDetailDate => 'yyyy-MM-dd';

  @override
  String get backToTop => 'Back to top';

  @override
  String get reversing => 'Reversing';

  @override
  String get reversingComplete => 'Reversing Complete';

  @override
  String arriveAtStation(Object num) {
    return '$num arrive';
  }

  @override
  String awayFromTheStation(Object num) {
    return '$num leave';
  }

  @override
  String get loading => 'Loading...';

  @override
  String get settings => 'Settings';

  @override
  String get settingsDesc => 'Perfect regulation is under your control';

  @override
  String get qQGroup => 'QQ Group';

  @override
  String get qQGroupDesc => 'Join QQ group to exchange feedback';

  @override
  String get company => 'Weifang Public Transportation Corporation';

  @override
  String get companyDesc => 'About Weifang Public Transportation Corporation';

  @override
  String get aboutSoftWare => 'About weifang Bus';

  @override
  String get softWare => 'Weifang Bus';

  @override
  String get author => 'Come to the author';

  @override
  String get notInstalledQQ =>
      'Sorry, I have detected that you have not installed the QQ client';

  @override
  String get ok => 'Ok';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get appearanceManagement => 'Appearance Management';

  @override
  String get auto => 'Follow the system';

  @override
  String get english => 'English';

  @override
  String get chinese => 'Chinese';

  @override
  String get japanese => 'Japanese';

  @override
  String get selected => 'Selected';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get appDesc =>
      'This App was made by the technique of Flutter after personal work. The purpose is to run a bit more modern, I hope you like it😜。';

  @override
  String get specialInstructions =>
      'Special note: The API is provided by [Weifang Zhangshangbus]. If there is any infringement, please contact me。';

  @override
  String get viewLicenses => 'View Licenses';

  @override
  String get close => 'Close';

  @override
  String get seeSource =>
      'To view the source code for this application, visit: ';

  @override
  String get repo => 'code repository';

  @override
  String get name => 'Name';

  @override
  String get nameDesc => '韩塞';

  @override
  String get age => 'Age';

  @override
  String get ageDesc => '';

  @override
  String get city => 'City';

  @override
  String get cityDesc => 'ChongQing NanChuan';

  @override
  String get phone => 'Phone';

  @override
  String get eMail => 'e-mail';
}
