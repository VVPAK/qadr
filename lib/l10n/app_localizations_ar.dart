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

  @override
  String get onboardingWelcomeBasmala =>
      'بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ';

  @override
  String get onboardingWelcomeHeadline1 => 'رفيق';

  @override
  String get onboardingWelcomeHeadline2 => 'يومك';

  @override
  String get onboardingWelcomeSubtitle =>
      'الصلاة والقبلة والقرآن والذكر — مجموعة في سكون.';

  @override
  String get onboardingWelcomeCta => 'ابدأ';

  @override
  String get onboardingNameSalam => 'السلام عليكم';

  @override
  String get onboardingNameHeadline1 => 'كيف';

  @override
  String get onboardingNameHeadline2 => 'نناديك؟';

  @override
  String get onboardingNameLabel => 'الاسم';

  @override
  String get onboardingNamePlaceholder => 'أدخل اسمك';

  @override
  String get onboardingNamePrivacy =>
      'يُستخدم محلياً فقط — للترحيب في قسم «الصلاة».';

  @override
  String get onboardingLocationStepLabel => 'الخطوة 1 من 2 · الأذونات';

  @override
  String get onboardingLocationHeadline1 => 'أين';

  @override
  String get onboardingLocationHeadline2 => 'تصلّي؟';

  @override
  String get onboardingLocationCardTitle => 'تحديد المدينة';

  @override
  String get onboardingLocationCardDesc =>
      'لأوقات صلاة دقيقة واتجاه نحو الكعبة.';

  @override
  String get onboardingLocationPrivacy => 'قدر لا يحفظ موقعك. يبقى على جهازك.';

  @override
  String get onboardingLocationAllow => 'السماح بالوصول';

  @override
  String get onboardingLocationManual => 'اختيار المدينة يدوياً';

  @override
  String get onboardingNotifsStepLabel => 'الخطوة 2 من 2 · الأذونات';

  @override
  String get onboardingNotifsHeadline1 => 'تذكير';

  @override
  String get onboardingNotifsHeadline2 => 'هادئ';

  @override
  String get onboardingNotifsSubtitle =>
      'أذان قصير قبل خمس دقائق من الصلاة. بلا ضوضاء ولا إعلانات.';

  @override
  String get onboardingNotifsAllow => 'تفعيل التذكيرات';

  @override
  String get onboardingNotifsDecline => 'ليس الآن';

  @override
  String get onboardingBismillahReady => 'جاهز';

  @override
  String onboardingBismillahReadyWithName(String name) {
    return 'جاهز، $name';
  }

  @override
  String get onboardingBismillahArabic => 'بِسْمِ ٱللَّٰهِ';

  @override
  String get onboardingBismillahTranslation => 'باسم الله — لنبدأ.';

  @override
  String get onboardingBismillahHeadline1 => 'لتُقبل';

  @override
  String get onboardingBismillahHeadline2 => 'كل صلاة.';

  @override
  String get onboardingBismillahCta => 'ادخل قدر';

  @override
  String get kaaba => 'الكعبة';

  @override
  String degreesFromNorth(int degrees) {
    return '$degrees° من الشمال';
  }

  @override
  String get facingKaaba => 'باتجاه الكعبة';

  @override
  String get turnRight => 'يمين';

  @override
  String get turnLeft => 'يسار';

  @override
  String get compassUnavailable => 'البوصلة غير متاحة على هذا الجهاز';

  @override
  String get calibrateCompass => 'حرك هاتفك على شكل رقم 8 للمعايرة';

  @override
  String get calibrationHigh => 'دقة المعايرة: عالية';

  @override
  String get calibrationMedium => 'دقة المعايرة: متوسطة';

  @override
  String get calibrationLow => 'دقة المعايرة: منخفضة — يلزم المعايرة';

  @override
  String get qiblaLocationTitle => 'السماح بالوصول إلى الموقع';

  @override
  String get qiblaLocationDesc => 'يلزم تحديد موقعك لتوجيه السهم نحو الكعبة.';

  @override
  String get detectLocation => 'تحديد الموقع';

  @override
  String get aiChat => 'محادثة ذكية';

  @override
  String get apiBaseUrl => 'رابط API الأساسي';

  @override
  String get apiKey => 'مفتاح API';

  @override
  String get saveApiSettings => 'حفظ إعدادات API';

  @override
  String get apiSettingsSaved => 'تم حفظ إعدادات API';

  @override
  String ofTarget(int target) {
    return 'من $target';
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
      other: '$count دروس',
      one: 'درس واحد',
    );
    return '$_temp0';
  }

  @override
  String stepCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count خطوات',
      one: 'خطوة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get chatGreeting => 'السلام عليكم';

  @override
  String get chatSubtitle => 'اطرح سؤالاً أو اختر موضوعاً';

  @override
  String get qiblaLocationRequired => 'الموقع مطلوب لبوصلة القبلة';

  @override
  String get enableLocation => 'تفعيل الموقع';

  @override
  String get duaComingSoon => 'قائمة الأدعية — قريباً';

  @override
  String get invalidLesson => 'درس غير صالح';

  @override
  String lessonNotFound(String lessonId) {
    return 'الدرس غير موجود: $lessonId';
  }

  @override
  String errorWithMessage(String error) {
    return 'خطأ: $error';
  }

  @override
  String get searchResultsAyahs => 'الآيات';

  @override
  String get searchNoResults => 'لا توجد نتائج';
}
