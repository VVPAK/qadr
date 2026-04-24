import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Qadr'**
  String get appTitle;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @quran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quran;

  /// No description provided for @dua.
  ///
  /// In en, this message translates to:
  /// **'Dua'**
  String get dua;

  /// No description provided for @prayerTimes.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayerTimes;

  /// No description provided for @qibla.
  ///
  /// In en, this message translates to:
  /// **'Qibla'**
  String get qibla;

  /// No description provided for @tasbih.
  ///
  /// In en, this message translates to:
  /// **'Tasbih'**
  String get tasbih;

  /// No description provided for @onboardingWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Qadr'**
  String get onboardingWelcome;

  /// No description provided for @onboardingLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get onboardingLanguage;

  /// No description provided for @onboardingMadhab.
  ///
  /// In en, this message translates to:
  /// **'Select your madhab'**
  String get onboardingMadhab;

  /// No description provided for @onboardingLocation.
  ///
  /// In en, this message translates to:
  /// **'Allow location access'**
  String get onboardingLocation;

  /// No description provided for @onboardingLocationDesc.
  ///
  /// In en, this message translates to:
  /// **'For accurate prayer times and Qibla direction'**
  String get onboardingLocationDesc;

  /// No description provided for @onboardingName.
  ///
  /// In en, this message translates to:
  /// **'What\'s your name?'**
  String get onboardingName;

  /// No description provided for @onboardingNameHint.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get onboardingNameHint;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingStart;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @typeMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get typeMessage;

  /// No description provided for @hanafi.
  ///
  /// In en, this message translates to:
  /// **'Hanafi'**
  String get hanafi;

  /// No description provided for @shafii.
  ///
  /// In en, this message translates to:
  /// **'Shafi\'i'**
  String get shafii;

  /// No description provided for @maliki.
  ///
  /// In en, this message translates to:
  /// **'Maliki'**
  String get maliki;

  /// No description provided for @hanbali.
  ///
  /// In en, this message translates to:
  /// **'Hanbali'**
  String get hanbali;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @sunrise.
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunrise;

  /// No description provided for @dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// No description provided for @infoNotFatwa.
  ///
  /// In en, this message translates to:
  /// **'This is information, not a fatwa'**
  String get infoNotFatwa;

  /// No description provided for @offlineMode.
  ///
  /// In en, this message translates to:
  /// **'You are offline. Showing cached content.'**
  String get offlineMode;

  /// No description provided for @apiKeyRequired.
  ///
  /// In en, this message translates to:
  /// **'API key required for AI chat'**
  String get apiKeyRequired;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @madhab.
  ///
  /// In en, this message translates to:
  /// **'Madhab'**
  String get madhab;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @yourLearningJourney.
  ///
  /// In en, this message translates to:
  /// **'Your Learning Journey'**
  String get yourLearningJourney;

  /// No description provided for @percentComplete.
  ///
  /// In en, this message translates to:
  /// **'{percent}% complete'**
  String percentComplete(int percent);

  /// No description provided for @continueLesson.
  ///
  /// In en, this message translates to:
  /// **'Continue: {lessonTitle}'**
  String continueLesson(String lessonTitle);

  /// No description provided for @allLessonsComplete.
  ///
  /// In en, this message translates to:
  /// **'You have completed all lessons!'**
  String get allLessonsComplete;

  /// No description provided for @meccan.
  ///
  /// In en, this message translates to:
  /// **'Meccan'**
  String get meccan;

  /// No description provided for @medinan.
  ///
  /// In en, this message translates to:
  /// **'Medinan'**
  String get medinan;

  /// No description provided for @ayahCount.
  ///
  /// In en, this message translates to:
  /// **'{count} ayahs'**
  String ayahCount(int count);

  /// No description provided for @loadingQuran.
  ///
  /// In en, this message translates to:
  /// **'Preparing Quran data...'**
  String get loadingQuran;

  /// No description provided for @discussInChat.
  ///
  /// In en, this message translates to:
  /// **'Discuss in chat'**
  String get discussInChat;

  /// No description provided for @openInQuran.
  ///
  /// In en, this message translates to:
  /// **'Open in Quran'**
  String get openInQuran;

  /// No description provided for @prayer.
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get prayer;

  /// No description provided for @dhikr.
  ///
  /// In en, this message translates to:
  /// **'Dhikr'**
  String get dhikr;

  /// No description provided for @learn.
  ///
  /// In en, this message translates to:
  /// **'Knowledge'**
  String get learn;

  /// No description provided for @surahs.
  ///
  /// In en, this message translates to:
  /// **'Surahs'**
  String get surahs;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get recommended;

  /// No description provided for @continueReading.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueReading;

  /// No description provided for @searchSurahOrAyah.
  ///
  /// In en, this message translates to:
  /// **'Search surah or ayah'**
  String get searchSurahOrAyah;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @onboardingWelcomeBasmala.
  ///
  /// In en, this message translates to:
  /// **'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ'**
  String get onboardingWelcomeBasmala;

  /// No description provided for @onboardingWelcomeHeadline1.
  ///
  /// In en, this message translates to:
  /// **'A companion'**
  String get onboardingWelcomeHeadline1;

  /// No description provided for @onboardingWelcomeHeadline2.
  ///
  /// In en, this message translates to:
  /// **'for your day'**
  String get onboardingWelcomeHeadline2;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Prayer, Qibla, Quran and dhikr — gathered in stillness.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingWelcomeCta.
  ///
  /// In en, this message translates to:
  /// **'Begin'**
  String get onboardingWelcomeCta;

  /// No description provided for @onboardingNameSalam.
  ///
  /// In en, this message translates to:
  /// **'As-salamu alaykum'**
  String get onboardingNameSalam;

  /// No description provided for @onboardingNameHeadline1.
  ///
  /// In en, this message translates to:
  /// **'How shall we'**
  String get onboardingNameHeadline1;

  /// No description provided for @onboardingNameHeadline2.
  ///
  /// In en, this message translates to:
  /// **'address you?'**
  String get onboardingNameHeadline2;

  /// No description provided for @onboardingNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get onboardingNameLabel;

  /// No description provided for @onboardingNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get onboardingNamePlaceholder;

  /// No description provided for @onboardingNamePrivacy.
  ///
  /// In en, this message translates to:
  /// **'Used only locally — to greet you in the Prayer section.'**
  String get onboardingNamePrivacy;

  /// No description provided for @onboardingLocationStepLabel.
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 2 · permissions'**
  String get onboardingLocationStepLabel;

  /// No description provided for @onboardingLocationHeadline1.
  ///
  /// In en, this message translates to:
  /// **'Where are'**
  String get onboardingLocationHeadline1;

  /// No description provided for @onboardingLocationHeadline2.
  ///
  /// In en, this message translates to:
  /// **'you praying?'**
  String get onboardingLocationHeadline2;

  /// No description provided for @onboardingLocationCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Detect city'**
  String get onboardingLocationCardTitle;

  /// No description provided for @onboardingLocationCardDesc.
  ///
  /// In en, this message translates to:
  /// **'For accurate prayer times and direction to the Kaaba.'**
  String get onboardingLocationCardDesc;

  /// No description provided for @onboardingLocationPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Qadr does not store your location. It stays on your device.'**
  String get onboardingLocationPrivacy;

  /// No description provided for @onboardingLocationAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow access'**
  String get onboardingLocationAllow;

  /// No description provided for @onboardingLocationManual.
  ///
  /// In en, this message translates to:
  /// **'Choose city manually'**
  String get onboardingLocationManual;

  /// No description provided for @onboardingNotifsStepLabel.
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 2 · permissions'**
  String get onboardingNotifsStepLabel;

  /// No description provided for @onboardingNotifsHeadline1.
  ///
  /// In en, this message translates to:
  /// **'A quiet'**
  String get onboardingNotifsHeadline1;

  /// No description provided for @onboardingNotifsHeadline2.
  ///
  /// In en, this message translates to:
  /// **'reminder'**
  String get onboardingNotifsHeadline2;

  /// No description provided for @onboardingNotifsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A short adhan five minutes before each prayer. No noise, no ads.'**
  String get onboardingNotifsSubtitle;

  /// No description provided for @onboardingNotifsAllow.
  ///
  /// In en, this message translates to:
  /// **'Enable reminders'**
  String get onboardingNotifsAllow;

  /// No description provided for @onboardingNotifsDecline.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get onboardingNotifsDecline;

  /// No description provided for @onboardingBismillahReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get onboardingBismillahReady;

  /// No description provided for @onboardingBismillahReadyWithName.
  ///
  /// In en, this message translates to:
  /// **'Ready, {name}'**
  String onboardingBismillahReadyWithName(String name);

  /// No description provided for @onboardingBismillahArabic.
  ///
  /// In en, this message translates to:
  /// **'بِسْمِ ٱللَّٰهِ'**
  String get onboardingBismillahArabic;

  /// No description provided for @onboardingBismillahTranslation.
  ///
  /// In en, this message translates to:
  /// **'In the name of Allah — let us begin.'**
  String get onboardingBismillahTranslation;

  /// No description provided for @onboardingBismillahHeadline1.
  ///
  /// In en, this message translates to:
  /// **'May every'**
  String get onboardingBismillahHeadline1;

  /// No description provided for @onboardingBismillahHeadline2.
  ///
  /// In en, this message translates to:
  /// **'prayer be accepted.'**
  String get onboardingBismillahHeadline2;

  /// No description provided for @onboardingBismillahCta.
  ///
  /// In en, this message translates to:
  /// **'Enter Qadr'**
  String get onboardingBismillahCta;

  /// No description provided for @kaaba.
  ///
  /// In en, this message translates to:
  /// **'Kaaba'**
  String get kaaba;

  /// No description provided for @degreesFromNorth.
  ///
  /// In en, this message translates to:
  /// **'{degrees}° from north'**
  String degreesFromNorth(int degrees);

  /// No description provided for @facingKaaba.
  ///
  /// In en, this message translates to:
  /// **'Facing the Kaaba'**
  String get facingKaaba;

  /// No description provided for @turnRight.
  ///
  /// In en, this message translates to:
  /// **'right'**
  String get turnRight;

  /// No description provided for @turnLeft.
  ///
  /// In en, this message translates to:
  /// **'left'**
  String get turnLeft;

  /// No description provided for @compassUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Compass unavailable on this device'**
  String get compassUnavailable;

  /// No description provided for @calibrateCompass.
  ///
  /// In en, this message translates to:
  /// **'Move your phone in a figure-8 to calibrate'**
  String get calibrateCompass;

  /// No description provided for @calibrationHigh.
  ///
  /// In en, this message translates to:
  /// **'Calibration accuracy: high'**
  String get calibrationHigh;

  /// No description provided for @calibrationMedium.
  ///
  /// In en, this message translates to:
  /// **'Calibration accuracy: medium'**
  String get calibrationMedium;

  /// No description provided for @calibrationLow.
  ///
  /// In en, this message translates to:
  /// **'Calibration accuracy: low — calibrate'**
  String get calibrationLow;

  /// No description provided for @qiblaLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow location access'**
  String get qiblaLocationTitle;

  /// No description provided for @qiblaLocationDesc.
  ///
  /// In en, this message translates to:
  /// **'Your location is needed to point the arrow towards the Kaaba.'**
  String get qiblaLocationDesc;

  /// No description provided for @detectLocation.
  ///
  /// In en, this message translates to:
  /// **'Detect location'**
  String get detectLocation;

  /// No description provided for @aiChat.
  ///
  /// In en, this message translates to:
  /// **'AI Chat'**
  String get aiChat;

  /// No description provided for @apiBaseUrl.
  ///
  /// In en, this message translates to:
  /// **'API Base URL'**
  String get apiBaseUrl;

  /// No description provided for @apiKey.
  ///
  /// In en, this message translates to:
  /// **'API Key'**
  String get apiKey;

  /// No description provided for @saveApiSettings.
  ///
  /// In en, this message translates to:
  /// **'Save API Settings'**
  String get saveApiSettings;

  /// No description provided for @apiSettingsSaved.
  ///
  /// In en, this message translates to:
  /// **'API settings saved'**
  String get apiSettingsSaved;

  /// No description provided for @ofTarget.
  ///
  /// In en, this message translates to:
  /// **'of {target}'**
  String ofTarget(int target);

  /// No description provided for @compassN.
  ///
  /// In en, this message translates to:
  /// **'N'**
  String get compassN;

  /// No description provided for @compassE.
  ///
  /// In en, this message translates to:
  /// **'E'**
  String get compassE;

  /// No description provided for @compassS.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get compassS;

  /// No description provided for @compassW.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get compassW;

  /// No description provided for @lessonCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} lesson} other{{count} lessons}}'**
  String lessonCount(int count);

  /// No description provided for @stepCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} step} other{{count} steps}}'**
  String stepCount(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
