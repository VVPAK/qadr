// The complete learning curriculum for new Muslims / beginners.
// Structured as: Curriculum → Modules → Lessons → Steps.

class LearningStep {
  const LearningStep({
    required this.title,
    required this.titleAr,
    required this.titleRu,
    required this.content,
    required this.contentRu,
    this.arabicText,
    this.transliteration,
    this.tip,
    this.tipRu,
  });

  final String title;
  final String titleAr;
  final String titleRu;
  final String content;
  final String contentRu;
  final String? arabicText;
  final String? transliteration;
  final String? tip;
  final String? tipRu;

  String localizedTitle(String lang) => switch (lang) {
    'ar' => titleAr,
    'ru' => titleRu,
    _ => title,
  };

  String localizedContent(String lang) => switch (lang) {
    'ru' => contentRu,
    _ => content,
  };

  String? localizedTip(String lang) => switch (lang) {
    'ru' => tipRu ?? tip,
    _ => tip,
  };
}

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.titleRu,
    required this.description,
    required this.descriptionRu,
    required this.steps,
    this.icon = '📖',
  });

  final String id;
  final String title;
  final String titleAr;
  final String titleRu;
  final String description;
  final String descriptionRu;
  final List<LearningStep> steps;
  final String icon;

  String localizedTitle(String lang) => switch (lang) {
    'ar' => titleAr,
    'ru' => titleRu,
    _ => title,
  };

  String localizedDescription(String lang) => switch (lang) {
    'ru' => descriptionRu,
    _ => description,
  };
}

class LearningModule {
  const LearningModule({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.titleRu,
    required this.description,
    required this.descriptionRu,
    required this.lessons,
    this.icon = '📚',
  });

  final String id;
  final String title;
  final String titleAr;
  final String titleRu;
  final String description;
  final String descriptionRu;
  final List<Lesson> lessons;
  final String icon;

  String localizedTitle(String lang) => switch (lang) {
    'ar' => titleAr,
    'ru' => titleRu,
    _ => title,
  };

  String localizedDescription(String lang) => switch (lang) {
    'ru' => descriptionRu,
    _ => description,
  };
}

