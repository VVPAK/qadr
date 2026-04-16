// ignore_for_file: avoid_print
/// Downloads Quran text from alquran.cloud API and generates assets/data/quran.json.
///
/// Usage: dart run tool/generate_quran_data.dart
library;

import 'dart:convert';
import 'dart:io';

// ---------------------------------------------------------------------------
// Russian surah name translations (canonical, from Kuliev)
// ---------------------------------------------------------------------------
const _russianNames = <String>[
  'Открывающая', // 1
  'Корова', // 2
  'Семейство Имрана', // 3
  'Женщины', // 4
  'Трапеза', // 5
  'Скот', // 6
  'Преграды', // 7
  'Трофеи', // 8
  'Покаяние', // 9
  'Юнус', // 10
  'Худ', // 11
  'Юсуф', // 12
  'Гром', // 13
  'Ибрахим', // 14
  'Аль-Хиджр', // 15
  'Пчёлы', // 16
  'Ночной перенос', // 17
  'Пещера', // 18
  'Марьям', // 19
  'Та Ха', // 20
  'Пророки', // 21
  'Хадж', // 22
  'Верующие', // 23
  'Свет', // 24
  'Различение', // 25
  'Поэты', // 26
  'Муравьи', // 27
  'Рассказ', // 28
  'Паук', // 29
  'Римляне', // 30
  'Лукман', // 31
  'Поклон', // 32
  'Союзники', // 33
  'Саба', // 34
  'Творец', // 35
  'Йа Син', // 36
  'Выстроившиеся в ряды', // 37
  'Сад', // 38
  'Толпы', // 39
  'Прощающий', // 40
  'Разъяснены', // 41
  'Совет', // 42
  'Украшения', // 43
  'Дым', // 44
  'Коленопреклонённая', // 45
  'Барханы', // 46
  'Мухаммад', // 47
  'Победа', // 48
  'Комнаты', // 49
  'Каф', // 50
  'Рассеивающие', // 51
  'Гора', // 52
  'Звезда', // 53
  'Луна', // 54
  'Милостивый', // 55
  'Событие', // 56
  'Железо', // 57
  'Препирательство', // 58
  'Сбор', // 59
  'Испытуемая', // 60
  'Ряды', // 61
  'Пятница', // 62
  'Лицемеры', // 63
  'Взаимное обделение', // 64
  'Развод', // 65
  'Запрещение', // 66
  'Власть', // 67
  'Перо', // 68
  'Неминуемое', // 69
  'Ступени', // 70
  'Нух', // 71
  'Джинны', // 72
  'Закутавшийся', // 73
  'Завернувшийся', // 74
  'Воскресение', // 75
  'Человек', // 76
  'Посылаемые', // 77
  'Весть', // 78
  'Вырывающие', // 79
  'Нахмурился', // 80
  'Скручивание', // 81
  'Раскалывание', // 82
  'Обвешивающие', // 83
  'Разверзнувшееся', // 84
  'Созвездия', // 85
  'Ночной путник', // 86
  'Высочайший', // 87
  'Покрывающее', // 88
  'Заря', // 89
  'Город', // 90
  'Солнце', // 91
  'Ночь', // 92
  'Утро', // 93
  'Раскрытие', // 94
  'Смоковница', // 95
  'Сгусток крови', // 96
  'Предопределение', // 97
  'Ясное знамение', // 98
  'Землетрясение', // 99
  'Скачущие', // 100
  'Великое бедствие', // 101
  'Страсть к приумножению', // 102
  'Предвечернее время', // 103
  'Хулитель', // 104
  'Слон', // 105
  'Курайш', // 106
  'Мелочь', // 107
  'Изобилие', // 108
  'Неверующие', // 109
  'Помощь', // 110
  'Пальмовые волокна', // 111
  'Искренность', // 112
  'Рассвет', // 113
  'Люди', // 114
];

