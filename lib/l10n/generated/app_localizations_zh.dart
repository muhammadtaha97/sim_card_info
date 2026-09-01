// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'SIM卡信息';

  @override
  String get tabSims => 'SIM卡';

  @override
  String get tabNetwork => '网络';

  @override
  String get tabDevice => '设备';

  @override
  String get tabSettings => '设置';

  @override
  String get titleSims => 'SIM卡';

  @override
  String get tooltipShareReport => '分享报告';

  @override
  String get tooltipRefresh => '刷新';

  @override
  String get gateTitle => '需要电话权限';

  @override
  String get gateBody => 'Android 将 SIM 卡和网络详情保护在电话权限之后。所有信息都在您的设备上读取，绝不会离开设备。';

  @override
  String get grantPermission => '授予权限';

  @override
  String get openAppSettings => '打开应用设置';

  @override
  String get gatePermanent => '权限已被永久拒绝，只能在应用设置页面中开启。';

  @override
  String get noSimsTitle => '没有已激活的SIM卡';

  @override
  String get noSimsBody => '此设备上没有已激活的 SIM 卡或 eSIM。请插入 SIM 卡或启用 eSIM，然后下拉刷新。';

  @override
  String get sectionSubscription => '订阅信息';

  @override
  String get sectionRoles => '角色';

  @override
  String get sectionCellular => '蜂窝网络';

  @override
  String get sectionServingCell => '服务小区';

  @override
  String get sectionNeighbours => '邻近小区';

  @override
  String get sectionCellTowers => '基站';

  @override
  String get sectionDataUsage => '流量使用';

  @override
  String get sectionActiveConnection => '当前连接';

  @override
  String get sectionIpAddresses => 'IP地址';

  @override
  String get sectionLatency => '延迟';

  @override
  String get sectionDevice => '设备';

  @override
  String get sectionSimCapabilities => 'SIM功能';

  @override
  String get sectionCalling => '通话与短信';

  @override
  String get sectionSystemSettings => '系统设置';

  @override
  String get sectionAppearance => '外观';

  @override
  String get labelLanguage => '语言';

  @override
  String get systemDefault => '跟随系统';

  @override
  String get labelCarrier => '运营商';

  @override
  String get labelLabel => '标签';

  @override
  String get labelPhoneNumber => '电话号码';

  @override
  String get labelCountry => '国家/地区';

  @override
  String get labelMccMnc => 'MCC-MNC (PLMN)';

  @override
  String get labelCarrierId => '运营商ID';

  @override
  String get labelSpecificCarrier => '具体运营商';

  @override
  String get labelSimState => 'SIM卡状态';

  @override
  String get labelSimType => 'SIM卡类型';

  @override
  String get labelSlot => '卡槽';

  @override
  String get labelPort => '端口';

  @override
  String get labelSubscriptionId => '订阅ID';

  @override
  String get labelOpportunistic => '机会性';

  @override
  String get labelMobileData => '移动数据';

  @override
  String get chipData => '数据';

  @override
  String get labelCalls => '通话';

  @override
  String get labelSms => '短信';

  @override
  String get labelNetworkType => '网络类型';

  @override
  String get labelVoiceNetwork => '语音网络';

  @override
  String get labelOperator => '网络运营商';

  @override
  String get labelOperatorCode => '运营商代码';

  @override
  String get labelNetworkCountry => '网络国家/地区';

  @override
  String get labelRoaming => '漫游';

  @override
  String get labelDataEnabled => '数据已启用';

  @override
  String get labelDataActivity => '数据活动';

  @override
  String get labelPhoneType => '电话类型';

  @override
  String get labelSignal => '信号';

  @override
  String get labelStatus => '状态';

  @override
  String get labelConnection => '连接';

  @override
  String get labelInternetAccess => '互联网访问';

  @override
  String get labelMetered => '按流量计费';

  @override
  String get labelLinkDown => '下行速度';

  @override
  String get labelLinkUp => '上行速度';

  @override
  String get labelInterface => '网络接口';

  @override
  String get labelDnsServer => 'DNS服务器';

  @override
  String get labelPrivateDns => '私人DNS';

  @override
  String get labelModel => '型号';

  @override
  String get labelDeviceCodename => '设备代号';

  @override
  String get labelAndroidVersion => 'Android版本';

  @override
  String get labelRadioVersion => '无线电 (IMEI SV)';

  @override
  String get labelTelephonyHardware => '电话硬件';

  @override
  String get labelSimCardPresent => '已插入SIM卡';

  @override
  String get labelEsimSupported => '支持eSIM';

  @override
  String get labelActiveModems => '活动调制解调器';

  @override
  String get labelSupportedModems => '支持的调制解调器';

  @override
  String get labelMaxActiveSims => '最多活动SIM卡数';

  @override
  String get labelDualSim => '双卡';

  @override
  String get labelVoiceCapable => '支持语音';

  @override
  String get labelSmsCapable => '支持短信';

  @override
  String get labelVoiceAndData => '语音与数据并发';

  @override
  String get yes => '是';

  @override
  String get no => '否';

  @override
  String get unavailable => '不可用';

  @override
  String get unknown => '未知';

  @override
  String get physicalSim => '实体SIM卡';

  @override
  String get esimEmbedded => 'eSIM（嵌入式）';

  @override
  String get defaultSim => '默认SIM卡';

  @override
  String get notDefault => '非默认';

  @override
  String get validated => '已验证';

  @override
  String get notValidated => '未验证';

  @override
  String get off => '关闭';

  @override
  String get noActiveNetwork => '无活动网络';

  @override
  String get noActiveSim => '没有可测量的活动SIM卡';

  @override
  String get noCellReported => '尚未检测到小区';

  @override
  String slotN(int n) {
    return '卡槽 $n';
  }

  @override
  String simN(int n) {
    return 'SIM $n';
  }

  @override
  String copied(String label) {
    return '已复制$label';
  }

  @override
  String get qualityExcellent => '极好';

  @override
  String get qualityGood => '良好';

  @override
  String get qualityFair => '一般';

  @override
  String get qualityPoor => '较差';

  @override
  String get qualityVeryPoor => '很差';

  @override
  String get signalNone => '无信号或未知';

  @override
  String get simStateReady => '就绪';

  @override
  String get simStateAbsent => '未插入';

  @override
  String get simStatePin => '需要PIN码';

  @override
  String get simStatePuk => '需要PUK码';

  @override
  String get simStateNetworkLocked => '网络锁定';

  @override
  String get simStateNotReady => '未就绪';

  @override
  String get simStateDisabled => '已永久停用';

  @override
  String get simStateIoError => '卡I/O错误';

  @override
  String get simStateRestricted => '卡受限';

  @override
  String get dataConnected => '已连接';

  @override
  String get dataDisconnected => '已断开';

  @override
  String get dataConnecting => '连接中';

  @override
  String get dataSuspended => '已暂停';

  @override
  String get dataDisconnecting => '断开中';

  @override
  String get activityIdle => '空闲';

  @override
  String get activityReceiving => '接收中';

  @override
  String get activitySending => '发送中';

  @override
  String get activityBoth => '收发中';

  @override
  String get activityDormant => '休眠';

  @override
  String get cellTowersExplainer =>
      '查看手机连接的基站——小区ID、区域码、PCI、频点和频段——以及邻近基站。Android 将小区ID视为位置数据，因此需要位置权限。该权限不用于任何其他用途，任何数据都不会离开您的设备。';

  @override
  String get showCellTowers => '显示基站';

  @override
  String get locationPermanent => '位置权限已被永久拒绝，只能在应用设置页面中开启。';

  @override
  String get dataUsageExplainer =>
      '查看此设备今天和本月使用的移动数据和 Wi-Fi 流量。Android 将这些数字保护在使用情况访问权限之后——点按下方，在列表中允许 SIM Card Info，然后返回。';

  @override
  String get grantUsageAccess => '授予使用情况访问权限';

  @override
  String get mobileToday => '移动数据（今天）';

  @override
  String get mobileMonth => '移动数据（本月）';

  @override
  String get wifiToday => 'Wi-Fi（今天）';

  @override
  String get wifiMonth => 'Wi-Fi（本月）';

  @override
  String get usageDisclaimer => '移动数据为所有SIM卡的总和——Android 不允许应用按SIM卡拆分用量。';

  @override
  String get latencyExplainer =>
      '通过当前连接测量到 Cloudflare、Google DNS 和 google.com 的往返时间。';

  @override
  String get runTest => '开始测试';

  @override
  String get runAgain => '再次测试';

  @override
  String get unreachable => '无法访问';

  @override
  String get shortcutMobile => '移动网络设置';

  @override
  String get shortcutDataUsage => '流量使用';

  @override
  String get shortcutWifi => 'Wi-Fi设置';

  @override
  String get shortcutAirplane => '飞行模式';

  @override
  String get themeLight => '浅色';

  @override
  String get themeSystem => '跟随系统';

  @override
  String get themeDark => '深色';

  @override
  String get shareFullReport => '分享完整报告';

  @override
  String get shareFullReportSubtitle => '以文本形式分享SIM卡、网络和设备详情';

  @override
  String get shareJson => '以JSON分享报告';

  @override
  String get shareJsonSubtitle => '机器可读，适用于工具和脚本';

  @override
  String get shareApp => '分享此应用';

  @override
  String shareAppText(String url) {
    return 'SIM卡信息——每张SIM卡的运营商、信号和网络详情。$url';
  }

  @override
  String get privacyOptions => '隐私选项';

  @override
  String get privacyOptionsSubtitle => '更改广告同意选择';

  @override
  String privacyOptionsFailed(String message) {
    return '无法打开隐私选项：$message';
  }

  @override
  String aboutVersion(String version) {
    return '版本 $version · Tahatec出品';
  }

  @override
  String get aboutBy => 'Tahatec出品';

  @override
  String get privacyNote => '所有SIM卡、网络和设备详情都直接从您设备上的Android读取，本应用不会将其上传到任何地方。';

  @override
  String sparklineCaption(int dbm, String window) {
    return '当前 $dbm dBm · 最近$window';
  }

  @override
  String get windowMinute => '1分钟';

  @override
  String windowMinutes(int n) {
    return '$n分钟';
  }
}