/// The full curriculum
const learningCurriculum = [
  // Module 1: Foundations
  LearningModule(
    id: 'foundations',
    title: 'Foundations of Islam',
    titleAr: 'أسس الإسلام',
    titleRu: 'Основы ислама',
    description: 'The five pillars and core beliefs',
    descriptionRu: 'Пять столпов и основные убеждения',
    icon: '🕌',
    lessons: [
      Lesson(
        id: 'shahada',
        title: 'Shahada — Declaration of Faith',
        titleAr: 'الشهادة',
        titleRu: 'Шахада — свидетельство веры',
        description: 'The first pillar of Islam',
        descriptionRu: 'Первый столп ислама',
        icon: '☪️',
        steps: [
          LearningStep(
            title: 'What is Shahada?',
            titleAr: 'ما هي الشهادة؟',
            titleRu: 'Что такое шахада?',
            content:
                'The Shahada is the declaration of faith and the first pillar of Islam. '
                'It is the most fundamental expression of Islamic beliefs. '
                'By sincerely reciting the Shahada, a person enters Islam.',
            contentRu:
                'Шахада — это свидетельство веры и первый столп ислама. '
                'Она является самым важным выражением исламских убеждений. '
                'Искренне произнеся шахаду, человек принимает ислам.',
          ),
          LearningStep(
            title: 'The Words',
            titleAr: 'الكلمات',
            titleRu: 'Слова шахады',
            content:
                'The Shahada consists of two parts: '
                'testifying that there is no god but Allah, '
                'and that Muhammad ﷺ is His messenger.',
            contentRu:
                'Шахада состоит из двух частей: '
                'свидетельство о том, что нет бога, кроме Аллаха, '
                'и что Мухаммад ﷺ — Его посланник.',
            arabicText:
                'أَشْهَدُ أَنْ لَا إِلٰهَ إِلَّا ٱللّٰهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا رَسُولُ ٱللّٰهِ',
            transliteration:
                'Ash-hadu an la ilaha illa Allah, wa ash-hadu anna Muhammadan rasulu Allah',
          ),
          LearningStep(
            title: 'The Meaning',
            titleAr: 'المعنى',
            titleRu: 'Значение',
            content:
                '"I bear witness that there is no deity worthy of worship except Allah, '
                'and I bear witness that Muhammad is the messenger of Allah."\n\n'
                'This declaration affirms monotheism (Tawhid) and the prophethood of Muhammad ﷺ.',
            contentRu:
                '«Я свидетельствую, что нет божества, достойного поклонения, кроме Аллаха, '
                'и свидетельствую, что Мухаммад — посланник Аллаха».\n\n'
                'Это свидетельство утверждает единобожие (таухид) и пророческую миссию Мухаммада ﷺ.',
            tip:
                'The Shahada is not just words — it is a commitment to live by the principles of Islam.',
            tipRu:
                'Шахада — это не просто слова, а обязательство жить по принципам ислама.',
          ),
        ],
      ),
      Lesson(
        id: 'five_pillars',
        title: 'The Five Pillars',
        titleAr: 'أركان الإسلام الخمسة',
        titleRu: 'Пять столпов ислама',
        description: 'Overview of the five pillars',
        descriptionRu: 'Обзор пяти столпов',
        icon: '🏛️',
        steps: [
          LearningStep(
            title: 'The Five Pillars',
            titleAr: 'أركان الإسلام',
            titleRu: 'Пять столпов',
            content:
                'Islam is built upon five pillars:\n\n'
                '1. **Shahada** — Declaration of faith\n'
                '2. **Salah** — Five daily prayers\n'
                '3. **Zakat** — Obligatory charity (2.5% of wealth)\n'
                '4. **Sawm** — Fasting during Ramadan\n'
                '5. **Hajj** — Pilgrimage to Makkah (once in a lifetime if able)',
            contentRu:
                'Ислам основан на пяти столпах:\n\n'
                '1. **Шахада** — свидетельство веры\n'
                '2. **Салят (намаз)** — пять ежедневных молитв\n'
                '3. **Закят** — обязательная милостыня (2,5% от имущества)\n'
                '4. **Саум** — пост в месяц Рамадан\n'
                '5. **Хадж** — паломничество в Мекку (раз в жизни при возможности)',
          ),
          LearningStep(
            title: 'The Hadith',
            titleAr: 'الحديث',
            titleRu: 'Хадис',
            content:
                'The Prophet Muhammad ﷺ said:\n\n'
                '"Islam is built upon five [pillars]: testifying that there is no deity worthy '
                'of worship except Allah and that Muhammad is the Messenger of Allah, '
                'establishing the prayer, paying Zakat, making the pilgrimage to the House, '
                'and fasting in Ramadan."',
            contentRu:
                'Пророк Мухаммад ﷺ сказал:\n\n'
                '«Ислам основан на пяти [столпах]: свидетельстве, что нет божества, достойного '
                'поклонения, кроме Аллаха, и что Мухаммад — посланник Аллаха, '
                'совершении молитвы, выплате закята, паломничестве к Дому '
                'и посте в Рамадан».',
            arabicText: 'بُنِيَ الإسْلامُ عَلَى خَمْسٍ',
            transliteration: 'Buniya al-Islamu ʿala khams',
            tip: 'Source: Sahih al-Bukhari 8, Sahih Muslim 16',
            tipRu: 'Источник: Сахих аль-Бухари 8, Сахих Муслим 16',
          ),
        ],
      ),
      Lesson(
        id: 'six_pillars_iman',
        title: 'Six Pillars of Iman (Faith)',
        titleAr: 'أركان الإيمان الستة',
        titleRu: 'Шесть столпов имана (веры)',
        description: 'Core beliefs every Muslim holds',
        descriptionRu: 'Основные убеждения каждого мусульманина',
        icon: '💎',
        steps: [
          LearningStep(
            title: 'What is Iman?',
            titleAr: 'ما هو الإيمان؟',
            titleRu: 'Что такое иман?',
            content:
                'Iman (faith) goes deeper than practice — it is what you believe in your heart.\n\n'
                'The six pillars of Iman are:\n\n'
                '1. **Belief in Allah** — The one God\n'
                '2. **Belief in Angels** — Created from light\n'
                '3. **Belief in Holy Books** — Quran, Torah, Gospel, Psalms\n'
                '4. **Belief in Prophets** — From Adam to Muhammad ﷺ\n'
                '5. **Belief in the Day of Judgment** — Accountability\n'
                '6. **Belief in Qadr** — Divine decree, both good and bad',
            contentRu:
                'Иман (вера) глубже, чем обрядовая практика — это то, во что вы верите в своём сердце.\n\n'
                'Шесть столпов имана:\n\n'
                '1. **Вера в Аллаха** — единого Бога\n'
                '2. **Вера в ангелов** — созданных из света\n'
                '3. **Вера в Священные Писания** — Коран, Тора, Евангелие, Псалмы\n'
                '4. **Вера в пророков** — от Адама до Мухаммада ﷺ\n'
                '5. **Вера в Судный день** — день отчёта\n'
                '6. **Вера в предопределение (кадар)** — и в хорошее, и в плохое',
          ),
          LearningStep(
            title: 'Qadr — Divine Decree',
            titleAr: 'القدر',
            titleRu: 'Кадар — Божественное предопределение',
            content:
                'Qadr means that Allah has knowledge of everything that will happen, '
                'has written it, has willed it, and has created it.\n\n'
                'This does not negate free will — humans have the ability to choose, '
                'but Allah knows what they will choose.\n\n'
                'Belief in Qadr brings peace: whatever happens is part of Allah\'s plan.',
            contentRu:
                'Кадар означает, что Аллах знает обо всём, что произойдёт, '
                'записал это, пожелал и сотворил.\n\n'
                'Это не отменяет свободу воли — у человека есть возможность выбирать, '
                'но Аллах знает, что именно он выберет.\n\n'
                'Вера в предопределение приносит умиротворение: всё, что происходит, является частью замысла Аллаха.',
            tip:
                'The name of this app — Qadr — is inspired by this concept and by Surah Al-Qadr (97).',
            tipRu:
                'Название этого приложения — Кадр — вдохновлено этим понятием и сурой Аль-Кадр (97).',
          ),
        ],
      ),
    ],
  ),

  // Module 2: Purification & Prayer
  LearningModule(
    id: 'prayer',
    title: 'Purification & Prayer',
    titleAr: 'الطهارة والصلاة',
    titleRu: 'Очищение и молитва',
    description: 'Learn wudu and how to pray step by step',
    descriptionRu: 'Изучите омовение и молитву шаг за шагом',
    icon: '🤲',
    lessons: [
      Lesson(
        id: 'wudu',
        title: 'Wudu — Ablution',
        titleAr: 'الوضوء',
        titleRu: 'Вуду — омовение',
        description: 'Purification before prayer',
        descriptionRu: 'Очищение перед молитвой',
        icon: '💧',
        steps: [
          LearningStep(
            title: 'What is Wudu?',
            titleAr: 'ما هو الوضوء؟',
            titleRu: 'Что такое вуду?',
            content:
                'Wudu (ablution) is the ritual washing performed before prayer. '
                'It purifies the body and prepares the mind for standing before Allah.\n\n'
                'Allah says in the Quran: "O you who believe! When you rise for prayer, '
                'wash your faces and your hands up to the elbows, '
                'wipe your heads, and wash your feet up to the ankles." (5:6)',
            contentRu:
                'Вуду (омовение) — это ритуальное омовение, совершаемое перед молитвой. '
                'Оно очищает тело и подготавливает разум к предстоянию перед Аллахом.\n\n'
                'Аллах говорит в Коране: «О вы, которые уверовали! Когда вы встаёте на молитву, '
                'мойте ваши лица и руки до локтей, '
                'обтирайте головы и мойте ноги до щиколоток» (5:6).',
          ),
          LearningStep(
            title: 'Step 1: Intention & Bismillah',
            titleAr: 'النية والبسملة',
            titleRu: 'Шаг 1: Намерение и «Бисмиллях»',
            content:
                'Begin with the intention (niyyah) in your heart to perform wudu for prayer.\n\n'
                'Say "Bismillah" (In the name of Allah) before starting.',
            contentRu:
                'Начните с намерения (ният) в сердце совершить омовение для молитвы.\n\n'
                'Скажите «Бисмиллях» (Во имя Аллаха) перед началом.',
            arabicText: 'بِسْمِ ٱللّٰهِ',
            transliteration: 'Bismillah',
          ),
          LearningStep(
            title: 'Step 2: Wash Hands',
            titleAr: 'غسل اليدين',
            titleRu: 'Шаг 2: Мытьё рук',
            content:
                'Wash both hands up to the wrists three times.\n\n'
                'Start with the right hand, then the left. '
                'Make sure water reaches between the fingers.',
            contentRu:
                'Вымойте обе руки до запястий три раза.\n\n'
                'Начните с правой руки, затем левую. '
                'Убедитесь, что вода проходит между пальцами.',
          ),
          LearningStep(
            title: 'Step 3: Rinse Mouth & Nose',
            titleAr: 'المضمضة والاستنشاق',
            titleRu: 'Шаг 3: Полоскание рта и носа',
            content:
                'Take water in your right hand, rinse your mouth three times.\n\n'
                'Then sniff water into your nose three times and blow it out with your left hand.',
            contentRu:
                'Наберите воду в правую руку, прополощите рот три раза.\n\n'
                'Затем втяните воду в нос три раза и высморкайтесь левой рукой.',
          ),
          LearningStep(
            title: 'Step 4: Wash Face',
            titleAr: 'غسل الوجه',
            titleRu: 'Шаг 4: Мытьё лица',
            content:
                'Wash your entire face three times.\n\n'
                'The face is from the hairline to the chin, and from ear to ear.',
            contentRu:
                'Вымойте всё лицо три раза.\n\n'
                'Лицо — это область от линии роста волос до подбородка и от уха до уха.',
          ),
          LearningStep(
            title: 'Step 5: Wash Arms',
            titleAr: 'غسل اليدين إلى المرفقين',
            titleRu: 'Шаг 5: Мытьё рук до локтей',
            content:
                'Wash the right arm from fingertips to elbow three times.\n\n'
                'Then wash the left arm the same way. Include the elbows.',
            contentRu:
                'Вымойте правую руку от кончиков пальцев до локтя три раза.\n\n'
                'Затем таким же образом вымойте левую руку. Локти тоже омываются.',
          ),
          LearningStep(
            title: 'Step 6: Wipe Head & Ears',
            titleAr: 'مسح الرأس والأذنين',
            titleRu: 'Шаг 6: Обтирание головы и ушей',
            content:
                'With wet hands, wipe over your head from front to back and back to front once.\n\n'
                'Then wipe the inside of the ears with the index fingers '
                'and the outside with the thumbs.',
            contentRu:
                'Влажными руками проведите по голове от лба к затылку и обратно один раз.\n\n'
                'Затем протрите внутреннюю сторону ушей указательными пальцами, '
                'а внешнюю — большими.',
          ),
          LearningStep(
            title: 'Step 7: Wash Feet',
            titleAr: 'غسل القدمين',
            titleRu: 'Шаг 7: Мытьё ног',
            content:
                'Wash the right foot up to the ankle three times, '
                'including between the toes.\n\n'
                'Then wash the left foot the same way.',
            contentRu:
                'Вымойте правую ногу до щиколотки три раза, '
                'включая промежутки между пальцами.\n\n'
                'Затем таким же образом вымойте левую ногу.',
          ),
          LearningStep(
            title: 'Dua After Wudu',
            titleAr: 'دعاء بعد الوضوء',
            titleRu: 'Дуа после омовения',
            content: 'After completing wudu, recite this dua:',
            contentRu: 'После завершения омовения прочтите это дуа:',
            arabicText:
                'أَشْهَدُ أَنْ لَا إِلٰهَ إِلَّا ٱللّٰهُ وَحْدَهُ لَا شَرِيكَ لَهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
            transliteration:
                'Ash-hadu an la ilaha illa Allahu wahdahu la sharika lahu, '
                'wa ash-hadu anna Muhammadan abduhu wa rasuluh',
            tip: 'Source: Sahih Muslim 234',
            tipRu: 'Источник: Сахих Муслим 234',
          ),
        ],
      ),
      Lesson(
        id: 'salah_basics',
        title: 'Salah — How to Pray',
        titleAr: 'كيفية الصلاة',
        titleRu: 'Салят — как совершать намаз',
        description: 'Learn the prayer step by step',
        descriptionRu: 'Пошаговое изучение молитвы',
        icon: '🕋',
        steps: [
          LearningStep(
            title: 'Before You Begin',
            titleAr: 'قبل أن تبدأ',
            titleRu: 'Перед началом',
            content:
                'Before praying, make sure:\n\n'
                '• You have wudu (ablution)\n'
                '• You are facing the Qibla (direction of Kaaba)\n'
                '• Your body and place of prayer are clean\n'
                '• You are dressed modestly\n'
                '• It is the correct prayer time',
            contentRu:
                'Перед молитвой убедитесь:\n\n'
                '• У вас есть омовение (вуду)\n'
                '• Вы стоите лицом к Кибле (направление Каабы)\n'
                '• Ваше тело и место молитвы чисты\n'
                '• Вы одеты скромно\n'
                '• Наступило время молитвы',
          ),
          LearningStep(
            title: 'Step 1: Niyyah (Intention)',
            titleAr: 'النية',
            titleRu: 'Шаг 1: Ният (намерение)',
            content:
                'Make the intention in your heart for which prayer you are performing '
                '(Fajr, Dhuhr, Asr, Maghrib, or Isha).\n\n'
                'The intention is in the heart, not spoken aloud.',
            contentRu:
                'Сделайте в сердце намерение для той молитвы, которую вы совершаете '
                '(Фаджр, Зухр, Аср, Магриб или Иша).\n\n'
                'Намерение делается в сердце, его не нужно произносить вслух.',
          ),
          LearningStep(
            title: 'Step 2: Takbiratul Ihram',
            titleAr: 'تكبيرة الإحرام',
            titleRu: 'Шаг 2: Такбиратуль-ихрам',
            content:
                'Raise your hands to your ears (or shoulders) and say "Allahu Akbar" '
                '(Allah is the Greatest).\n\n'
                'This begins the prayer. From this point, you are in a state of prayer.',
            contentRu:
                'Поднимите руки к ушам (или к плечам) и скажите «Аллаху Акбар» '
                '(Аллах Велик).\n\n'
                'Это начало молитвы. С этого момента вы находитесь в состоянии молитвы.',
            arabicText: 'ٱللّٰهُ أَكْبَر',
            transliteration: 'Allahu Akbar',
          ),
          LearningStep(
            title: 'Step 3: Qiyam (Standing)',
            titleAr: 'القيام',
            titleRu: 'Шаг 3: Кыям (стояние)',
            content:
                'Place your right hand over your left on your chest (or below navel in Hanafi madhab).\n\n'
                'Recite Surah Al-Fatiha, then a short surah or verses from the Quran.',
            contentRu:
                'Положите правую руку на левую на груди (или ниже пупка в ханафитском мазхабе).\n\n'
                'Прочитайте суру Аль-Фатиха, затем короткую суру или аяты из Корана.',
            arabicText:
                'بِسْمِ ٱللّٰهِ ٱلرَّحْمٰنِ ٱلرَّحِيمِ\n'
                'ٱلْحَمْدُ لِلّٰهِ رَبِّ ٱلْعَالَمِينَ\n'
                'ٱلرَّحْمٰنِ ٱلرَّحِيمِ\n'
                'مَالِكِ يَوْمِ ٱلدِّينِ\n'
                'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ\n'
                'ٱهْدِنَا ٱلصِّرَاطَ ٱلْمُسْتَقِيمَ\n'
                'صِرَاطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّالِّينَ',
            tip: 'Al-Fatiha is recited in every unit (rakah) of prayer.',
            tipRu: 'Аль-Фатиха читается в каждом ракаате (единице) молитвы.',
          ),
          LearningStep(
            title: 'Step 4: Ruku (Bowing)',
            titleAr: 'الركوع',
            titleRu: 'Шаг 4: Руку (поясной поклон)',
            content:
                'Say "Allahu Akbar" and bow. Place your hands on your knees, '
                'keep your back straight.\n\n'
                'While bowing, say three times:',
            contentRu:
                'Скажите «Аллаху Акбар» и совершите поясной поклон. Положите руки на колени, '
                'спину держите прямо.\n\n'
                'Во время поклона скажите три раза:',
            arabicText: 'سُبْحَانَ رَبِّيَ ٱلْعَظِيمِ',
            transliteration: 'Subhana Rabbiyal Azeem',
          ),
          LearningStep(
            title: 'Step 5: Stand from Ruku',
            titleAr: 'الرفع من الركوع',
            titleRu: 'Шаг 5: Выпрямление после руку',
            content: 'Rise from bowing and say:',
            contentRu: 'Выпрямитесь после поясного поклона и скажите:',
            arabicText:
                'سَمِعَ ٱللّٰهُ لِمَنْ حَمِدَهُ\nرَبَّنَا وَلَكَ ٱلْحَمْدُ',
            transliteration: "Sami'Allahu liman hamidah\nRabbana wa lakal hamd",
          ),
          LearningStep(
            title: 'Step 6: Sujud (Prostration)',
            titleAr: 'السجود',
            titleRu: 'Шаг 6: Суджуд (земной поклон)',
            content:
                'Say "Allahu Akbar" and prostrate. Seven body parts touch the ground: '
                'forehead with nose, both palms, both knees, and toes of both feet.\n\n'
                'While in sujud, say three times:',
            contentRu:
                'Скажите «Аллаху Акбар» и совершите земной поклон. Семь частей тела касаются земли: '
                'лоб с носом, обе ладони, оба колена и пальцы обеих ног.\n\n'
                'Во время суджуда скажите три раза:',
            arabicText: 'سُبْحَانَ رَبِّيَ ٱلْأَعْلَى',
            transliteration: 'Subhana Rabbiyal A\'la',
            tip: 'Sujud is the closest a servant is to Allah. Make dua here.',
            tipRu:
                'Суджуд — момент наибольшей близости раба к Аллаху. Обращайтесь с дуа в этом положении.',
          ),
          LearningStep(
            title: 'Step 7: Sitting & Second Sujud',
            titleAr: 'الجلوس والسجدة الثانية',
            titleRu: 'Шаг 7: Сидение и второй суджуд',
            content:
                'Rise from sujud saying "Allahu Akbar", sit briefly, '
                'then perform a second sujud the same way.\n\n'
                'This completes one rakah (unit of prayer).',
            contentRu:
                'Поднимитесь из суджуда со словами «Аллаху Акбар», ненадолго сядьте, '
                'затем совершите второй суджуд таким же образом.\n\n'
                'На этом завершается один ракаат (единица молитвы).',
          ),
          LearningStep(
            title: 'Step 8: Tashahhud & Salam',
            titleAr: 'التشهد والسلام',
            titleRu: 'Шаг 8: Ташаххуд и салям',
            content:
                'In the final sitting, recite the Tashahhud, send blessings on the Prophet ﷺ, '
                'then end the prayer by turning your head right and left saying:',
            contentRu:
                'В последнем сидении прочитайте ташаххуд, отправьте благословения Пророку ﷺ, '
                'затем завершите молитву, повернув голову направо и налево со словами:',
            arabicText: 'ٱلسَّلَامُ عَلَيْكُمْ وَرَحْمَةُ ٱللّٰهِ',
            transliteration: "As-salamu alaykum wa rahmatullah",
            tip:
                'The number of rakahs: Fajr=2, Dhuhr=4, Asr=4, Maghrib=3, Isha=4',
            tipRu:
                'Количество ракаатов: Фаджр=2, Зухр=4, Аср=4, Магриб=3, Иша=4',
          ),
        ],
      ),
    ],
  ),

  // Module 3: Daily Life
  LearningModule(
    id: 'daily_life',
    title: 'Daily Life as a Muslim',
    titleAr: 'الحياة اليومية للمسلم',
    titleRu: 'Повседневная жизнь мусульманина',
    description: 'Duas, etiquette, and daily practices',
    descriptionRu: 'Дуа, этикет и повседневные практики',
    icon: '🌙',
    lessons: [
      Lesson(
        id: 'daily_duas',
        title: 'Essential Daily Duas',
        titleAr: 'أدعية يومية أساسية',
        titleRu: 'Основные ежедневные дуа',
        description: 'Duas for everyday situations',
        descriptionRu: 'Дуа на разные случаи жизни',
        icon: '🤲',
        steps: [
          LearningStep(
            title: 'Before Eating',
            titleAr: 'قبل الأكل',
            titleRu: 'Перед едой',
            content: 'Say Bismillah before eating. If you forget, say:',
            contentRu:
                'Скажите «Бисмиллях» перед едой. Если вы забыли, скажите:',
            arabicText: 'بِسْمِ ٱللّٰهِ أَوَّلَهُ وَآخِرَهُ',
            transliteration: "Bismillahi awwalahu wa akhirah",
            tip: 'Source: Abu Dawud 3767',
            tipRu: 'Источник: Абу Дауд 3767',
          ),
          LearningStep(
            title: 'After Eating',
            titleAr: 'بعد الأكل',
            titleRu: 'После еды',
            content: 'Thank Allah after finishing your meal:',
            contentRu: 'Поблагодарите Аллаха после завершения приёма пищи:',
            arabicText:
                'ٱلْحَمْدُ لِلّٰهِ ٱلَّذِي أَطْعَمَنِي هَذَا وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ',
            transliteration:
                "Alhamdu lillahil-ladhi at'amani hadha wa razaqanihi min ghayri hawlin minni wa la quwwah",
            tip: 'Source: Abu Dawud 4023, Tirmidhi 3458',
            tipRu: 'Источник: Абу Дауд 4023, Тирмизи 3458',
          ),
          LearningStep(
            title: 'Entering the Home',
            titleAr: 'دخول البيت',
            titleRu: 'При входе в дом',
            content: 'When entering your home, say:',
            contentRu: 'Входя в дом, скажите:',
            arabicText:
                'بِسْمِ ٱللّٰهِ وَلَجْنَا وَبِسْمِ ٱللّٰهِ خَرَجْنَا وَعَلَى ٱللّٰهِ رَبِّنَا تَوَكَّلْنَا',
            transliteration:
                'Bismillahi walajna, wa bismillahi kharajna, wa ala Allahi rabbina tawakkalna',
            tip: 'Source: Abu Dawud 5096',
            tipRu: 'Источник: Абу Дауд 5096',
          ),
          LearningStep(
            title: 'Before Sleeping',
            titleAr: 'قبل النوم',
            titleRu: 'Перед сном',
            content:
                'The Prophet ﷺ used to recite Ayatul Kursi (2:255) and the last three surahs '
                '(Al-Ikhlas, Al-Falaq, An-Nas) before sleeping.\n\n'
                'Also say:',
            contentRu:
                'Пророк ﷺ перед сном читал Аятуль-Курси (2:255) и три последние суры '
                '(Аль-Ихляс, Аль-Фаляк, Ан-Нас).\n\n'
                'Также скажите:',
            arabicText: 'بِٱسْمِكَ ٱللّٰهُمَّ أَمُوتُ وَأَحْيَا',
            transliteration: 'Bismika Allahumma amutu wa ahya',
            tip: 'Source: Sahih al-Bukhari 6324',
            tipRu: 'Источник: Сахих аль-Бухари 6324',
          ),
          LearningStep(
            title: 'Waking Up',
            titleAr: 'عند الاستيقاظ',
            titleRu: 'При пробуждении',
            content: 'Upon waking, say:',
            contentRu: 'Проснувшись, скажите:',
            arabicText:
                'ٱلْحَمْدُ لِلّٰهِ ٱلَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ ٱلنُّشُورُ',
            transliteration:
                'Alhamdu lillahil-ladhi ahyana ba\'da ma amatana wa ilayhin-nushur',
            tip: 'Source: Sahih al-Bukhari 6324',
            tipRu: 'Источник: Сахих аль-Бухари 6324',
          ),
        ],
      ),
      Lesson(
        id: 'friday',
        title: 'Friday — Jumu\'ah',
        titleAr: 'يوم الجمعة',
        titleRu: 'Пятница — Джума',
        description: 'The importance and etiquette of Friday',
        descriptionRu: 'Значение и этикет пятничного дня',
        icon: '🕌',
        steps: [
          LearningStep(
            title: 'The Best Day',
            titleAr: 'خير يوم',
            titleRu: 'Лучший день',
            content:
                'The Prophet ﷺ said: "The best day on which the sun rises is Friday. '
                'On it Adam was created, on it he was admitted to Paradise, '
                'and on it he was expelled from it."',
            contentRu:
                'Пророк ﷺ сказал: «Лучший день, в который восходит солнце, — это пятница. '
                'В этот день был создан Адам, в этот день он был введён в Рай '
                'и в этот день он был изгнан из него».',
            tip: 'Source: Sahih Muslim 854',
            tipRu: 'Источник: Сахих Муслим 854',
          ),
          LearningStep(
            title: 'Sunnah of Friday',
            titleAr: 'سنن يوم الجمعة',
            titleRu: 'Сунна пятничного дня',
            content:
                'Recommended acts on Friday:\n\n'
                '• Take a bath (ghusl)\n'
                '• Wear clean/best clothes\n'
                '• Use perfume\n'
                '• Go early to the mosque\n'
                '• Read Surah Al-Kahf (18)\n'
                '• Send abundant blessings on the Prophet ﷺ\n'
                '• Make dua (there is an hour of acceptance)',
            contentRu:
                'Желательные действия в пятницу:\n\n'
                '• Совершить полное омовение (гусль)\n'
                '• Надеть чистую и лучшую одежду\n'
                '• Воспользоваться благовониями\n'
                '• Прийти в мечеть пораньше\n'
                '• Прочитать суру Аль-Кахф (18)\n'
                '• Обильно посылать благословения Пророку ﷺ\n'
                '• Обращаться с дуа (в пятницу есть час, когда мольбы принимаются)',
          ),
        ],
      ),
    ],
  ),
];
