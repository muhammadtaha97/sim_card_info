// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Информация о SIM-карте';

  @override
  String get tabSims => 'SIM';

  @override
  String get tabNetwork => 'Сеть';

  @override
  String get tabDevice => 'Устройство';

  @override
  String get tabSettings => 'Настройки';

  @override
  String get titleSims => 'SIM-карты';

  @override
  String get tooltipShareReport => 'Поделиться отчётом';

  @override
  String get tooltipRefresh => 'Обновить';

  @override
  String get gateTitle => 'Нужно разрешение «Телефон»';

  @override
  String get gateBody =>
      'Android защищает сведения о SIM и сети разрешением «Телефон». Всё читается на вашем устройстве и никогда его не покидает.';

  @override
  String get grantPermission => 'Дать разрешение';

  @override
  String get openAppSettings => 'Открыть настройки приложения';

  @override
  String get gatePermanent =>
      'Разрешение отклонено навсегда, включить его можно только в настройках приложения.';

  @override
  String get noSimsTitle => 'Нет активных SIM-карт';

  @override
  String get noSimsBody =>
      'На этом устройстве нет активной SIM или eSIM. Вставьте SIM или включите eSIM, затем потяните для обновления.';

  @override
  String get sectionSubscription => 'ПОДПИСКА';

  @override
  String get sectionRoles => 'РОЛИ';

  @override
  String get sectionCellular => 'СОТОВАЯ СЕТЬ';

  @override
  String get sectionServingCell => 'ОБСЛУЖИВАЮЩАЯ СОТА';

  @override
  String get sectionNeighbours => 'СОСЕДНИЕ СОТЫ';

  @override
  String get sectionCellTowers => 'БАЗОВЫЕ СТАНЦИИ';

  @override
  String get sectionDataUsage => 'РАСХОД ТРАФИКА';

  @override
  String get sectionActiveConnection => 'АКТИВНОЕ ПОДКЛЮЧЕНИЕ';

  @override
  String get sectionIpAddresses => 'IP-АДРЕСА';

  @override
  String get sectionLatency => 'ЗАДЕРЖКА';

  @override
  String get sectionDevice => 'УСТРОЙСТВО';

  @override
  String get sectionSimCapabilities => 'ВОЗМОЖНОСТИ SIM';

  @override
  String get sectionCalling => 'ЗВОНКИ И СООБЩЕНИЯ';

  @override
  String get sectionSystemSettings => 'СИСТЕМНЫЕ НАСТРОЙКИ';

  @override
  String get sectionAppearance => 'ОФОРМЛЕНИЕ';

  @override
  String get labelLanguage => 'Язык';

  @override
  String get systemDefault => 'Системный по умолчанию';

  @override
  String get labelCarrier => 'Оператор';

  @override
  String get labelLabel => 'Метка';

  @override
  String get labelPhoneNumber => 'Номер телефона';

  @override
  String get labelCountry => 'Страна';

  @override
  String get labelMccMnc => 'MCC-MNC (PLMN)';

  @override
  String get labelCarrierId => 'ID оператора';

  @override
  String get labelSpecificCarrier => 'Уточнённый оператор';

  @override
  String get labelSimState => 'Состояние SIM';

  @override
  String get labelSimType => 'Тип SIM';

  @override
  String get labelSlot => 'Слот';

  @override
  String get labelPort => 'Порт';

  @override
  String get labelSubscriptionId => 'ID подписки';

  @override
  String get labelOpportunistic => 'Оппортунистическая';

  @override
  String get labelMobileData => 'Мобильные данные';

  @override
  String get chipData => 'Данные';

  @override
  String get labelCalls => 'Звонки';

  @override
  String get labelSms => 'SMS';

  @override
  String get labelNetworkType => 'Тип сети';

  @override
  String get labelVoiceNetwork => 'Голосовая сеть';

  @override
  String get labelOperator => 'Оператор сети';

  @override
  String get labelOperatorCode => 'Код оператора';

  @override
  String get labelNetworkCountry => 'Страна сети';

  @override
  String get labelRoaming => 'Роуминг';

  @override
  String get labelDataEnabled => 'Данные включены';

  @override
  String get labelDataActivity => 'Активность данных';

  @override
  String get labelPhoneType => 'Тип телефона';

  @override
  String get labelSignal => 'Сигнал';

  @override
  String get labelStatus => 'Статус';

  @override
  String get labelConnection => 'Подключение';

  @override
  String get labelInternetAccess => 'Доступ в интернет';

  @override
  String get labelMetered => 'Лимитное';

  @override
  String get labelLinkDown => 'Скорость загрузки';

  @override
  String get labelLinkUp => 'Скорость отдачи';

  @override
  String get labelInterface => 'Интерфейс';

  @override
  String get labelDnsServer => 'DNS-сервер';

  @override
  String get labelPrivateDns => 'Приватный DNS';

  @override
  String get labelModel => 'Модель';

  @override
  String get labelDeviceCodename => 'Кодовое имя';

  @override
  String get labelAndroidVersion => 'Версия Android';

  @override
  String get labelRadioVersion => 'Радио (IMEI SV)';

  @override
  String get labelTelephonyHardware => 'Модуль телефонии';

  @override
  String get labelSimCardPresent => 'SIM-карта вставлена';

  @override
  String get labelEsimSupported => 'Поддержка eSIM';

  @override
  String get labelActiveModems => 'Активные модемы';

  @override
  String get labelSupportedModems => 'Поддерживаемые модемы';

  @override
  String get labelMaxActiveSims => 'Макс. активных SIM';

  @override
  String get labelDualSim => 'Две SIM';

  @override
  String get labelVoiceCapable => 'Голосовые вызовы';

  @override
  String get labelSmsCapable => 'Поддержка SMS';

  @override
  String get labelVoiceAndData => 'Голос и данные одновременно';

  @override
  String get yes => 'Да';

  @override
  String get no => 'Нет';

  @override
  String get unavailable => 'Недоступно';

  @override
  String get unknown => 'Неизвестно';

  @override
  String get physicalSim => 'Физическая SIM';

  @override
  String get esimEmbedded => 'eSIM (встроенная)';

  @override
  String get defaultSim => 'SIM по умолчанию';

  @override
  String get notDefault => 'Не по умолчанию';

  @override
  String get validated => 'Проверено';

  @override
  String get notValidated => 'Не проверено';

  @override
  String get off => 'Выключено';

  @override
  String get noActiveNetwork => 'Нет активной сети';

  @override
  String get noActiveSim => 'Нет активной SIM для измерения';

  @override
  String get noCellReported => 'Сота пока не обнаружена';

  @override
  String slotN(int n) {
    return 'Слот $n';
  }

  @override
  String simN(int n) {
    return 'SIM $n';
  }

  @override
  String copied(String label) {
    return '$label — скопировано';
  }

  @override
  String get qualityExcellent => 'Отличный';

  @override
  String get qualityGood => 'Хороший';

  @override
  String get qualityFair => 'Средний';

  @override
  String get qualityPoor => 'Слабый';

  @override
  String get qualityVeryPoor => 'Очень слабый';

  @override
  String get signalNone => 'Нет сигнала или неизвестно';

  @override
  String get simStateReady => 'Готова';

  @override
  String get simStateAbsent => 'Отсутствует';

  @override
  String get simStatePin => 'Требуется PIN';

  @override
  String get simStatePuk => 'Требуется PUK';

  @override
  String get simStateNetworkLocked => 'Заблокирована сетью';

  @override
  String get simStateNotReady => 'Не готова';

  @override
  String get simStateDisabled => 'Отключена навсегда';

  @override
  String get simStateIoError => 'Ошибка ввода-вывода карты';

  @override
  String get simStateRestricted => 'Карта ограничена';

  @override
  String get dataConnected => 'Подключено';

  @override
  String get dataDisconnected => 'Отключено';

  @override
  String get dataConnecting => 'Подключение';

  @override
  String get dataSuspended => 'Приостановлено';

  @override
  String get dataDisconnecting => 'Отключение';

  @override
  String get activityIdle => 'Простой';

  @override
  String get activityReceiving => 'Приём';

  @override
  String get activitySending => 'Передача';

  @override
  String get activityBoth => 'Приём и передача';

  @override
  String get activityDormant => 'Спящий режим';

  @override
  String get cellTowersExplainer =>
      'Смотрите, к какой базовой станции подключён телефон — Cell ID, код зоны, PCI, частотный канал и диапазоны — а также соседние станции. Android считает идентификатор соты данными о местоположении, поэтому нужно разрешение на геолокацию. Оно не используется ни для чего другого, и ничего не покидает ваше устройство.';

  @override
  String get showCellTowers => 'Показать базовые станции';

  @override
  String get locationPermanent =>
      'Геолокация отклонена навсегда, включить её можно только в настройках приложения.';

  @override
  String get dataUsageExplainer =>
      'Смотрите, сколько мобильного трафика и Wi-Fi устройство израсходовало сегодня и за месяц. Android скрывает эти цифры за настройкой доступа к данным об использовании — нажмите ниже, разрешите SIM Card Info в списке и вернитесь.';

  @override
  String get grantUsageAccess => 'Дать доступ к использованию';

  @override
  String get mobileToday => 'Мобильный за сегодня';

  @override
  String get mobileMonth => 'Мобильный за месяц';

  @override
  String get wifiToday => 'Wi-Fi за сегодня';

  @override
  String get wifiMonth => 'Wi-Fi за месяц';

  @override
  String get usageDisclaimer =>
      'Мобильный трафик — все SIM вместе: Android не позволяет приложениям делить расход по SIM.';

  @override
  String get latencyExplainer =>
      'Измеряет время до Cloudflare, Google DNS и google.com через текущее подключение.';

  @override
  String get runTest => 'Запустить тест';

  @override
  String get runAgain => 'Повторить';

  @override
  String get unreachable => 'Недостижим';

  @override
  String get shortcutMobile => 'Настройки мобильной сети';

  @override
  String get shortcutDataUsage => 'Расход трафика';

  @override
  String get shortcutWifi => 'Настройки Wi-Fi';

  @override
  String get shortcutAirplane => 'Режим полёта';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get shareFullReport => 'Поделиться полным отчётом';

  @override
  String get shareFullReportSubtitle =>
      'Сведения о SIM, сети и устройстве текстом';

  @override
  String get shareJson => 'Поделиться отчётом в JSON';

  @override
  String get shareJsonSubtitle =>
      'Машиночитаемый формат для инструментов и скриптов';

  @override
  String get shareApp => 'Поделиться приложением';

  @override
  String shareAppText(String url) {
    return 'Информация о SIM-карте — оператор, сигнал и сеть для каждой SIM. $url';
  }

  @override
  String get privacyOptions => 'Настройки конфиденциальности';

  @override
  String get privacyOptionsSubtitle => 'Изменить согласие на рекламу';

  @override
  String privacyOptionsFailed(String message) {
    return 'Не удалось открыть настройки конфиденциальности: $message';
  }

  @override
  String aboutVersion(String version) {
    return 'Версия $version · от Tahatec';
  }

  @override
  String get aboutBy => 'от Tahatec';

  @override
  String get privacyNote =>
      'Все сведения о SIM, сети и устройстве читаются напрямую из Android на вашем устройстве, и это приложение никуда их не отправляет.';

  @override
  String sparklineCaption(int dbm, String window) {
    return '$dbm dBm сейчас · последние $window';
  }

  @override
  String get windowMinute => 'минута';

  @override
  String windowMinutes(int n) {
    return '$n мин';
  }
}
