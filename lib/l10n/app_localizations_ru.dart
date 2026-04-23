// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Кадр';

  @override
  String get chat => 'Чат';

  @override
  String get settings => 'Настройки';

  @override
  String get quran => 'Коран';

  @override
  String get dua => 'Дуа';

  @override
  String get prayerTimes => 'Времена намаза';

  @override
  String get qibla => 'Кибла';

  @override
  String get tasbih => 'Тасбих';

  @override
  String get onboardingWelcome => 'Добро пожаловать в Qadr';

  @override
  String get onboardingLanguage => 'Выберите язык';

  @override
  String get onboardingMadhab => 'Выберите мазхаб';

  @override
  String get onboardingLocation => 'Разрешить доступ к геолокации';

  @override
  String get onboardingLocationDesc =>
      'Для точного расчёта намаза и направления Киблы';

  @override
  String get onboardingName => 'Как вас зовут?';

  @override
  String get onboardingNameHint => 'Необязательно';

  @override
  String get onboardingStart => 'Начать';

  @override
  String get next => 'Далее';

  @override
  String get back => 'Назад';

  @override
  String get skip => 'Пропустить';

  @override
  String get typeMessage => 'Введите сообщение...';

  @override
  String get hanafi => 'Ханафи';

  @override
  String get shafii => 'Шафии';

  @override
  String get maliki => 'Маликии';

  @override
  String get hanbali => 'Ханбали';

  @override
  String get fajr => 'Фаджр';

  @override
  String get sunrise => 'Восход';

  @override
  String get dhuhr => 'Зухр';

  @override
  String get asr => 'Аср';

  @override
  String get maghrib => 'Магриб';

  @override
  String get isha => 'Иша';

  @override
  String get infoNotFatwa => 'Это информация, а не фетва';

  @override
  String get offlineMode => 'Нет подключения. Показан кэшированный контент.';

  @override
  String get apiKeyRequired => 'Для AI-чата нужен API-ключ';

  @override
  String get language => 'Язык';

  @override
  String get madhab => 'Мазхаб';

  @override
  String get notifications => 'Уведомления';

  @override
  String get about => 'О приложении';

  @override
  String get done => 'Готово';

  @override
  String get yourLearningJourney => 'Ваш путь обучения';

  @override
  String percentComplete(int percent) {
    return '$percent% пройдено';
  }

  @override
  String continueLesson(String lessonTitle) {
    return 'Продолжить: $lessonTitle';
  }

  @override
  String get allLessonsComplete => 'Вы прошли все уроки!';

  @override
  String get meccan => 'Мекканская';

  @override
  String get medinan => 'Мединская';

  @override
  String ayahCount(int count) {
    return '$count аятов';
  }

  @override
  String get loadingQuran => 'Подготовка данных Корана...';

  @override
  String get discussInChat => 'Обсудить в чате';

  @override
  String get openInQuran => 'Открыть в Коране';

  @override
  String get prayer => 'Намаз';

  @override
  String get dhikr => 'Зикр';

  @override
  String get learn => 'Знание';

  @override
  String get surahs => 'Суры';

  @override
  String get library => 'Библиотека';

  @override
  String get recommended => 'Рекомендовано';

  @override
  String get continueReading => 'Продолжить';

  @override
  String get searchSurahOrAyah => 'Поиск суры или аята';

  @override
  String get reset => 'Сбросить';

  @override
  String get history => 'История';
}