// ---------------------------------------------------------------------------
// Clean Arabic surah names (without سُورَةُ prefix, without tashkeel on name)
// ---------------------------------------------------------------------------
const _arabicNames = <String>[
  'الفاتحة', // 1
  'البقرة', // 2
  'آل عمران', // 3
  'النساء', // 4
  'المائدة', // 5
  'الأنعام', // 6
  'الأعراف', // 7
  'الأنفال', // 8
  'التوبة', // 9
  'يونس', // 10
  'هود', // 11
  'يوسف', // 12
  'الرعد', // 13
  'إبراهيم', // 14
  'الحجر', // 15
  'النحل', // 16
  'الإسراء', // 17
  'الكهف', // 18
  'مريم', // 19
  'طه', // 20
  'الأنبياء', // 21
  'الحج', // 22
  'المؤمنون', // 23
  'النور', // 24
  'الفرقان', // 25
  'الشعراء', // 26
  'النمل', // 27
  'القصص', // 28
  'العنكبوت', // 29
  'الروم', // 30
  'لقمان', // 31
  'السجدة', // 32
  'الأحزاب', // 33
  'سبأ', // 34
  'فاطر', // 35
  'يس', // 36
  'الصافات', // 37
  'ص', // 38
  'الزمر', // 39
  'غافر', // 40
  'فصلت', // 41
  'الشورى', // 42
  'الزخرف', // 43
  'الدخان', // 44
  'الجاثية', // 45
  'الأحقاف', // 46
  'محمد', // 47
  'الفتح', // 48
  'الحجرات', // 49
  'ق', // 50
  'الذاريات', // 51
  'الطور', // 52
  'النجم', // 53
  'القمر', // 54
  'الرحمن', // 55
  'الواقعة', // 56
  'الحديد', // 57
  'المجادلة', // 58
  'الحشر', // 59
  'الممتحنة', // 60
  'الصف', // 61
  'الجمعة', // 62
  'المنافقون', // 63
  'التغابن', // 64
  'الطلاق', // 65
  'التحريم', // 66
  'الملك', // 67
  'القلم', // 68
  'الحاقة', // 69
  'المعارج', // 70
  'نوح', // 71
  'الجن', // 72
  'المزمل', // 73
  'المدثر', // 74
  'القيامة', // 75
  'الإنسان', // 76
  'المرسلات', // 77
  'النبأ', // 78
  'النازعات', // 79
  'عبس', // 80
  'التكوير', // 81
  'الانفطار', // 82
  'المطففين', // 83
  'الانشقاق', // 84
  'البروج', // 85
  'الطارق', // 86
  'الأعلى', // 87
  'الغاشية', // 88
  'الفجر', // 89
  'البلد', // 90
  'الشمس', // 91
  'الليل', // 92
  'الضحى', // 93
  'الشرح', // 94
  'التين', // 95
  'العلق', // 96
  'القدر', // 97
  'البينة', // 98
  'الزلزلة', // 99
  'العاديات', // 100
  'القارعة', // 101
  'التكاثر', // 102
  'العصر', // 103
  'الهمزة', // 104
  'الفيل', // 105
  'قريش', // 106
  'الماعون', // 107
  'الكوثر', // 108
  'الكافرون', // 109
  'النصر', // 110
  'المسد', // 111
  'الإخلاص', // 112
  'الفلق', // 113
  'الناس', // 114
];

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Future<Map<String, dynamic>> _fetchJson(String url) async {
  final client = HttpClient();
  try {
    final request = await client.getUrl(Uri.parse(url));
    final response = await request.close();
    if (response.statusCode != 200) {
      throw HttpException('HTTP ${response.statusCode} for $url');
    }
    final body = await response.transform(utf8.decoder).join();
    return jsonDecode(body) as Map<String, dynamic>;
  } finally {
    client.close();
  }
}

Future<List<Map<String, dynamic>>> _fetchEdition(String edition) async {
  print('  Fetching $edition...');
  final json = await _fetchJson(
    'https://api.alquran.cloud/v1/quran/$edition',
  );
  final data = json['data'] as Map<String, dynamic>;
  final surahs = data['surahs'] as List;
  return surahs.cast<Map<String, dynamic>>();
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

Future<void> main() async {
  print('Downloading Quran data from alquran.cloud API...\n');

  // 1. Fetch all three editions
  final arabicSurahs = await _fetchEdition('quran-uthmani');
  final russianSurahs = await _fetchEdition('ru.kuliev');
  final englishSurahs = await _fetchEdition('en.sahih');

  print('\nProcessing data...');

  // 2. Build surah metadata
  final surahList = <Map<String, dynamic>>[];
  final ayahList = <Map<String, dynamic>>[];

  for (var i = 0; i < arabicSurahs.length; i++) {
    final arSurah = arabicSurahs[i];
    final ruSurah = russianSurahs[i];
    final enSurah = englishSurahs[i];

    final surahNumber = arSurah['number'] as int;
    final arAyahs = arSurah['ayahs'] as List;
    final numberOfAyahs = arAyahs.length;
    final revelationType = arSurah['revelationType'] as String;
    final englishNameTranslation =
        arSurah['englishNameTranslation'] as String;

    surahList.add({
      'number': surahNumber,
      'nameArabic': _arabicNames[i],
      'nameEnglish': englishNameTranslation,
      'nameRussian': _russianNames[i],
      'revelationType': revelationType,
      'ayahCount': numberOfAyahs,
    });

    // 3. Build ayah data
    final ruAyahs = ruSurah['ayahs'] as List;
    final enAyahs = enSurah['ayahs'] as List;

    for (var j = 0; j < arAyahs.length; j++) {
      final arAyah = arAyahs[j] as Map<String, dynamic>;
      final ruAyah = ruAyahs[j] as Map<String, dynamic>;
      final enAyah = enAyahs[j] as Map<String, dynamic>;

      ayahList.add({
        'surahNumber': surahNumber,
        'ayahNumber': arAyah['numberInSurah'] as int,
        'textArabic': (arAyah['text'] as String).replaceAll('\uFEFF', ''),
        'textEnglish': (enAyah['text'] as String).replaceAll('\uFEFF', ''),
        'textRussian': (ruAyah['text'] as String).replaceAll('\uFEFF', ''),
      });
    }
  }

  // 4. Validate
  assert(surahList.length == 114, 'Expected 114 surahs, got ${surahList.length}');
  assert(ayahList.length == 6236, 'Expected 6236 ayahs, got ${ayahList.length}');

  // 5. Write JSON
  final output = {
    'surahs': surahList,
    'ayahs': ayahList,
  };

  final encoder = JsonEncoder.withIndent('  ');
  final jsonString = encoder.convert(output);

  final file = File('assets/data/quran.json');
  await file.create(recursive: true);
  await file.writeAsString(jsonString);

  final sizeMb = (file.lengthSync() / (1024 * 1024)).toStringAsFixed(1);
  print('\nDone! Written to ${file.path}');
  print('  Surahs: ${surahList.length}');
  print('  Ayahs:  ${ayahList.length}');
  print('  Size:   $sizeMb MB');
}
