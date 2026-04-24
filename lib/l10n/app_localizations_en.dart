// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Qadr';

  @override
  String get chat => 'Chat';

  @override
  String get settings => 'Settings';

  @override
  String get quran => 'Quran';

  @override
  String get dua => 'Dua';

  @override
  String get prayerTimes => 'Prayer Times';

  @override
  String get qibla => 'Qibla';

  @override
  String get tasbih => 'Tasbih';

  @override
  String get onboardingWelcome => 'Welcome to Qadr';

  @override
  String get onboardingLanguage => 'Choose your language';

  @override
  String get onboardingMadhab => 'Select your madhab';

  @override
  String get onboardingLocation => 'Allow location access';

  @override
  String get onboardingLocationDesc =>
      'For accurate prayer times and Qibla direction';

  @override
  String get onboardingName => 'What\'s your name?';

  @override
  String get onboardingNameHint => 'Optional';

  @override
  String get onboardingStart => 'Get Started';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get skip => 'Skip';

  @override
  String get typeMessage => 'Type a message...';

  @override
  String get hanafi => 'Hanafi';

  @override
  String get shafii => 'Shafi\'i';

  @override
  String get maliki => 'Maliki';

  @override
  String get hanbali => 'Hanbali';

  @override
  String get fajr => 'Fajr';

  @override
  String get sunrise => 'Sunrise';

  @override
  String get dhuhr => 'Dhuhr';

  @override
  String get asr => 'Asr';

  @override
  String get maghrib => 'Maghrib';

  @override
  String get isha => 'Isha';

  @override
  String get infoNotFatwa => 'This is information, not a fatwa';

  @override
  String get offlineMode => 'You are offline. Showing cached content.';

  @override
  String get apiKeyRequired => 'API key required for AI chat';

  @override
  String get language => 'Language';

  @override
  String get madhab => 'Madhab';

  @override
  String get notifications => 'Notifications';

  @override
  String get about => 'About';

  @override
  String get done => 'Done';

  @override
  String get yourLearningJourney => 'Your Learning Journey';

  @override
  String percentComplete(int percent) {
    return '$percent% complete';
  }

  @override
  String continueLesson(String lessonTitle) {
    return 'Continue: $lessonTitle';
  }

  @override
  String get allLessonsComplete => 'You have completed all lessons!';

  @override
  String get meccan => 'Meccan';

  @override
  String get medinan => 'Medinan';

  @override
  String ayahCount(int count) {
    return '$count ayahs';
  }

  @override
  String get loadingQuran => 'Preparing Quran data...';

  @override
  String get discussInChat => 'Discuss in chat';

  @override
  String get openInQuran => 'Open in Quran';

  @override
  String get prayer => 'Prayer';

  @override
  String get dhikr => 'Dhikr';

  @override
  String get learn => 'Knowledge';

  @override
  String get surahs => 'Surahs';

  @override
  String get library => 'Library';

  @override
  String get recommended => 'Recommended';

  @override
  String get continueReading => 'Continue';

  @override
  String get searchSurahOrAyah => 'Search surah or ayah';

  @override
  String get reset => 'Reset';

  @override
  String get history => 'History';

  @override
  String get onboardingWelcomeBasmala =>
      'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';

  @override
  String get onboardingWelcomeHeadline1 => 'A companion';

  @override
  String get onboardingWelcomeHeadline2 => 'for your day';

  @override
  String get onboardingWelcomeSubtitle =>
      'Prayer, Qibla, Quran and dhikr — gathered in stillness.';

  @override
  String get onboardingWelcomeCta => 'Begin';

  @override
  String get onboardingNameSalam => 'As-salamu alaykum';

  @override
  String get onboardingNameHeadline1 => 'How shall we';

  @override
  String get onboardingNameHeadline2 => 'address you?';

  @override
  String get onboardingNameLabel => 'Name';

  @override
  String get onboardingNamePlaceholder => 'Enter your name';

  @override
  String get onboardingNamePrivacy =>
      'Used only locally — to greet you in the Prayer section.';

  @override
  String get onboardingLocationStepLabel => 'Step 1 of 2 · permissions';

  @override
  String get onboardingLocationHeadline1 => 'Where are';

  @override
  String get onboardingLocationHeadline2 => 'you praying?';

  @override
  String get onboardingLocationCardTitle => 'Detect city';

  @override
  String get onboardingLocationCardDesc =>
      'For accurate prayer times and direction to the Kaaba.';

  @override
  String get onboardingLocationPrivacy =>
      'Qadr does not store your location. It stays on your device.';

  @override
  String get onboardingLocationAllow => 'Allow access';

  @override
  String get onboardingLocationManual => 'Choose city manually';

  @override
  String get onboardingNotifsStepLabel => 'Step 2 of 2 · permissions';

  @override
  String get onboardingNotifsHeadline1 => 'A quiet';

  @override
  String get onboardingNotifsHeadline2 => 'reminder';

  @override
  String get onboardingNotifsSubtitle =>
      'A short adhan five minutes before each prayer. No noise, no ads.';

  @override
  String get onboardingNotifsAllow => 'Enable reminders';

  @override
  String get onboardingNotifsDecline => 'Not now';

  @override
  String get onboardingBismillahReady => 'Ready';

  @override
  String onboardingBismillahReadyWithName(String name) {
    return 'Ready, $name';
  }

  @override
  String get onboardingBismillahArabic => 'بِسْمِ ٱللَّٰهِ';

  @override
  String get onboardingBismillahTranslation =>
      'In the name of Allah — let us begin.';

  @override
  String get onboardingBismillahHeadline1 => 'May every';

  @override
  String get onboardingBismillahHeadline2 => 'prayer be accepted.';

  @override
  String get onboardingBismillahCta => 'Enter Qadr';

  @override
  String get kaaba => 'Kaaba';

  @override
  String degreesFromNorth(int degrees) {
    return '$degrees° from north';
  }

  @override
  String get facingKaaba => 'Facing the Kaaba';

  @override
  String get turnRight => 'right';

  @override
  String get turnLeft => 'left';

  @override
  String get compassUnavailable => 'Compass unavailable on this device';

  @override
  String get calibrateCompass => 'Move your phone in a figure-8 to calibrate';

  @override
  String get calibrationHigh => 'Calibration accuracy: high';

  @override
  String get calibrationMedium => 'Calibration accuracy: medium';

  @override
  String get calibrationLow => 'Calibration accuracy: low — calibrate';

  @override
  String get qiblaLocationTitle => 'Allow location access';

  @override
  String get qiblaLocationDesc =>
      'Your location is needed to point the arrow towards the Kaaba.';

  @override
  String get detectLocation => 'Detect location';

  @override
  String get aiChat => 'AI Chat';

  @override
  String get apiBaseUrl => 'API Base URL';

  @override
  String get apiKey => 'API Key';

  @override
  String get saveApiSettings => 'Save API Settings';

  @override
  String get apiSettingsSaved => 'API settings saved';

  @override
  String ofTarget(int target) {
    return 'of $target';
  }

  @override
  String get compassN => 'N';

  @override
  String get compassE => 'E';

  @override
  String get compassS => 'S';

  @override
  String get compassW => 'W';

  @override
  String lessonCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lessons',
      one: '$count lesson',
    );
    return '$_temp0';
  }

  @override
  String stepCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count steps',
      one: '$count step',
    );
    return '$_temp0';
  }
}
