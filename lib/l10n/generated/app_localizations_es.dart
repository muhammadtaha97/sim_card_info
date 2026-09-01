// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Info de la tarjeta SIM';

  @override
  String get tabSims => 'SIMs';

  @override
  String get tabNetwork => 'Red';

  @override
  String get tabDevice => 'Dispositivo';

  @override
  String get tabSettings => 'Ajustes';

  @override
  String get titleSims => 'Tarjetas SIM';

  @override
  String get tooltipShareReport => 'Compartir informe';

  @override
  String get tooltipRefresh => 'Actualizar';

  @override
  String get gateTitle => 'Se necesita el permiso de teléfono';

  @override
  String get gateBody =>
      'Android protege los datos de la SIM y de la red con el permiso de teléfono. Todo se lee en tu dispositivo y nunca sale de él.';

  @override
  String get grantPermission => 'Conceder permiso';

  @override
  String get openAppSettings => 'Abrir ajustes de la app';

  @override
  String get gatePermanent =>
      'El permiso fue denegado permanentemente, así que solo puede activarse desde los ajustes de la app.';

  @override
  String get noSimsTitle => 'No hay tarjetas SIM activas';

  @override
  String get noSimsBody =>
      'No hay ninguna SIM o eSIM activa en este dispositivo. Inserta una SIM o activa una eSIM y desliza para actualizar.';

  @override
  String get sectionSubscription => 'SUSCRIPCIÓN';

  @override
  String get sectionRoles => 'FUNCIONES';

  @override
  String get sectionCellular => 'RED MÓVIL';

  @override
  String get sectionServingCell => 'CELDA EN USO';

  @override
  String get sectionNeighbours => 'CELDAS VECINAS';

  @override
  String get sectionCellTowers => 'TORRES DE TELEFONÍA';

  @override
  String get sectionDataUsage => 'USO DE DATOS';

  @override
  String get sectionActiveConnection => 'CONEXIÓN ACTIVA';

  @override
  String get sectionIpAddresses => 'DIRECCIONES IP';

  @override
  String get sectionLatency => 'LATENCIA';

  @override
  String get sectionDevice => 'DISPOSITIVO';

  @override
  String get sectionSimCapabilities => 'CAPACIDADES SIM';

  @override
  String get sectionCalling => 'LLAMADAS Y MENSAJES';

  @override
  String get sectionSystemSettings => 'AJUSTES DEL SISTEMA';

  @override
  String get sectionAppearance => 'APARIENCIA';

  @override
  String get labelLanguage => 'Idioma';

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get labelCarrier => 'Operador';

  @override
  String get labelLabel => 'Etiqueta';

  @override
  String get labelPhoneNumber => 'Número de teléfono';

  @override
  String get labelCountry => 'País';

  @override
  String get labelMccMnc => 'MCC-MNC (PLMN)';

  @override
  String get labelCarrierId => 'ID del operador';

  @override
  String get labelSpecificCarrier => 'Operador específico';

  @override
  String get labelSimState => 'Estado de la SIM';

  @override
  String get labelSimType => 'Tipo de SIM';

  @override
  String get labelSlot => 'Ranura';

  @override
  String get labelPort => 'Puerto';

  @override
  String get labelSubscriptionId => 'ID de suscripción';

  @override
  String get labelOpportunistic => 'Oportunista';

  @override
  String get labelMobileData => 'Datos móviles';

  @override
  String get chipData => 'Datos';

  @override
  String get labelCalls => 'Llamadas';

  @override
  String get labelSms => 'SMS';

  @override
  String get labelNetworkType => 'Tipo de red';

  @override
  String get labelVoiceNetwork => 'Red de voz';

  @override
  String get labelOperator => 'Operador de red';

  @override
  String get labelOperatorCode => 'Código del operador';

  @override
  String get labelNetworkCountry => 'País de la red';

  @override
  String get labelRoaming => 'Itinerancia';

  @override
  String get labelDataEnabled => 'Datos activados';

  @override
  String get labelDataActivity => 'Actividad de datos';

  @override
  String get labelPhoneType => 'Tipo de teléfono';

  @override
  String get labelSignal => 'Señal';

  @override
  String get labelStatus => 'Estado';

  @override
  String get labelConnection => 'Conexión';

  @override
  String get labelInternetAccess => 'Acceso a Internet';

  @override
  String get labelMetered => 'De uso medido';

  @override
  String get labelLinkDown => 'Velocidad de bajada';

  @override
  String get labelLinkUp => 'Velocidad de subida';

  @override
  String get labelInterface => 'Interfaz';

  @override
  String get labelDnsServer => 'Servidor DNS';

  @override
  String get labelPrivateDns => 'DNS privado';

  @override
  String get labelModel => 'Modelo';

  @override
  String get labelDeviceCodename => 'Nombre en clave';

  @override
  String get labelAndroidVersion => 'Versión de Android';

  @override
  String get labelRadioVersion => 'Radio (IMEI SV)';

  @override
  String get labelTelephonyHardware => 'Hardware de telefonía';

  @override
  String get labelSimCardPresent => 'SIM presente';

  @override
  String get labelEsimSupported => 'Compatible con eSIM';

  @override
  String get labelActiveModems => 'Módems activos';

  @override
  String get labelSupportedModems => 'Módems compatibles';

  @override
  String get labelMaxActiveSims => 'Máx. de SIMs activas';

  @override
  String get labelDualSim => 'SIM dual';

  @override
  String get labelVoiceCapable => 'Con voz';

  @override
  String get labelSmsCapable => 'Con SMS';

  @override
  String get labelVoiceAndData => 'Voz y datos a la vez';

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get unavailable => 'No disponible';

  @override
  String get unknown => 'Desconocido';

  @override
  String get physicalSim => 'SIM física';

  @override
  String get esimEmbedded => 'eSIM (integrada)';

  @override
  String get defaultSim => 'SIM predeterminada';

  @override
  String get notDefault => 'No predeterminada';

  @override
  String get validated => 'Validado';

  @override
  String get notValidated => 'Sin validar';

  @override
  String get off => 'Desactivado';

  @override
  String get noActiveNetwork => 'Sin red activa';

  @override
  String get noActiveSim => 'No hay SIM activa que medir';

  @override
  String get noCellReported => 'Aún no se detecta ninguna celda';

  @override
  String slotN(int n) {
    return 'Ranura $n';
  }

  @override
  String simN(int n) {
    return 'SIM $n';
  }

  @override
  String copied(String label) {
    return '$label copiado';
  }

  @override
  String get qualityExcellent => 'Excelente';

  @override
  String get qualityGood => 'Buena';

  @override
  String get qualityFair => 'Regular';

  @override
  String get qualityPoor => 'Débil';

  @override
  String get qualityVeryPoor => 'Muy débil';

  @override
  String get signalNone => 'Sin señal o desconocida';

  @override
  String get simStateReady => 'Lista';

  @override
  String get simStateAbsent => 'Ausente';

  @override
  String get simStatePin => 'PIN requerido';

  @override
  String get simStatePuk => 'PUK requerido';

  @override
  String get simStateNetworkLocked => 'Bloqueada por la red';

  @override
  String get simStateNotReady => 'No lista';

  @override
  String get simStateDisabled => 'Desactivada permanentemente';

  @override
  String get simStateIoError => 'Error de E/S de la tarjeta';

  @override
  String get simStateRestricted => 'Tarjeta restringida';

  @override
  String get dataConnected => 'Conectado';

  @override
  String get dataDisconnected => 'Desconectado';

  @override
  String get dataConnecting => 'Conectando';

  @override
  String get dataSuspended => 'Suspendido';

  @override
  String get dataDisconnecting => 'Desconectando';

  @override
  String get activityIdle => 'Inactivo';

  @override
  String get activityReceiving => 'Recibiendo';

  @override
  String get activitySending => 'Enviando';

  @override
  String get activityBoth => 'Enviando y recibiendo';

  @override
  String get activityDormant => 'En reposo';

  @override
  String get cellTowersExplainer =>
      'Consulta la torre a la que está conectado tu teléfono — Cell ID, código de área, PCI, canal de frecuencia y bandas — además de las torres vecinas. Android considera el id de celda un dato de ubicación, así que se necesita el permiso de ubicación. No se usa para nada más y nada sale de tu dispositivo.';

  @override
  String get showCellTowers => 'Mostrar torres';

  @override
  String get locationPermanent =>
      'La ubicación fue denegada permanentemente, así que solo puede activarse desde los ajustes de la app.';

  @override
  String get dataUsageExplainer =>
      'Consulta cuántos datos móviles y Wi-Fi ha usado este dispositivo hoy y este mes. Android guarda estas cifras tras el ajuste de acceso al uso — toca abajo, permite SIM Card Info en la lista y vuelve.';

  @override
  String get grantUsageAccess => 'Conceder acceso al uso';

  @override
  String get mobileToday => 'Móvil hoy';

  @override
  String get mobileMonth => 'Móvil este mes';

  @override
  String get wifiToday => 'Wi-Fi hoy';

  @override
  String get wifiMonth => 'Wi-Fi este mes';

  @override
  String get usageDisclaimer =>
      'Móvil incluye todas las SIMs juntas — Android no permite separar el uso por SIM.';

  @override
  String get latencyExplainer =>
      'Mide el tiempo de ida y vuelta a Cloudflare, Google DNS y google.com con la conexión actual.';

  @override
  String get runTest => 'Ejecutar prueba';

  @override
  String get runAgain => 'Repetir prueba';

  @override
  String get unreachable => 'Inaccesible';

  @override
  String get shortcutMobile => 'Ajustes de red móvil';

  @override
  String get shortcutDataUsage => 'Uso de datos';

  @override
  String get shortcutWifi => 'Ajustes de Wi-Fi';

  @override
  String get shortcutAirplane => 'Modo avión';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get shareFullReport => 'Compartir informe completo';

  @override
  String get shareFullReportSubtitle =>
      'Datos de SIM, red y dispositivo como texto';

  @override
  String get shareJson => 'Compartir informe en JSON';

  @override
  String get shareJsonSubtitle =>
      'Legible por máquinas, para herramientas y scripts';

  @override
  String get shareApp => 'Compartir esta app';

  @override
  String shareAppText(String url) {
    return 'Info de la tarjeta SIM — operador, señal y red de cada SIM. $url';
  }

  @override
  String get privacyOptions => 'Opciones de privacidad';

  @override
  String get privacyOptionsSubtitle => 'Cambia tu consentimiento de anuncios';

  @override
  String privacyOptionsFailed(String message) {
    return 'No se pudieron abrir las opciones de privacidad: $message';
  }

  @override
  String aboutVersion(String version) {
    return 'Versión $version · de Tahatec';
  }

  @override
  String get aboutBy => 'de Tahatec';

  @override
  String get privacyNote =>
      'Todos los datos de SIM, red y dispositivo se leen directamente de Android en tu dispositivo y esta app no los sube a ninguna parte.';

  @override
  String sparklineCaption(int dbm, String window) {
    return '$dbm dBm ahora · últimos $window';
  }

  @override
  String get windowMinute => '1 min';

  @override
  String windowMinutes(int n) {
    return '$n min';
  }
}
