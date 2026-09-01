// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'SIM 카드 정보';

  @override
  String get tabSims => 'SIM';

  @override
  String get tabNetwork => '네트워크';

  @override
  String get tabDevice => '기기';

  @override
  String get tabSettings => '설정';

  @override
  String get titleSims => 'SIM 카드';

  @override
  String get tooltipShareReport => '보고서 공유';

  @override
  String get tooltipRefresh => '새로고침';

  @override
  String get gateTitle => '전화 권한이 필요합니다';

  @override
  String get gateBody =>
      'Android는 SIM과 네트워크 정보를 전화 권한으로 보호합니다. 모든 정보는 기기에서만 읽히며 절대 외부로 나가지 않습니다.';

  @override
  String get grantPermission => '권한 허용';

  @override
  String get openAppSettings => '앱 설정 열기';

  @override
  String get gatePermanent => '권한이 영구적으로 거부되어 앱 설정 화면에서만 켤 수 있습니다.';

  @override
  String get noSimsTitle => '활성화된 SIM 카드가 없습니다';

  @override
  String get noSimsBody =>
      '이 기기에 활성화된 SIM 또는 eSIM이 없습니다. SIM을 삽입하거나 eSIM을 활성화한 뒤 당겨서 새로고침하세요.';

  @override
  String get sectionSubscription => '가입 정보';

  @override
  String get sectionRoles => '역할';

  @override
  String get sectionCellular => '셀룰러';

  @override
  String get sectionServingCell => '접속 중인 셀';

  @override
  String get sectionNeighbours => '인접 셀';

  @override
  String get sectionCellTowers => '기지국';

  @override
  String get sectionDataUsage => '데이터 사용량';

  @override
  String get sectionActiveConnection => '활성 연결';

  @override
  String get sectionIpAddresses => 'IP 주소';

  @override
  String get sectionLatency => '지연 시간';

  @override
  String get sectionDevice => '기기';

  @override
  String get sectionSimCapabilities => 'SIM 기능';

  @override
  String get sectionCalling => '통화 및 메시지';

  @override
  String get sectionSystemSettings => '시스템 설정';

  @override
  String get sectionAppearance => '화면 모드';

  @override
  String get labelLanguage => '언어';

  @override
  String get systemDefault => '시스템 기본값';

  @override
  String get labelCarrier => '통신사';

  @override
  String get labelLabel => '라벨';

  @override
  String get labelPhoneNumber => '전화번호';

  @override
  String get labelCountry => '국가';

  @override
  String get labelMccMnc => 'MCC-MNC (PLMN)';

  @override
  String get labelCarrierId => '통신사 ID';

  @override
  String get labelSpecificCarrier => '세부 통신사';

  @override
  String get labelSimState => 'SIM 상태';

  @override
  String get labelSimType => 'SIM 유형';

  @override
  String get labelSlot => '슬롯';

  @override
  String get labelPort => '포트';

  @override
  String get labelSubscriptionId => '가입 ID';

  @override
  String get labelOpportunistic => '기회적';

  @override
  String get labelMobileData => '모바일 데이터';

  @override
  String get chipData => '데이터';

  @override
  String get labelCalls => '통화';

  @override
  String get labelSms => 'SMS';

  @override
  String get labelNetworkType => '네트워크 유형';

  @override
  String get labelVoiceNetwork => '음성 네트워크';

  @override
  String get labelOperator => '네트워크 사업자';

  @override
  String get labelOperatorCode => '사업자 코드';

  @override
  String get labelNetworkCountry => '네트워크 국가';

  @override
  String get labelRoaming => '로밍';

  @override
  String get labelDataEnabled => '데이터 사용';

  @override
  String get labelDataActivity => '데이터 활동';

  @override
  String get labelPhoneType => '전화 유형';

  @override
  String get labelSignal => '신호';

  @override
  String get labelStatus => '상태';

  @override
  String get labelConnection => '연결';

  @override
  String get labelInternetAccess => '인터넷 접속';

  @override
  String get labelMetered => '종량제';

  @override
  String get labelLinkDown => '다운로드 속도';

  @override
  String get labelLinkUp => '업로드 속도';

  @override
  String get labelInterface => '인터페이스';

  @override
  String get labelDnsServer => 'DNS 서버';

  @override
  String get labelPrivateDns => '비공개 DNS';

  @override
  String get labelModel => '모델';

  @override
  String get labelDeviceCodename => '기기 코드명';

  @override
  String get labelAndroidVersion => 'Android 버전';

  @override
  String get labelRadioVersion => '무선 (IMEI SV)';

  @override
  String get labelTelephonyHardware => '전화 하드웨어';

  @override
  String get labelSimCardPresent => 'SIM 카드 있음';

  @override
  String get labelEsimSupported => 'eSIM 지원';

  @override
  String get labelActiveModems => '활성 모뎀';

  @override
  String get labelSupportedModems => '지원 모뎀';

  @override
  String get labelMaxActiveSims => '최대 활성 SIM';

  @override
  String get labelDualSim => '듀얼 SIM';

  @override
  String get labelVoiceCapable => '음성 지원';

  @override
  String get labelSmsCapable => 'SMS 지원';

  @override
  String get labelVoiceAndData => '음성 + 데이터 동시';

  @override
  String get yes => '예';

  @override
  String get no => '아니요';

  @override
  String get unavailable => '사용 불가';

  @override
  String get unknown => '알 수 없음';

  @override
  String get physicalSim => '물리 SIM';

  @override
  String get esimEmbedded => 'eSIM (내장)';

  @override
  String get defaultSim => '기본 SIM';

  @override
  String get notDefault => '기본 아님';

  @override
  String get validated => '검증됨';

  @override
  String get notValidated => '검증 안 됨';

  @override
  String get off => '끔';

  @override
  String get noActiveNetwork => '활성 네트워크 없음';

  @override
  String get noActiveSim => '측정할 활성 SIM 없음';

  @override
  String get noCellReported => '아직 감지된 셀 없음';

  @override
  String slotN(int n) {
    return '슬롯 $n';
  }

  @override
  String simN(int n) {
    return 'SIM $n';
  }

  @override
  String copied(String label) {
    return '$label 복사됨';
  }

  @override
  String get qualityExcellent => '매우 좋음';

  @override
  String get qualityGood => '좋음';

  @override
  String get qualityFair => '보통';

  @override
  String get qualityPoor => '약함';

  @override
  String get qualityVeryPoor => '매우 약함';

  @override
  String get signalNone => '신호 없음 또는 알 수 없음';

  @override
  String get simStateReady => '준비됨';

  @override
  String get simStateAbsent => '없음';

  @override
  String get simStatePin => 'PIN 필요';

  @override
  String get simStatePuk => 'PUK 필요';

  @override
  String get simStateNetworkLocked => '네트워크 잠김';

  @override
  String get simStateNotReady => '준비 안 됨';

  @override
  String get simStateDisabled => '영구 비활성화';

  @override
  String get simStateIoError => '카드 I/O 오류';

  @override
  String get simStateRestricted => '카드 제한됨';

  @override
  String get dataConnected => '연결됨';

  @override
  String get dataDisconnected => '연결 끊김';

  @override
  String get dataConnecting => '연결 중';

  @override
  String get dataSuspended => '일시 중단';

  @override
  String get dataDisconnecting => '연결 해제 중';

  @override
  String get activityIdle => '유휴';

  @override
  String get activityReceiving => '수신 중';

  @override
  String get activitySending => '송신 중';

  @override
  String get activityBoth => '송수신 중';

  @override
  String get activityDormant => '휴면';

  @override
  String get cellTowersExplainer =>
      '휴대전화가 접속한 기지국(셀 ID, 지역 코드, PCI, 주파수 채널, 밴드)과 인접 기지국을 확인합니다. Android는 셀 ID를 위치 정보로 취급하므로 위치 권한이 필요합니다. 다른 용도로는 사용되지 않으며 어떤 정보도 기기를 벗어나지 않습니다.';

  @override
  String get showCellTowers => '기지국 표시';

  @override
  String get locationPermanent => '위치 권한이 영구적으로 거부되어 앱 설정 화면에서만 켤 수 있습니다.';

  @override
  String get dataUsageExplainer =>
      '이 기기가 오늘과 이번 달에 사용한 모바일 데이터와 Wi-Fi 양을 확인합니다. Android는 이 수치를 사용 정보 접근 설정으로 보호합니다. 아래를 누르고 목록에서 SIM Card Info를 허용한 뒤 돌아오세요.';

  @override
  String get grantUsageAccess => '사용 정보 접근 허용';

  @override
  String get mobileToday => '모바일 오늘';

  @override
  String get mobileMonth => '모바일 이번 달';

  @override
  String get wifiToday => 'Wi-Fi 오늘';

  @override
  String get wifiMonth => 'Wi-Fi 이번 달';

  @override
  String get usageDisclaimer =>
      '모바일은 모든 SIM의 합계입니다. Android는 앱이 SIM별로 사용량을 나누는 것을 허용하지 않습니다.';

  @override
  String get latencyExplainer =>
      '현재 연결로 Cloudflare, Google DNS, google.com까지의 왕복 시간을 측정합니다.';

  @override
  String get runTest => '테스트 실행';

  @override
  String get runAgain => '다시 실행';

  @override
  String get unreachable => '연결 불가';

  @override
  String get shortcutMobile => '모바일 네트워크 설정';

  @override
  String get shortcutDataUsage => '데이터 사용량';

  @override
  String get shortcutWifi => 'Wi-Fi 설정';

  @override
  String get shortcutAirplane => '비행기 모드';

  @override
  String get themeLight => '라이트';

  @override
  String get themeSystem => '시스템';

  @override
  String get themeDark => '다크';

  @override
  String get shareFullReport => '전체 보고서 공유';

  @override
  String get shareFullReportSubtitle => 'SIM, 네트워크, 기기 정보를 텍스트로';

  @override
  String get shareJson => '보고서를 JSON으로 공유';

  @override
  String get shareJsonSubtitle => '도구와 스크립트를 위한 기계 판독 형식';

  @override
  String get shareApp => '이 앱 공유';

  @override
  String shareAppText(String url) {
    return 'SIM 카드 정보 — 모든 SIM의 통신사, 신호, 네트워크 정보. $url';
  }

  @override
  String get privacyOptions => '개인정보 옵션';

  @override
  String get privacyOptionsSubtitle => '광고 동의 변경';

  @override
  String privacyOptionsFailed(String message) {
    return '개인정보 옵션을 열 수 없습니다: $message';
  }

  @override
  String aboutVersion(String version) {
    return '버전 $version · Tahatec';
  }

  @override
  String get aboutBy => 'Tahatec';

  @override
  String get privacyNote =>
      'SIM, 네트워크, 기기의 모든 정보는 기기의 Android에서 직접 읽히며 이 앱이 어디에도 업로드하지 않습니다.';

  @override
  String sparklineCaption(int dbm, String window) {
    return '현재 $dbm dBm · 최근 $window';
  }

  @override
  String get windowMinute => '1분';

  @override
  String windowMinutes(int n) {
    return '$n분';
  }
}
