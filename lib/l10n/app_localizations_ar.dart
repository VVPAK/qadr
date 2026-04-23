// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'قدر';

  @override
  String get chat => 'محادثة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get quran => 'القرآن';

  @override
  String get dua => 'دعاء';

  @override
  String get prayerTimes => 'أوقات الصلاة';

  @override
  String get qibla => 'القبلة';

  @override
  String get tasbih => 'تسبيح';

  @override
  String get onboardingWelcome => 'مرحباً بك في قدر';

  @override
  String get onboardingLanguage => 'اختر لغتك';

  @override
  String get onboardingMadhab => 'اختر مذهبك';

  @override
  String get onboardingLocation => 'السماح بالوصول إلى الموقع';

  @override
  String get onboardingLocationDesc => 'لأوقات صلاة دقيقة واتجاه القبلة';

  @override
  String get onboardingName => 'ما اسمك؟';

  @override
  String get onboardingNameHint => 'اختياري';

  @override
  String get onboardingStart => 'ابدأ';

  @override
  String get next => 'التالي';

  @override
  String get back => 'رجوع';

  @override
  String get skip => 'تخطي';

  @override
  String get typeMessage => 'اكتب رسالة...';

  @override
  String get hanafi => 'حنفي';

  @override
  String get shafii => 'شافعي';

  @override
  String get maliki => 'مالكي';

  @override
  String get hanbali => 'حنبلي';

  @override
  String get fajr => 'الفجر';

  @override
  String get sunrise => 'الشروق';

  @override
  String get dhuhr => 'الظهر';

  @override
  String get asr => 'العصر';

  @override
  String get maghrib => 'المغرب';

  @override
  String get isha => 'العشاء';

  @override
  String get infoNotFatwa => 'هذه معلومات وليست فتوى';

  @override
  String get offlineMode => 'أنت غير متصل. عرض المحتوى المخزن.';

  @override
  String get apiKeyRequired => 'مطلوب مفتاح API للدردشة الذكية';

  @override
  String get language => 'اللغة';

  @override
  String get madhab => 'المذهب';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get about => 'حول';

  @override
  String get done => 'تم';

  @override
  String get yourLearningJourney => 'رحلتك التعليمية';

  @override
  String percentComplete(int percent) {
    return '$percent% مكتمل';
  }

  @override
  String continueLesson(String lessonTitle) {
    return 'متابعة: $lessonTitle';
  }

  @override
  String get allLessonsComplete => 'لقد أكملت جميع الدروس!';

  @override
  String get meccan => 'مكية';

  @override
  String get medinan => 'مدنية';

  @override
  String ayahCount(int count) {
    return '$count آيات';
  }

  @override
  String get loadingQuran => 'جارٍ تحضير بيانات القرآن...';

  @override
  String get discussInChat => 'مناقشة في المحادثة';

  @override
  String get openInQuran => 'فتح في القرآن';

  @override
  String get prayer => 'الصلاة';

  @override
  String get dhikr => 'ذكر';

  @override
  String get learn => 'العلم';

  @override
  String get surahs => 'السور';

  @override
  String get library => 'المكتبة';

  @override
  String get recommended => 'موصى به';

  @override
  String get continueReading => 'متابعة';

  @override
  String get searchSurahOrAyah => 'بحث عن سورة أو آية';

  @override
  String get reset => 'إعادة';

  @override
  String get history => 'السجل';
}
