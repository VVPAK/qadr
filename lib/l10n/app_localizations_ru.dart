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

  @override
  String get onboardingWelcomeBasmala =>
      'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';

  @override
  String get onboardingWelcomeHeadline1 => 'Спутник';

  @override
  String get onboardingWelcomeHeadline2 => 'вашего дня';

  @override
  String get onboardingWelcomeSubtitle =>
      'Намаз, Кибла, Коран и зикр — собранные в тишине.';

  @override
  String get onboardingWelcomeCta => 'Начать знакомство';

  @override
  String get onboardingNameSalam => 'Ассаламу алейкум';

  @override
  String get onboardingNameHeadline1 => 'Как к вам';

  @override
  String get onboardingNameHeadline2 => 'обращаться?';

  @override
  String get onboardingNameLabel => 'Имя';

  @override
  String get onboardingNamePlaceholder => 'Введите имя';

  @override
  String get onboardingNamePrivacy =>
      'Используется только локально — для приветствия в разделе «Намаз».';

  @override
  String get onboardingLocationStepLabel => 'Шаг 1 из 2 · разрешения';

  @override
  String get onboardingLocationHeadline1 => 'Где вы';

  @override
  String get onboardingLocationHeadline2 => 'читаете намаз?';

  @override
  String get onboardingLocationCardTitle => 'Определить город';

  @override
  String get onboardingLocationCardDesc =>
      'Для точного времени намаза и направления на Каабу.';

  @override
  String get onboardingLocationPrivacy =>
      'Qadr не сохраняет ваше местоположение. Оно остаётся на устройстве.';

  @override
  String get onboardingLocationAllow => 'Разрешить доступ';

  @override
  String get onboardingLocationManual => 'Выбрать город вручную';

  @override
  String get onboardingNotifsStepLabel => 'Шаг 2 из 2 · разрешения';

  @override
  String get onboardingNotifsHeadline1 => 'Тихое';

  @override
  String get onboardingNotifsHeadline2 => 'напоминание';

  @override
  String get onboardingNotifsSubtitle =>
      'Короткий азан за 5 минут до времени. Без шума и уведомлений-рекламы.';

  @override
  String get onboardingNotifsAllow => 'Включить напоминания';

  @override
  String get onboardingNotifsDecline => 'Не сейчас';

  @override
  String get onboardingBismillahReady => 'Готово';

  @override
  String onboardingBismillahReadyWithName(String name) {
    return 'Готово, $name';
  }

  @override
  String get onboardingBismillahArabic => 'بِسْمِ ٱللَّٰهِ';

  @override
  String get onboardingBismillahTranslation => 'С именем Аллаха — начнём.';

  @override
  String get onboardingBismillahHeadline1 => 'Пусть каждый';

  @override
  String get onboardingBismillahHeadline2 => 'намаз будет принят.';

  @override
  String get onboardingBismillahCta => 'Войти в Qadr';
}
