// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => '潍坊 バス';

  @override
  String get home => 'ホーム';

  @override
  String get explore => '見る';

  @override
  String get more => 'もっと';

  @override
  String get exitApp => 'もう一度クリックしてアプリを終了します';

  @override
  String get routeQuery => 'ルートクエリ';

  @override
  String get guide => 'ガイド';

  @override
  String get news => 'ニュース';

  @override
  String get homeNews => 'ニュース';

  @override
  String get noNews => '情報はまだありません';

  @override
  String get noPictures => '写真はしばらくありません';

  @override
  String get searchLine => '経路を探索する';

  @override
  String get searchHistory => 'これは完全な検索記録です';

  @override
  String get refreshSuccess => '刷新に成功する!';

  @override
  String get requestDataFailure => 'データを要求すること失敗した。ネットワークを切り替えて再試行してください!';

  @override
  String get notConnectedToAnyNetwork =>
      '設備はどのネットワークにも接続されていません。ネットワークに接続して再試行してください!';

  @override
  String get newsDate => 'yyyy年MM月dd日';

  @override
  String get newsDetail => '情報詳細';

  @override
  String get releaseTime => 'リリース時間: ';

  @override
  String get newsDetailDate => 'yyyy年MM月dd日';

  @override
  String get backToTop => '上部に戻る';

  @override
  String get reversing => 'ブラシ';

  @override
  String get reversingComplete => '交換完了';

  @override
  String arriveAtStation(Object num) {
    return '$num到着';
  }

  @override
  String awayFromTheStation(Object num) {
    return '$num离れる';
  }

  @override
  String get loading => 'ローディング中...';

  @override
  String get settings => 'セットアップ';

  @override
  String get settingsDesc => '完璧にコントロールして、あなたの掌握に尽くします';

  @override
  String get qQGroup => 'QQ群';

  @override
  String get qQGroupDesc => 'QQ群コミュニケーションフィードバックに参加する';

  @override
  String get company => 'イ坊市公共交通総公司';

  @override
  String get companyDesc => 'イ坊市公共交通総公司';

  @override
  String get aboutSoftWare => 'イ坊バスについて';

  @override
  String get softWare => 'イ坊バス';

  @override
  String get author => '作者に近づく';

  @override
  String get notInstalledQQ => 'QQクライアントがインストールされていないことが検出されました';

  @override
  String get ok => '確定';

  @override
  String get languageSettings => '言語設定';

  @override
  String get appearanceManagement => '外観管理';

  @override
  String get auto => 'システムに追随する';

  @override
  String get english => '英語';

  @override
  String get chinese => '中文';

  @override
  String get japanese => '日本語';

  @override
  String get selected => '選択済み';

  @override
  String get light => 'ライトモード';

  @override
  String get dark => '暗黒モード';

  @override
  String get appDesc => 'このアプリは個人の仕事の合間にFlutter技術で作成した。目的は現代に向かって一時に行くことです😜。';

  @override
  String get specialInstructions =>
      '特記事項: API は [濰坊ポケットバス] から提供されており、侵害がある場合はご連絡ください。';

  @override
  String get viewLicenses => '観免許';

  @override
  String get close => '閉鎖';

  @override
  String get seeSource => 'このアプリケーションのソース コードを表示するには、次の場所にアクセスしてください: ';

  @override
  String get repo => 'コードライブラリ';

  @override
  String get name => '名前';

  @override
  String get nameDesc => '韩塞';

  @override
  String get age => '年齢';

  @override
  String get ageDesc => '';

  @override
  String get city => 'ある都市';

  @override
  String get cityDesc => '山东潍坊';

  @override
  String get phone => '携帯電話番号';

  @override
  String get eMail => 'メール';
}
