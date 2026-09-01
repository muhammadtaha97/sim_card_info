// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'SIMカード情報';

  @override
  String get tabSims => 'SIM';

  @override
  String get tabNetwork => 'ネットワーク';

  @override
  String get tabDevice => '端末';

  @override
  String get tabSettings => '設定';

  @override
  String get titleSims => 'SIMカード';

  @override
  String get tooltipShareReport => 'レポートを共有';

  @override
  String get tooltipRefresh => '更新';

  @override
  String get gateTitle => '電話の権限が必要です';

  @override
  String get gateBody =>
      'AndroidはSIMとネットワークの詳細を電話権限で保護しています。すべて端末上で読み取られ、外部に送信されることはありません。';

  @override
  String get grantPermission => '権限を許可';

  @override
  String get openAppSettings => 'アプリ設定を開く';

  @override
  String get gatePermanent => '権限が完全に拒否されているため、アプリ設定画面からのみ有効にできます。';

  @override
  String get noSimsTitle => '有効なSIMカードがありません';

  @override
  String get noSimsBody =>
      'この端末で有効なSIMまたはeSIMがありません。SIMを挿入するかeSIMを有効にして、下に引いて更新してください。';

  @override
  String get sectionSubscription => 'サブスクリプション';

  @override
  String get sectionRoles => '役割';

  @override
  String get sectionCellular => 'モバイル回線';

  @override
  String get sectionServingCell => '接続中のセル';

  @override
  String get sectionNeighbours => '隣接セル';

  @override
  String get sectionCellTowers => '基地局';

  @override
  String get sectionDataUsage => 'データ使用量';

  @override
  String get sectionActiveConnection => 'アクティブな接続';

  @override
  String get sectionIpAddresses => 'IPアドレス';

  @override
  String get sectionLatency => 'レイテンシ';

  @override
  String get sectionDevice => '端末';

  @override
  String get sectionSimCapabilities => 'SIM機能';

  @override
  String get sectionCalling => '通話とメッセージ';

  @override
  String get sectionSystemSettings => 'システム設定';

  @override
  String get sectionAppearance => '外観';

  @override
  String get labelLanguage => '言語';

  @override
  String get systemDefault => 'システムのデフォルト';

  @override
  String get labelCarrier => 'キャリア';

  @override
  String get labelLabel => 'ラベル';

  @override
  String get labelPhoneNumber => '電話番号';

  @override
  String get labelCountry => '国';

  @override
  String get labelMccMnc => 'MCC-MNC (PLMN)';

  @override
  String get labelCarrierId => 'キャリアID';

  @override
  String get labelSpecificCarrier => '特定キャリア';

  @override
  String get labelSimState => 'SIMの状態';

  @override
  String get labelSimType => 'SIMの種類';

  @override
  String get labelSlot => 'スロット';

  @override
  String get labelPort => 'ポート';

  @override
  String get labelSubscriptionId => 'サブスクリプションID';

  @override
  String get labelOpportunistic => 'オポチュニスティック';

  @override
  String get labelMobileData => 'モバイルデータ';

  @override
  String get chipData => 'データ';

  @override
  String get labelCalls => '通話';

  @override
  String get labelSms => 'SMS';

  @override
  String get labelNetworkType => 'ネットワークの種類';

  @override
  String get labelVoiceNetwork => '音声ネットワーク';

  @override
  String get labelOperator => 'ネットワーク事業者';

  @override
  String get labelOperatorCode => '事業者コード';

  @override
  String get labelNetworkCountry => 'ネットワークの国';

  @override
  String get labelRoaming => 'ローミング';

  @override
  String get labelDataEnabled => 'データ有効';

  @override
  String get labelDataActivity => 'データアクティビティ';

  @override
  String get labelPhoneType => '電話の種類';

  @override
  String get labelSignal => '電波';

  @override
  String get labelStatus => '状態';

  @override
  String get labelConnection => '接続';

  @override
  String get labelInternetAccess => 'インターネット接続';

  @override
  String get labelMetered => '従量制';

  @override
  String get labelLinkDown => '下り速度';

  @override
  String get labelLinkUp => '上り速度';

  @override
  String get labelInterface => 'インターフェース';

  @override
  String get labelDnsServer => 'DNSサーバー';

  @override
  String get labelPrivateDns => 'プライベートDNS';

  @override
  String get labelModel => 'モデル';

  @override
  String get labelDeviceCodename => '端末コードネーム';

  @override
  String get labelAndroidVersion => 'Androidバージョン';

  @override
  String get labelRadioVersion => '無線 (IMEI SV)';

  @override
  String get labelTelephonyHardware => '電話ハードウェア';

  @override
  String get labelSimCardPresent => 'SIMカードあり';

  @override
  String get labelEsimSupported => 'eSIM対応';

  @override
  String get labelActiveModems => '有効なモデム数';

  @override
  String get labelSupportedModems => '対応モデム数';

  @override
  String get labelMaxActiveSims => '最大有効SIM数';

  @override
  String get labelDualSim => 'デュアルSIM';

  @override
  String get labelVoiceCapable => '音声通話対応';

  @override
  String get labelSmsCapable => 'SMS対応';

  @override
  String get labelVoiceAndData => '音声とデータの同時利用';

  @override
  String get yes => 'はい';

  @override
  String get no => 'いいえ';

  @override
  String get unavailable => '利用不可';

  @override
  String get unknown => '不明';

  @override
  String get physicalSim => '物理SIM';

  @override
  String get esimEmbedded => 'eSIM（内蔵）';

  @override
  String get defaultSim => 'デフォルトSIM';

  @override
  String get notDefault => 'デフォルトではない';

  @override
  String get validated => '検証済み';

  @override
  String get notValidated => '未検証';

  @override
  String get off => 'オフ';

  @override
  String get noActiveNetwork => 'アクティブなネットワークなし';

  @override
  String get noActiveSim => '測定できる有効なSIMがありません';

  @override
  String get noCellReported => 'まだセルが検出されていません';

  @override
  String slotN(int n) {
    return 'スロット $n';
  }

  @override
  String simN(int n) {
    return 'SIM $n';
  }

  @override
  String copied(String label) {
    return '$labelをコピーしました';
  }

  @override
  String get qualityExcellent => '非常に良い';

  @override
  String get qualityGood => '良い';

  @override
  String get qualityFair => '普通';

  @override
  String get qualityPoor => '弱い';

  @override
  String get qualityVeryPoor => '非常に弱い';

  @override
  String get signalNone => '電波なしまたは不明';

  @override
  String get simStateReady => '準備完了';

  @override
  String get simStateAbsent => '未挿入';

  @override
  String get simStatePin => 'PINが必要';

  @override
  String get simStatePuk => 'PUKが必要';

  @override
  String get simStateNetworkLocked => 'ネットワークロック';

  @override
  String get simStateNotReady => '準備未完了';

  @override
  String get simStateDisabled => '完全に無効';

  @override
  String get simStateIoError => 'カードI/Oエラー';

  @override
  String get simStateRestricted => 'カード制限あり';

  @override
  String get dataConnected => '接続済み';

  @override
  String get dataDisconnected => '切断';

  @override
  String get dataConnecting => '接続中';

  @override
  String get dataSuspended => '一時停止';

  @override
  String get dataDisconnecting => '切断中';

  @override
  String get activityIdle => 'アイドル';

  @override
  String get activityReceiving => '受信中';

  @override
  String get activitySending => '送信中';

  @override
  String get activityBoth => '送受信中';

  @override
  String get activityDormant => '休止';

  @override
  String get cellTowersExplainer =>
      '接続中の基地局（セルID、エリアコード、PCI、周波数チャネル、バンド）と隣接基地局を表示します。Androidはセル IDを位置情報として扱うため、位置情報の権限が必要です。他の目的には使用されず、データが端末の外に出ることはありません。';

  @override
  String get showCellTowers => '基地局を表示';

  @override
  String get locationPermanent => '位置情報が完全に拒否されているため、アプリ設定画面からのみ有効にできます。';

  @override
  String get dataUsageExplainer =>
      'この端末が今日と今月に使ったモバイルデータとWi-Fiの量を表示します。Androidはこの数値を使用状況へのアクセス設定で保護しています。下をタップし、一覧でSIM Card Infoを許可して戻ってください。';

  @override
  String get grantUsageAccess => '使用状況へのアクセスを許可';

  @override
  String get mobileToday => 'モバイル（今日）';

  @override
  String get mobileMonth => 'モバイル（今月）';

  @override
  String get wifiToday => 'Wi-Fi（今日）';

  @override
  String get wifiMonth => 'Wi-Fi（今月）';

  @override
  String get usageDisclaimer => 'モバイルは全SIMの合計です。AndroidはSIMごとの使用量の分割を許可していません。';

  @override
  String get latencyExplainer =>
      '現在の接続でCloudflare、Google DNS、google.comへの往復時間を測定します。';

  @override
  String get runTest => 'テスト実行';

  @override
  String get runAgain => '再実行';

  @override
  String get unreachable => '到達不能';

  @override
  String get shortcutMobile => 'モバイルネットワーク設定';

  @override
  String get shortcutDataUsage => 'データ使用量';

  @override
  String get shortcutWifi => 'Wi-Fi設定';

  @override
  String get shortcutAirplane => '機内モード';

  @override
  String get themeLight => 'ライト';

  @override
  String get themeSystem => 'システム';

  @override
  String get themeDark => 'ダーク';

  @override
  String get shareFullReport => '完全なレポートを共有';

  @override
  String get shareFullReportSubtitle => 'SIM・ネットワーク・端末の詳細をテキストで';

  @override
  String get shareJson => 'レポートをJSONで共有';

  @override
  String get shareJsonSubtitle => 'ツールやスクリプト向けの機械可読形式';

  @override
  String get shareApp => 'このアプリを共有';

  @override
  String shareAppText(String url) {
    return 'SIMカード情報 — すべてのSIMのキャリア・電波・ネットワーク詳細。$url';
  }

  @override
  String get privacyOptions => 'プライバシーオプション';

  @override
  String get privacyOptionsSubtitle => '広告の同意設定を変更';

  @override
  String privacyOptionsFailed(String message) {
    return 'プライバシーオプションを開けませんでした: $message';
  }

  @override
  String aboutVersion(String version) {
    return 'バージョン $version · Tahatec';
  }

  @override
  String get aboutBy => 'Tahatec';

  @override
  String get privacyNote =>
      'SIM・ネットワーク・端末のすべての詳細は端末上のAndroidから直接読み取られ、このアプリがどこかにアップロードすることはありません。';

  @override
  String sparklineCaption(int dbm, String window) {
    return '現在 $dbm dBm · 直近$window';
  }

  @override
  String get windowMinute => '1分';

  @override
  String windowMinutes(int n) {
    return '$n分';
  }
}
