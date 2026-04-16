// The complete learning curriculum for new Muslims / beginners.
// Structured as: Curriculum → Modules → Lessons → Steps.

class LearningStep {
  const LearningStep({
    required this.title,
    required this.titleAr,
    required this.content,
    this.arabicText,
    this.transliteration,
    this.tip,
  });

  final String title;
  final String titleAr;
  final String content;
  final String? arabicText;
  final String? transliteration;
  final String? tip;
}

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.description,
    required this.steps,
    this.icon = '📖',
  });

  final String id;
  final String title;
  final String titleAr;
  final String description;
  final List<LearningStep> steps;
  final String icon;
}

class LearningModule {
  const LearningModule({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.description,
    required this.lessons,
    this.icon = '📚',
  });

  final String id;
  final String title;
  final String titleAr;
  final String description;
  final List<Lesson> lessons;
  final String icon;
}

/// The full curriculum
const learningCurriculum = [
  // Module 1: Foundations
  LearningModule(
    id: 'foundations',
    title: 'Foundations of Islam',
    titleAr: 'أسس الإسلام',
    description: 'The five pillars and core beliefs',
    icon: '🕌',
    lessons: [
      Lesson(
        id: 'shahada',
        title: 'Shahada — Declaration of Faith',
        titleAr: 'الشهادة',
        description: 'The first pillar of Islam',
        icon: '☪️',
        steps: [
          LearningStep(
            title: 'What is Shahada?',
            titleAr: 'ما هي الشهادة؟',
            content:
                'The Shahada is the declaration of faith and the first pillar of Islam. '
                'It is the most fundamental expression of Islamic beliefs. '
                'By sincerely reciting the Shahada, a person enters Islam.',
          ),
          LearningStep(
            title: 'The Words',
            titleAr: 'الكلمات',
            content: 'The Shahada consists of two parts: '
                'testifying that there is no god but Allah, '
                'and that Muhammad ﷺ is His messenger.',
            arabicText: 'أَشْهَدُ أَنْ لَا إِلٰهَ إِلَّا ٱللّٰهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا رَسُولُ ٱللّٰهِ',
            transliteration:
                'Ash-hadu an la ilaha illa Allah, wa ash-hadu anna Muhammadan rasulu Allah',
          ),
          LearningStep(
            title: 'The Meaning',
            titleAr: 'المعنى',
            content:
                '"I bear witness that there is no deity worthy of worship except Allah, '
                'and I bear witness that Muhammad is the messenger of Allah."\n\n'
                'This declaration affirms monotheism (Tawhid) and the prophethood of Muhammad ﷺ.',
            tip: 'The Shahada is not just words — it is a commitment to live by the principles of Islam.',
          ),
        ],
      ),
      Lesson(
        id: 'five_pillars',
        title: 'The Five Pillars',
        titleAr: 'أركان الإسلام الخمسة',
        description: 'Overview of the five pillars',
        icon: '🏛️',
        steps: [
          LearningStep(
            title: 'The Five Pillars',
            titleAr: 'أركان الإسلام',
            content: 'Islam is built upon five pillars:\n\n'
                '1. **Shahada** — Declaration of faith\n'
                '2. **Salah** — Five daily prayers\n'
                '3. **Zakat** — Obligatory charity (2.5% of wealth)\n'
                '4. **Sawm** — Fasting during Ramadan\n'
                '5. **Hajj** — Pilgrimage to Makkah (once in a lifetime if able)',
          ),
          LearningStep(
            title: 'The Hadith',
            titleAr: 'الحديث',
            content:
                'The Prophet Muhammad ﷺ said:\n\n'
                '"Islam is built upon five [pillars]: testifying that there is no deity worthy '
                'of worship except Allah and that Muhammad is the Messenger of Allah, '
                'establishing the prayer, paying Zakat, making the pilgrimage to the House, '
                'and fasting in Ramadan."',
            arabicText:
                'بُنِيَ الإسْلامُ عَلَى خَمْسٍ',
            transliteration: 'Buniya al-Islamu ʿala khams',
            tip: 'Source: Sahih al-Bukhari 8, Sahih Muslim 16',
          ),
        ],
      ),
      Lesson(
        id: 'six_pillars_iman',
        title: 'Six Pillars of Iman (Faith)',
        titleAr: 'أركان الإيمان الستة',
        description: 'Core beliefs every Muslim holds',
        icon: '💎',
        steps: [
          LearningStep(
            title: 'What is Iman?',
            titleAr: 'ما هو الإيمان؟',
            content: 'Iman (faith) goes deeper than practice — it is what you believe in your heart.\n\n'
                'The six pillars of Iman are:\n\n'
                '1. **Belief in Allah** — The one God\n'
                '2. **Belief in Angels** — Created from light\n'
                '3. **Belief in Holy Books** — Quran, Torah, Gospel, Psalms\n'
                '4. **Belief in Prophets** — From Adam to Muhammad ﷺ\n'
                '5. **Belief in the Day of Judgment** — Accountability\n'
                '6. **Belief in Qadr** — Divine decree, both good and bad',
          ),
          LearningStep(
            title: 'Qadr — Divine Decree',
            titleAr: 'القدر',
            content:
                'Qadr means that Allah has knowledge of everything that will happen, '
                'has written it, has willed it, and has created it.\n\n'
                'This does not negate free will — humans have the ability to choose, '
                'but Allah knows what they will choose.\n\n'
                'Belief in Qadr brings peace: whatever happens is part of Allah\'s plan.',
            tip:
                'The name of this app — Qadr — is inspired by this concept and by Surah Al-Qadr (97).',
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
    description: 'Learn wudu and how to pray step by step',
    icon: '🤲',
    lessons: [
      Lesson(
        id: 'wudu',
        title: 'Wudu — Ablution',
        titleAr: 'الوضوء',
        description: 'Purification before prayer',
        icon: '💧',
        steps: [
          LearningStep(
            title: 'What is Wudu?',
            titleAr: 'ما هو الوضوء؟',
            content:
                'Wudu (ablution) is the ritual washing performed before prayer. '
                'It purifies the body and prepares the mind for standing before Allah.\n\n'
                'Allah says in the Quran: "O you who believe! When you rise for prayer, '
                'wash your faces and your hands up to the elbows, '
                'wipe your heads, and wash your feet up to the ankles." (5:6)',
          ),
          LearningStep(
            title: 'Step 1: Intention & Bismillah',
            titleAr: 'النية والبسملة',
            content: 'Begin with the intention (niyyah) in your heart to perform wudu for prayer.\n\n'
                'Say "Bismillah" (In the name of Allah) before starting.',
            arabicText: 'بِسْمِ ٱللّٰهِ',
            transliteration: 'Bismillah',
          ),
          LearningStep(
            title: 'Step 2: Wash Hands',
            titleAr: 'غسل اليدين',
            content: 'Wash both hands up to the wrists three times.\n\n'
                'Start with the right hand, then the left. '
                'Make sure water reaches between the fingers.',
          ),
          LearningStep(
            title: 'Step 3: Rinse Mouth & Nose',
            titleAr: 'المضمضة والاستنشاق',
            content:
                'Take water in your right hand, rinse your mouth three times.\n\n'
                'Then sniff water into your nose three times and blow it out with your left hand.',
          ),
          LearningStep(
            title: 'Step 4: Wash Face',
            titleAr: 'غسل الوجه',
            content: 'Wash your entire face three times.\n\n'
                'The face is from the hairline to the chin, and from ear to ear.',
          ),
          LearningStep(
            title: 'Step 5: Wash Arms',
            titleAr: 'غسل اليدين إلى المرفقين',
            content: 'Wash the right arm from fingertips to elbow three times.\n\n'
                'Then wash the left arm the same way. Include the elbows.',
          ),
          LearningStep(
            title: 'Step 6: Wipe Head & Ears',
            titleAr: 'مسح الرأس والأذنين',
            content: 'With wet hands, wipe over your head from front to back and back to front once.\n\n'
                'Then wipe the inside of the ears with the index fingers '
                'and the outside with the thumbs.',
          ),
          LearningStep(
            title: 'Step 7: Wash Feet',
            titleAr: 'غسل القدمين',
            content: 'Wash the right foot up to the ankle three times, '
                'including between the toes.\n\n'
                'Then wash the left foot the same way.',
          ),
          LearningStep(
            title: 'Dua After Wudu',
            titleAr: 'دعاء بعد الوضوء',
            content: 'After completing wudu, recite this dua:',
            arabicText:
                'أَشْهَدُ أَنْ لَا إِلٰهَ إِلَّا ٱللّٰهُ وَحْدَهُ لَا شَرِيكَ لَهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
            transliteration:
                'Ash-hadu an la ilaha illa Allahu wahdahu la sharika lahu, '
                'wa ash-hadu anna Muhammadan abduhu wa rasuluh',
            tip: 'Source: Sahih Muslim 234',
          ),
        ],
      ),
      Lesson(
        id: 'salah_basics',
        title: 'Salah — How to Pray',
        titleAr: 'كيفية الصلاة',
        description: 'Learn the prayer step by step',
        icon: '🕋',
        steps: [
          LearningStep(
            title: 'Before You Begin',
            titleAr: 'قبل أن تبدأ',
            content: 'Before praying, make sure:\n\n'
                '• You have wudu (ablution)\n'
                '• You are facing the Qibla (direction of Kaaba)\n'
                '• Your body and place of prayer are clean\n'
                '• You are dressed modestly\n'
                '• It is the correct prayer time',
          ),
          LearningStep(
            title: 'Step 1: Niyyah (Intention)',
            titleAr: 'النية',
            content:
                'Make the intention in your heart for which prayer you are performing '
                '(Fajr, Dhuhr, Asr, Maghrib, or Isha).\n\n'
                'The intention is in the heart, not spoken aloud.',
          ),
          LearningStep(
            title: 'Step 2: Takbiratul Ihram',
            titleAr: 'تكبيرة الإحرام',
            content:
                'Raise your hands to your ears (or shoulders) and say "Allahu Akbar" '
                '(Allah is the Greatest).\n\n'
                'This begins the prayer. From this point, you are in a state of prayer.',
            arabicText: 'ٱللّٰهُ أَكْبَر',
            transliteration: 'Allahu Akbar',
          ),
          LearningStep(
            title: 'Step 3: Qiyam (Standing)',
            titleAr: 'القيام',
            content:
                'Place your right hand over your left on your chest (or below navel in Hanafi madhab).\n\n'
                'Recite Surah Al-Fatiha, then a short surah or verses from the Quran.',
            arabicText:
                'بِسْمِ ٱللّٰهِ ٱلرَّحْمٰنِ ٱلرَّحِيمِ\n'
                'ٱلْحَمْدُ لِلّٰهِ رَبِّ ٱلْعَالَمِينَ\n'
                'ٱلرَّحْمٰنِ ٱلرَّحِيمِ\n'
                'مَالِكِ يَوْمِ ٱلدِّينِ\n'
                'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ\n'
                'ٱهْدِنَا ٱلصِّرَاطَ ٱلْمُسْتَقِيمَ\n'
                'صِرَاطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّالِّينَ',
            tip: 'Al-Fatiha is recited in every unit (rakah) of prayer.',
          ),
          LearningStep(
            title: 'Step 4: Ruku (Bowing)',
            titleAr: 'الركوع',
            content:
                'Say "Allahu Akbar" and bow. Place your hands on your knees, '
                'keep your back straight.\n\n'
                'While bowing, say three times:',
            arabicText: 'سُبْحَانَ رَبِّيَ ٱلْعَظِيمِ',
            transliteration: 'Subhana Rabbiyal Azeem',
          ),
          LearningStep(
            title: 'Step 5: Stand from Ruku',
            titleAr: 'الرفع من الركوع',
            content: 'Rise from bowing and say:',
            arabicText: 'سَمِعَ ٱللّٰهُ لِمَنْ حَمِدَهُ\nرَبَّنَا وَلَكَ ٱلْحَمْدُ',
            transliteration:
                "Sami'Allahu liman hamidah\nRabbana wa lakal hamd",
          ),
          LearningStep(
            title: 'Step 6: Sujud (Prostration)',
            titleAr: 'السجود',
            content:
                'Say "Allahu Akbar" and prostrate. Seven body parts touch the ground: '
                'forehead with nose, both palms, both knees, and toes of both feet.\n\n'
                'While in sujud, say three times:',
            arabicText: 'سُبْحَانَ رَبِّيَ ٱلْأَعْلَى',
            transliteration: 'Subhana Rabbiyal A\'la',
            tip: 'Sujud is the closest a servant is to Allah. Make dua here.',
          ),
          LearningStep(
            title: 'Step 7: Sitting & Second Sujud',
            titleAr: 'الجلوس والسجدة الثانية',
            content:
                'Rise from sujud saying "Allahu Akbar", sit briefly, '
                'then perform a second sujud the same way.\n\n'
                'This completes one rakah (unit of prayer).',
          ),
          LearningStep(
            title: 'Step 8: Tashahhud & Salam',
            titleAr: 'التشهد والسلام',
            content:
                'In the final sitting, recite the Tashahhud, send blessings on the Prophet ﷺ, '
                'then end the prayer by turning your head right and left saying:',
            arabicText:
                'ٱلسَّلَامُ عَلَيْكُمْ وَرَحْمَةُ ٱللّٰهِ',
            transliteration: "As-salamu alaykum wa rahmatullah",
            tip: 'The number of rakahs: Fajr=2, Dhuhr=4, Asr=4, Maghrib=3, Isha=4',
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
    description: 'Duas, etiquette, and daily practices',
    icon: '🌙',
    lessons: [
      Lesson(
        id: 'daily_duas',
        title: 'Essential Daily Duas',
        titleAr: 'أدعية يومية أساسية',
        description: 'Duas for everyday situations',
        icon: '🤲',
        steps: [
          LearningStep(
            title: 'Before Eating',
            titleAr: 'قبل الأكل',
            content: 'Say Bismillah before eating. If you forget, say:',
            arabicText:
                'بِسْمِ ٱللّٰهِ أَوَّلَهُ وَآخِرَهُ',
            transliteration: "Bismillahi awwalahu wa akhirah",
            tip: 'Source: Abu Dawud 3767',
          ),
          LearningStep(
            title: 'After Eating',
            titleAr: 'بعد الأكل',
            content: 'Thank Allah after finishing your meal:',
            arabicText:
                'ٱلْحَمْدُ لِلّٰهِ ٱلَّذِي أَطْعَمَنِي هَذَا وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ',
            transliteration:
                "Alhamdu lillahil-ladhi at'amani hadha wa razaqanihi min ghayri hawlin minni wa la quwwah",
            tip: 'Source: Abu Dawud 4023, Tirmidhi 3458',
          ),
          LearningStep(
            title: 'Entering the Home',
            titleAr: 'دخول البيت',
            content: 'When entering your home, say:',
            arabicText:
                'بِسْمِ ٱللّٰهِ وَلَجْنَا وَبِسْمِ ٱللّٰهِ خَرَجْنَا وَعَلَى ٱللّٰهِ رَبِّنَا تَوَكَّلْنَا',
            transliteration:
                'Bismillahi walajna, wa bismillahi kharajna, wa ala Allahi rabbina tawakkalna',
            tip: 'Source: Abu Dawud 5096',
          ),
          LearningStep(
            title: 'Before Sleeping',
            titleAr: 'قبل النوم',
            content:
                'The Prophet ﷺ used to recite Ayatul Kursi (2:255) and the last three surahs '
                '(Al-Ikhlas, Al-Falaq, An-Nas) before sleeping.\n\n'
                'Also say:',
            arabicText: 'بِٱسْمِكَ ٱللّٰهُمَّ أَمُوتُ وَأَحْيَا',
            transliteration: 'Bismika Allahumma amutu wa ahya',
            tip: 'Source: Sahih al-Bukhari 6324',
          ),
          LearningStep(
            title: 'Waking Up',
            titleAr: 'عند الاستيقاظ',
            content: 'Upon waking, say:',
            arabicText:
                'ٱلْحَمْدُ لِلّٰهِ ٱلَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ ٱلنُّشُورُ',
            transliteration:
                'Alhamdu lillahil-ladhi ahyana ba\'da ma amatana wa ilayhin-nushur',
            tip: 'Source: Sahih al-Bukhari 6324',
          ),
        ],
      ),
      Lesson(
        id: 'friday',
        title: 'Friday — Jumu\'ah',
        titleAr: 'يوم الجمعة',
        description: 'The importance and etiquette of Friday',
        icon: '🕌',
        steps: [
          LearningStep(
            title: 'The Best Day',
            titleAr: 'خير يوم',
            content:
                'The Prophet ﷺ said: "The best day on which the sun rises is Friday. '
                'On it Adam was created, on it he was admitted to Paradise, '
                'and on it he was expelled from it."',
            tip: 'Source: Sahih Muslim 854',
          ),
          LearningStep(
            title: 'Sunnah of Friday',
            titleAr: 'سنن يوم الجمعة',
            content: 'Recommended acts on Friday:\n\n'
                '• Take a bath (ghusl)\n'
                '• Wear clean/best clothes\n'
                '• Use perfume\n'
                '• Go early to the mosque\n'
                '• Read Surah Al-Kahf (18)\n'
                '• Send abundant blessings on the Prophet ﷺ\n'
                '• Make dua (there is an hour of acceptance)',
          ),
        ],
      ),
    ],
  ),
];
