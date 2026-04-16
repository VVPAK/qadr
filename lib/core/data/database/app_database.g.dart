// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SurahsTable extends Surahs with TableInfo<$SurahsTable, Surah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SurahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameArabicMeta = const VerificationMeta(
    'nameArabic',
  );
  @override
  late final GeneratedColumn<String> nameArabic = GeneratedColumn<String>(
    'name_arabic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnglishMeta = const VerificationMeta(
    'nameEnglish',
  );
  @override
  late final GeneratedColumn<String> nameEnglish = GeneratedColumn<String>(
    'name_english',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameRussianMeta = const VerificationMeta(
    'nameRussian',
  );
  @override
  late final GeneratedColumn<String> nameRussian = GeneratedColumn<String>(
    'name_russian',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revelationTypeMeta = const VerificationMeta(
    'revelationType',
  );
  @override
  late final GeneratedColumn<String> revelationType = GeneratedColumn<String>(
    'revelation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ayahCountMeta = const VerificationMeta(
    'ayahCount',
  );
  @override
  late final GeneratedColumn<int> ayahCount = GeneratedColumn<int>(
    'ayah_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    number,
    nameArabic,
    nameEnglish,
    nameRussian,
    revelationType,
    ayahCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'surahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Surah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('name_arabic')) {
      context.handle(
        _nameArabicMeta,
        nameArabic.isAcceptableOrUnknown(data['name_arabic']!, _nameArabicMeta),
      );
    } else if (isInserting) {
      context.missing(_nameArabicMeta);
    }
    if (data.containsKey('name_english')) {
      context.handle(
        _nameEnglishMeta,
        nameEnglish.isAcceptableOrUnknown(
          data['name_english']!,
          _nameEnglishMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nameEnglishMeta);
    }
    if (data.containsKey('name_russian')) {
      context.handle(
        _nameRussianMeta,
        nameRussian.isAcceptableOrUnknown(
          data['name_russian']!,
          _nameRussianMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nameRussianMeta);
    }
    if (data.containsKey('revelation_type')) {
      context.handle(
        _revelationTypeMeta,
        revelationType.isAcceptableOrUnknown(
          data['revelation_type']!,
          _revelationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_revelationTypeMeta);
    }
    if (data.containsKey('ayah_count')) {
      context.handle(
        _ayahCountMeta,
        ayahCount.isAcceptableOrUnknown(data['ayah_count']!, _ayahCountMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {number};
  @override
  Surah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Surah(
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number'],
      )!,
      nameArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_arabic'],
      )!,
      nameEnglish: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_english'],
      )!,
      nameRussian: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_russian'],
      )!,
      revelationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}revelation_type'],
      )!,
      ayahCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_count'],
      )!,
    );
  }

  @override
  $SurahsTable createAlias(String alias) {
    return $SurahsTable(attachedDatabase, alias);
  }
}

class Surah extends DataClass implements Insertable<Surah> {
  final int number;
  final String nameArabic;
  final String nameEnglish;
  final String nameRussian;
  final String revelationType;
  final int ayahCount;
  const Surah({
    required this.number,
    required this.nameArabic,
    required this.nameEnglish,
    required this.nameRussian,
    required this.revelationType,
    required this.ayahCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['number'] = Variable<int>(number);
    map['name_arabic'] = Variable<String>(nameArabic);
    map['name_english'] = Variable<String>(nameEnglish);
    map['name_russian'] = Variable<String>(nameRussian);
    map['revelation_type'] = Variable<String>(revelationType);
    map['ayah_count'] = Variable<int>(ayahCount);
    return map;
  }

  SurahsCompanion toCompanion(bool nullToAbsent) {
    return SurahsCompanion(
      number: Value(number),
      nameArabic: Value(nameArabic),
      nameEnglish: Value(nameEnglish),
      nameRussian: Value(nameRussian),
      revelationType: Value(revelationType),
      ayahCount: Value(ayahCount),
    );
  }

  factory Surah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Surah(
      number: serializer.fromJson<int>(json['number']),
      nameArabic: serializer.fromJson<String>(json['nameArabic']),
      nameEnglish: serializer.fromJson<String>(json['nameEnglish']),
      nameRussian: serializer.fromJson<String>(json['nameRussian']),
      revelationType: serializer.fromJson<String>(json['revelationType']),
      ayahCount: serializer.fromJson<int>(json['ayahCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'number': serializer.toJson<int>(number),
      'nameArabic': serializer.toJson<String>(nameArabic),
      'nameEnglish': serializer.toJson<String>(nameEnglish),
      'nameRussian': serializer.toJson<String>(nameRussian),
      'revelationType': serializer.toJson<String>(revelationType),
      'ayahCount': serializer.toJson<int>(ayahCount),
    };
  }

  Surah copyWith({
    int? number,
    String? nameArabic,
    String? nameEnglish,
    String? nameRussian,
    String? revelationType,
    int? ayahCount,
  }) => Surah(
    number: number ?? this.number,
    nameArabic: nameArabic ?? this.nameArabic,
    nameEnglish: nameEnglish ?? this.nameEnglish,
    nameRussian: nameRussian ?? this.nameRussian,
    revelationType: revelationType ?? this.revelationType,
    ayahCount: ayahCount ?? this.ayahCount,
  );
  Surah copyWithCompanion(SurahsCompanion data) {
    return Surah(
      number: data.number.present ? data.number.value : this.number,
      nameArabic: data.nameArabic.present
          ? data.nameArabic.value
          : this.nameArabic,
      nameEnglish: data.nameEnglish.present
          ? data.nameEnglish.value
          : this.nameEnglish,
      nameRussian: data.nameRussian.present
          ? data.nameRussian.value
          : this.nameRussian,
      revelationType: data.revelationType.present
          ? data.revelationType.value
          : this.revelationType,
      ayahCount: data.ayahCount.present ? data.ayahCount.value : this.ayahCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Surah(')
          ..write('number: $number, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameEnglish: $nameEnglish, ')
          ..write('nameRussian: $nameRussian, ')
          ..write('revelationType: $revelationType, ')
          ..write('ayahCount: $ayahCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    number,
    nameArabic,
    nameEnglish,
    nameRussian,
    revelationType,
    ayahCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Surah &&
          other.number == this.number &&
          other.nameArabic == this.nameArabic &&
          other.nameEnglish == this.nameEnglish &&
          other.nameRussian == this.nameRussian &&
          other.revelationType == this.revelationType &&
          other.ayahCount == this.ayahCount);
}

class SurahsCompanion extends UpdateCompanion<Surah> {
  final Value<int> number;
  final Value<String> nameArabic;
  final Value<String> nameEnglish;
  final Value<String> nameRussian;
  final Value<String> revelationType;
  final Value<int> ayahCount;
  const SurahsCompanion({
    this.number = const Value.absent(),
    this.nameArabic = const Value.absent(),
    this.nameEnglish = const Value.absent(),
    this.nameRussian = const Value.absent(),
    this.revelationType = const Value.absent(),
    this.ayahCount = const Value.absent(),
  });
  SurahsCompanion.insert({
    this.number = const Value.absent(),
    required String nameArabic,
    required String nameEnglish,
    required String nameRussian,
    required String revelationType,
    required int ayahCount,
  }) : nameArabic = Value(nameArabic),
       nameEnglish = Value(nameEnglish),
       nameRussian = Value(nameRussian),
       revelationType = Value(revelationType),
       ayahCount = Value(ayahCount);
  static Insertable<Surah> custom({
    Expression<int>? number,
    Expression<String>? nameArabic,
    Expression<String>? nameEnglish,
    Expression<String>? nameRussian,
    Expression<String>? revelationType,
    Expression<int>? ayahCount,
  }) {
    return RawValuesInsertable({
      if (number != null) 'number': number,
      if (nameArabic != null) 'name_arabic': nameArabic,
      if (nameEnglish != null) 'name_english': nameEnglish,
      if (nameRussian != null) 'name_russian': nameRussian,
      if (revelationType != null) 'revelation_type': revelationType,
      if (ayahCount != null) 'ayah_count': ayahCount,
    });
  }

  SurahsCompanion copyWith({
    Value<int>? number,
    Value<String>? nameArabic,
    Value<String>? nameEnglish,
    Value<String>? nameRussian,
    Value<String>? revelationType,
    Value<int>? ayahCount,
  }) {
    return SurahsCompanion(
      number: number ?? this.number,
      nameArabic: nameArabic ?? this.nameArabic,
      nameEnglish: nameEnglish ?? this.nameEnglish,
      nameRussian: nameRussian ?? this.nameRussian,
      revelationType: revelationType ?? this.revelationType,
      ayahCount: ayahCount ?? this.ayahCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (nameArabic.present) {
      map['name_arabic'] = Variable<String>(nameArabic.value);
    }
    if (nameEnglish.present) {
      map['name_english'] = Variable<String>(nameEnglish.value);
    }
    if (nameRussian.present) {
      map['name_russian'] = Variable<String>(nameRussian.value);
    }
    if (revelationType.present) {
      map['revelation_type'] = Variable<String>(revelationType.value);
    }
    if (ayahCount.present) {
      map['ayah_count'] = Variable<int>(ayahCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SurahsCompanion(')
          ..write('number: $number, ')
          ..write('nameArabic: $nameArabic, ')
          ..write('nameEnglish: $nameEnglish, ')
          ..write('nameRussian: $nameRussian, ')
          ..write('revelationType: $revelationType, ')
          ..write('ayahCount: $ayahCount')
          ..write(')'))
        .toString();
  }
}

class $AyahsTable extends Ayahs with TableInfo<$AyahsTable, Ayah> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AyahsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _surahNumberMeta = const VerificationMeta(
    'surahNumber',
  );
  @override
  late final GeneratedColumn<int> surahNumber = GeneratedColumn<int>(
    'surah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES surahs (number)',
    ),
  );
  static const VerificationMeta _ayahNumberMeta = const VerificationMeta(
    'ayahNumber',
  );
  @override
  late final GeneratedColumn<int> ayahNumber = GeneratedColumn<int>(
    'ayah_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textArabicMeta = const VerificationMeta(
    'textArabic',
  );
  @override
  late final GeneratedColumn<String> textArabic = GeneratedColumn<String>(
    'text_arabic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textEnglishMeta = const VerificationMeta(
    'textEnglish',
  );
  @override
  late final GeneratedColumn<String> textEnglish = GeneratedColumn<String>(
    'text_english',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textRussianMeta = const VerificationMeta(
    'textRussian',
  );
  @override
  late final GeneratedColumn<String> textRussian = GeneratedColumn<String>(
    'text_russian',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    surahNumber,
    ayahNumber,
    textArabic,
    textEnglish,
    textRussian,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ayahs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ayah> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('surah_number')) {
      context.handle(
        _surahNumberMeta,
        surahNumber.isAcceptableOrUnknown(
          data['surah_number']!,
          _surahNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_surahNumberMeta);
    }
    if (data.containsKey('ayah_number')) {
      context.handle(
        _ayahNumberMeta,
        ayahNumber.isAcceptableOrUnknown(data['ayah_number']!, _ayahNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_ayahNumberMeta);
    }
    if (data.containsKey('text_arabic')) {
      context.handle(
        _textArabicMeta,
        textArabic.isAcceptableOrUnknown(data['text_arabic']!, _textArabicMeta),
      );
    } else if (isInserting) {
      context.missing(_textArabicMeta);
    }
    if (data.containsKey('text_english')) {
      context.handle(
        _textEnglishMeta,
        textEnglish.isAcceptableOrUnknown(
          data['text_english']!,
          _textEnglishMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_textEnglishMeta);
    }
    if (data.containsKey('text_russian')) {
      context.handle(
        _textRussianMeta,
        textRussian.isAcceptableOrUnknown(
          data['text_russian']!,
          _textRussianMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_textRussianMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surahNumber, ayahNumber};
  @override
  Ayah map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ayah(
      surahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}surah_number'],
      )!,
      ayahNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ayah_number'],
      )!,
      textArabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_arabic'],
      )!,
      textEnglish: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_english'],
      )!,
      textRussian: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_russian'],
      )!,
    );
  }

  @override
  $AyahsTable createAlias(String alias) {
    return $AyahsTable(attachedDatabase, alias);
  }
}

class Ayah extends DataClass implements Insertable<Ayah> {
  final int surahNumber;
  final int ayahNumber;
  final String textArabic;
  final String textEnglish;
  final String textRussian;
  const Ayah({
    required this.surahNumber,
    required this.ayahNumber,
    required this.textArabic,
    required this.textEnglish,
    required this.textRussian,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['surah_number'] = Variable<int>(surahNumber);
    map['ayah_number'] = Variable<int>(ayahNumber);
    map['text_arabic'] = Variable<String>(textArabic);
    map['text_english'] = Variable<String>(textEnglish);
    map['text_russian'] = Variable<String>(textRussian);
    return map;
  }

  AyahsCompanion toCompanion(bool nullToAbsent) {
    return AyahsCompanion(
      surahNumber: Value(surahNumber),
      ayahNumber: Value(ayahNumber),
      textArabic: Value(textArabic),
      textEnglish: Value(textEnglish),
      textRussian: Value(textRussian),
    );
  }

  factory Ayah.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ayah(
      surahNumber: serializer.fromJson<int>(json['surahNumber']),
      ayahNumber: serializer.fromJson<int>(json['ayahNumber']),
      textArabic: serializer.fromJson<String>(json['textArabic']),
      textEnglish: serializer.fromJson<String>(json['textEnglish']),
      textRussian: serializer.fromJson<String>(json['textRussian']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surahNumber': serializer.toJson<int>(surahNumber),
      'ayahNumber': serializer.toJson<int>(ayahNumber),
      'textArabic': serializer.toJson<String>(textArabic),
      'textEnglish': serializer.toJson<String>(textEnglish),
      'textRussian': serializer.toJson<String>(textRussian),
    };
  }

  Ayah copyWith({
    int? surahNumber,
    int? ayahNumber,
    String? textArabic,
    String? textEnglish,
    String? textRussian,
  }) => Ayah(
    surahNumber: surahNumber ?? this.surahNumber,
    ayahNumber: ayahNumber ?? this.ayahNumber,
    textArabic: textArabic ?? this.textArabic,
    textEnglish: textEnglish ?? this.textEnglish,
    textRussian: textRussian ?? this.textRussian,
  );
  Ayah copyWithCompanion(AyahsCompanion data) {
    return Ayah(
      surahNumber: data.surahNumber.present
          ? data.surahNumber.value
          : this.surahNumber,
      ayahNumber: data.ayahNumber.present
          ? data.ayahNumber.value
          : this.ayahNumber,
      textArabic: data.textArabic.present
          ? data.textArabic.value
          : this.textArabic,
      textEnglish: data.textEnglish.present
          ? data.textEnglish.value
          : this.textEnglish,
      textRussian: data.textRussian.present
          ? data.textRussian.value
          : this.textRussian,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ayah(')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('textArabic: $textArabic, ')
          ..write('textEnglish: $textEnglish, ')
          ..write('textRussian: $textRussian')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    surahNumber,
    ayahNumber,
    textArabic,
    textEnglish,
    textRussian,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ayah &&
          other.surahNumber == this.surahNumber &&
          other.ayahNumber == this.ayahNumber &&
          other.textArabic == this.textArabic &&
          other.textEnglish == this.textEnglish &&
          other.textRussian == this.textRussian);
}

class AyahsCompanion extends UpdateCompanion<Ayah> {
  final Value<int> surahNumber;
  final Value<int> ayahNumber;
  final Value<String> textArabic;
  final Value<String> textEnglish;
  final Value<String> textRussian;
  final Value<int> rowid;
  const AyahsCompanion({
    this.surahNumber = const Value.absent(),
    this.ayahNumber = const Value.absent(),
    this.textArabic = const Value.absent(),
    this.textEnglish = const Value.absent(),
    this.textRussian = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AyahsCompanion.insert({
    required int surahNumber,
    required int ayahNumber,
    required String textArabic,
    required String textEnglish,
    required String textRussian,
    this.rowid = const Value.absent(),
  }) : surahNumber = Value(surahNumber),
       ayahNumber = Value(ayahNumber),
       textArabic = Value(textArabic),
       textEnglish = Value(textEnglish),
       textRussian = Value(textRussian);
  static Insertable<Ayah> custom({
    Expression<int>? surahNumber,
    Expression<int>? ayahNumber,
    Expression<String>? textArabic,
    Expression<String>? textEnglish,
    Expression<String>? textRussian,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (surahNumber != null) 'surah_number': surahNumber,
      if (ayahNumber != null) 'ayah_number': ayahNumber,
      if (textArabic != null) 'text_arabic': textArabic,
      if (textEnglish != null) 'text_english': textEnglish,
      if (textRussian != null) 'text_russian': textRussian,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AyahsCompanion copyWith({
    Value<int>? surahNumber,
    Value<int>? ayahNumber,
    Value<String>? textArabic,
    Value<String>? textEnglish,
    Value<String>? textRussian,
    Value<int>? rowid,
  }) {
    return AyahsCompanion(
      surahNumber: surahNumber ?? this.surahNumber,
      ayahNumber: ayahNumber ?? this.ayahNumber,
      textArabic: textArabic ?? this.textArabic,
      textEnglish: textEnglish ?? this.textEnglish,
      textRussian: textRussian ?? this.textRussian,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surahNumber.present) {
      map['surah_number'] = Variable<int>(surahNumber.value);
    }
    if (ayahNumber.present) {
      map['ayah_number'] = Variable<int>(ayahNumber.value);
    }
    if (textArabic.present) {
      map['text_arabic'] = Variable<String>(textArabic.value);
    }
    if (textEnglish.present) {
      map['text_english'] = Variable<String>(textEnglish.value);
    }
    if (textRussian.present) {
      map['text_russian'] = Variable<String>(textRussian.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AyahsCompanion(')
          ..write('surahNumber: $surahNumber, ')
          ..write('ayahNumber: $ayahNumber, ')
          ..write('textArabic: $textArabic, ')
          ..write('textEnglish: $textEnglish, ')
          ..write('textRussian: $textRussian, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DuasTable extends Duas with TableInfo<$DuasTable, Dua> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DuasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arabicMeta = const VerificationMeta('arabic');
  @override
  late final GeneratedColumn<String> arabic = GeneratedColumn<String>(
    'arabic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transliterationMeta = const VerificationMeta(
    'transliteration',
  );
  @override
  late final GeneratedColumn<String> transliteration = GeneratedColumn<String>(
    'transliteration',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationEnMeta = const VerificationMeta(
    'translationEn',
  );
  @override
  late final GeneratedColumn<String> translationEn = GeneratedColumn<String>(
    'translation_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _translationRuMeta = const VerificationMeta(
    'translationRu',
  );
  @override
  late final GeneratedColumn<String> translationRu = GeneratedColumn<String>(
    'translation_ru',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    category,
    arabic,
    transliteration,
    translationEn,
    translationRu,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'duas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Dua> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('arabic')) {
      context.handle(
        _arabicMeta,
        arabic.isAcceptableOrUnknown(data['arabic']!, _arabicMeta),
      );
    } else if (isInserting) {
      context.missing(_arabicMeta);
    }
    if (data.containsKey('transliteration')) {
      context.handle(
        _transliterationMeta,
        transliteration.isAcceptableOrUnknown(
          data['transliteration']!,
          _transliterationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transliterationMeta);
    }
    if (data.containsKey('translation_en')) {
      context.handle(
        _translationEnMeta,
        translationEn.isAcceptableOrUnknown(
          data['translation_en']!,
          _translationEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationEnMeta);
    }
    if (data.containsKey('translation_ru')) {
      context.handle(
        _translationRuMeta,
        translationRu.isAcceptableOrUnknown(
          data['translation_ru']!,
          _translationRuMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_translationRuMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Dua map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Dua(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      arabic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arabic'],
      )!,
      transliteration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transliteration'],
      )!,
      translationEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_en'],
      )!,
      translationRu: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}translation_ru'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
    );
  }

  @override
  $DuasTable createAlias(String alias) {
    return $DuasTable(attachedDatabase, alias);
  }
}

class Dua extends DataClass implements Insertable<Dua> {
  final int id;
  final String category;
  final String arabic;
  final String transliteration;
  final String translationEn;
  final String translationRu;
  final String source;
  const Dua({
    required this.id,
    required this.category,
    required this.arabic,
    required this.transliteration,
    required this.translationEn,
    required this.translationRu,
    required this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category'] = Variable<String>(category);
    map['arabic'] = Variable<String>(arabic);
    map['transliteration'] = Variable<String>(transliteration);
    map['translation_en'] = Variable<String>(translationEn);
    map['translation_ru'] = Variable<String>(translationRu);
    map['source'] = Variable<String>(source);
    return map;
  }

  DuasCompanion toCompanion(bool nullToAbsent) {
    return DuasCompanion(
      id: Value(id),
      category: Value(category),
      arabic: Value(arabic),
      transliteration: Value(transliteration),
      translationEn: Value(translationEn),
      translationRu: Value(translationRu),
      source: Value(source),
    );
  }

  factory Dua.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dua(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      arabic: serializer.fromJson<String>(json['arabic']),
      transliteration: serializer.fromJson<String>(json['transliteration']),
      translationEn: serializer.fromJson<String>(json['translationEn']),
      translationRu: serializer.fromJson<String>(json['translationRu']),
      source: serializer.fromJson<String>(json['source']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String>(category),
      'arabic': serializer.toJson<String>(arabic),
      'transliteration': serializer.toJson<String>(transliteration),
      'translationEn': serializer.toJson<String>(translationEn),
      'translationRu': serializer.toJson<String>(translationRu),
      'source': serializer.toJson<String>(source),
    };
  }

  Dua copyWith({
    int? id,
    String? category,
    String? arabic,
    String? transliteration,
    String? translationEn,
    String? translationRu,
    String? source,
  }) => Dua(
    id: id ?? this.id,
    category: category ?? this.category,
    arabic: arabic ?? this.arabic,
    transliteration: transliteration ?? this.transliteration,
    translationEn: translationEn ?? this.translationEn,
    translationRu: translationRu ?? this.translationRu,
    source: source ?? this.source,
  );
  Dua copyWithCompanion(DuasCompanion data) {
    return Dua(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      arabic: data.arabic.present ? data.arabic.value : this.arabic,
      transliteration: data.transliteration.present
          ? data.transliteration.value
          : this.transliteration,
      translationEn: data.translationEn.present
          ? data.translationEn.value
          : this.translationEn,
      translationRu: data.translationRu.present
          ? data.translationRu.value
          : this.translationRu,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dua(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('arabic: $arabic, ')
          ..write('transliteration: $transliteration, ')
          ..write('translationEn: $translationEn, ')
          ..write('translationRu: $translationRu, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    category,
    arabic,
    transliteration,
    translationEn,
    translationRu,
    source,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dua &&
          other.id == this.id &&
          other.category == this.category &&
          other.arabic == this.arabic &&
          other.transliteration == this.transliteration &&
          other.translationEn == this.translationEn &&
          other.translationRu == this.translationRu &&
          other.source == this.source);
}

class DuasCompanion extends UpdateCompanion<Dua> {
  final Value<int> id;
  final Value<String> category;
  final Value<String> arabic;
  final Value<String> transliteration;
  final Value<String> translationEn;
  final Value<String> translationRu;
  final Value<String> source;
  const DuasCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.arabic = const Value.absent(),
    this.transliteration = const Value.absent(),
    this.translationEn = const Value.absent(),
    this.translationRu = const Value.absent(),
    this.source = const Value.absent(),
  });
  DuasCompanion.insert({
    this.id = const Value.absent(),
    required String category,
    required String arabic,
    required String transliteration,
    required String translationEn,
    required String translationRu,
    required String source,
  }) : category = Value(category),
       arabic = Value(arabic),
       transliteration = Value(transliteration),
       translationEn = Value(translationEn),
       translationRu = Value(translationRu),
       source = Value(source);
  static Insertable<Dua> custom({
    Expression<int>? id,
    Expression<String>? category,
    Expression<String>? arabic,
    Expression<String>? transliteration,
    Expression<String>? translationEn,
    Expression<String>? translationRu,
    Expression<String>? source,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (arabic != null) 'arabic': arabic,
      if (transliteration != null) 'transliteration': transliteration,
      if (translationEn != null) 'translation_en': translationEn,
      if (translationRu != null) 'translation_ru': translationRu,
      if (source != null) 'source': source,
    });
  }

  DuasCompanion copyWith({
    Value<int>? id,
    Value<String>? category,
    Value<String>? arabic,
    Value<String>? transliteration,
    Value<String>? translationEn,
    Value<String>? translationRu,
    Value<String>? source,
  }) {
    return DuasCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      arabic: arabic ?? this.arabic,
      transliteration: transliteration ?? this.transliteration,
      translationEn: translationEn ?? this.translationEn,
      translationRu: translationRu ?? this.translationRu,
      source: source ?? this.source,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (arabic.present) {
      map['arabic'] = Variable<String>(arabic.value);
    }
    if (transliteration.present) {
      map['transliteration'] = Variable<String>(transliteration.value);
    }
    if (translationEn.present) {
      map['translation_en'] = Variable<String>(translationEn.value);
    }
    if (translationRu.present) {
      map['translation_ru'] = Variable<String>(translationRu.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DuasCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('arabic: $arabic, ')
          ..write('transliteration: $transliteration, ')
          ..write('translationEn: $translationEn, ')
          ..write('translationRu: $translationRu, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SurahsTable surahs = $SurahsTable(this);
  late final $AyahsTable ayahs = $AyahsTable(this);
  late final $DuasTable duas = $DuasTable(this);
  late final QuranDao quranDao = QuranDao(this as AppDatabase);
  late final DuaDao duaDao = DuaDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [surahs, ayahs, duas];
}

typedef $$SurahsTableCreateCompanionBuilder =
    SurahsCompanion Function({
      Value<int> number,
      required String nameArabic,
      required String nameEnglish,
      required String nameRussian,
      required String revelationType,
      required int ayahCount,
    });
typedef $$SurahsTableUpdateCompanionBuilder =
    SurahsCompanion Function({
      Value<int> number,
      Value<String> nameArabic,
      Value<String> nameEnglish,
      Value<String> nameRussian,
      Value<String> revelationType,
      Value<int> ayahCount,
    });

final class $$SurahsTableReferences
    extends BaseReferences<_$AppDatabase, $SurahsTable, Surah> {
  $$SurahsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AyahsTable, List<Ayah>> _ayahsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ayahs,
    aliasName: $_aliasNameGenerator(db.surahs.number, db.ayahs.surahNumber),
  );

  $$AyahsTableProcessedTableManager get ayahsRefs {
    final manager = $$AyahsTableTableManager($_db, $_db.ayahs).filter(
      (f) => f.surahNumber.number.sqlEquals($_itemColumn<int>('number')!),
    );

    final cache = $_typedResult.readTableOrNull(_ayahsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SurahsTableFilterComposer
    extends Composer<_$AppDatabase, $SurahsTable> {
  $$SurahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEnglish => $composableBuilder(
    column: $table.nameEnglish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameRussian => $composableBuilder(
    column: $table.nameRussian,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get revelationType => $composableBuilder(
    column: $table.revelationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ayahCount => $composableBuilder(
    column: $table.ayahCount,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ayahsRefs(
    Expression<bool> Function($$AyahsTableFilterComposer f) f,
  ) {
    final $$AyahsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.number,
      referencedTable: $db.ayahs,
      getReferencedColumn: (t) => t.surahNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AyahsTableFilterComposer(
            $db: $db,
            $table: $db.ayahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SurahsTableOrderingComposer
    extends Composer<_$AppDatabase, $SurahsTable> {
  $$SurahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEnglish => $composableBuilder(
    column: $table.nameEnglish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameRussian => $composableBuilder(
    column: $table.nameRussian,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get revelationType => $composableBuilder(
    column: $table.revelationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ayahCount => $composableBuilder(
    column: $table.ayahCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SurahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SurahsTable> {
  $$SurahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get nameArabic => $composableBuilder(
    column: $table.nameArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameEnglish => $composableBuilder(
    column: $table.nameEnglish,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nameRussian => $composableBuilder(
    column: $table.nameRussian,
    builder: (column) => column,
  );

  GeneratedColumn<String> get revelationType => $composableBuilder(
    column: $table.revelationType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ayahCount =>
      $composableBuilder(column: $table.ayahCount, builder: (column) => column);

  Expression<T> ayahsRefs<T extends Object>(
    Expression<T> Function($$AyahsTableAnnotationComposer a) f,
  ) {
    final $$AyahsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.number,
      referencedTable: $db.ayahs,
      getReferencedColumn: (t) => t.surahNumber,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AyahsTableAnnotationComposer(
            $db: $db,
            $table: $db.ayahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SurahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SurahsTable,
          Surah,
          $$SurahsTableFilterComposer,
          $$SurahsTableOrderingComposer,
          $$SurahsTableAnnotationComposer,
          $$SurahsTableCreateCompanionBuilder,
          $$SurahsTableUpdateCompanionBuilder,
          (Surah, $$SurahsTableReferences),
          Surah,
          PrefetchHooks Function({bool ayahsRefs})
        > {
  $$SurahsTableTableManager(_$AppDatabase db, $SurahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SurahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SurahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SurahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                Value<String> nameArabic = const Value.absent(),
                Value<String> nameEnglish = const Value.absent(),
                Value<String> nameRussian = const Value.absent(),
                Value<String> revelationType = const Value.absent(),
                Value<int> ayahCount = const Value.absent(),
              }) => SurahsCompanion(
                number: number,
                nameArabic: nameArabic,
                nameEnglish: nameEnglish,
                nameRussian: nameRussian,
                revelationType: revelationType,
                ayahCount: ayahCount,
              ),
          createCompanionCallback:
              ({
                Value<int> number = const Value.absent(),
                required String nameArabic,
                required String nameEnglish,
                required String nameRussian,
                required String revelationType,
                required int ayahCount,
              }) => SurahsCompanion.insert(
                number: number,
                nameArabic: nameArabic,
                nameEnglish: nameEnglish,
                nameRussian: nameRussian,
                revelationType: revelationType,
                ayahCount: ayahCount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$SurahsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({ayahsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ayahsRefs) db.ayahs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ayahsRefs)
                    await $_getPrefetchedData<Surah, $SurahsTable, Ayah>(
                      currentTable: table,
                      referencedTable: $$SurahsTableReferences._ayahsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$SurahsTableReferences(db, table, p0).ayahsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.surahNumber == item.number,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SurahsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SurahsTable,
      Surah,
      $$SurahsTableFilterComposer,
      $$SurahsTableOrderingComposer,
      $$SurahsTableAnnotationComposer,
      $$SurahsTableCreateCompanionBuilder,
      $$SurahsTableUpdateCompanionBuilder,
      (Surah, $$SurahsTableReferences),
      Surah,
      PrefetchHooks Function({bool ayahsRefs})
    >;
typedef $$AyahsTableCreateCompanionBuilder =
    AyahsCompanion Function({
      required int surahNumber,
      required int ayahNumber,
      required String textArabic,
      required String textEnglish,
      required String textRussian,
      Value<int> rowid,
    });
typedef $$AyahsTableUpdateCompanionBuilder =
    AyahsCompanion Function({
      Value<int> surahNumber,
      Value<int> ayahNumber,
      Value<String> textArabic,
      Value<String> textEnglish,
      Value<String> textRussian,
      Value<int> rowid,
    });

final class $$AyahsTableReferences
    extends BaseReferences<_$AppDatabase, $AyahsTable, Ayah> {
  $$AyahsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SurahsTable _surahNumberTable(_$AppDatabase db) =>
      db.surahs.createAlias(
        $_aliasNameGenerator(db.ayahs.surahNumber, db.surahs.number),
      );

  $$SurahsTableProcessedTableManager get surahNumber {
    final $_column = $_itemColumn<int>('surah_number')!;

    final manager = $$SurahsTableTableManager(
      $_db,
      $_db.surahs,
    ).filter((f) => f.number.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_surahNumberTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AyahsTableFilterComposer extends Composer<_$AppDatabase, $AyahsTable> {
  $$AyahsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textArabic => $composableBuilder(
    column: $table.textArabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textEnglish => $composableBuilder(
    column: $table.textEnglish,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textRussian => $composableBuilder(
    column: $table.textRussian,
    builder: (column) => ColumnFilters(column),
  );

  $$SurahsTableFilterComposer get surahNumber {
    final $$SurahsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahNumber,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.number,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableFilterComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahsTableOrderingComposer
    extends Composer<_$AppDatabase, $AyahsTable> {
  $$AyahsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textArabic => $composableBuilder(
    column: $table.textArabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textEnglish => $composableBuilder(
    column: $table.textEnglish,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textRussian => $composableBuilder(
    column: $table.textRussian,
    builder: (column) => ColumnOrderings(column),
  );

  $$SurahsTableOrderingComposer get surahNumber {
    final $$SurahsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahNumber,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.number,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableOrderingComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AyahsTable> {
  $$AyahsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ayahNumber => $composableBuilder(
    column: $table.ayahNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textArabic => $composableBuilder(
    column: $table.textArabic,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textEnglish => $composableBuilder(
    column: $table.textEnglish,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textRussian => $composableBuilder(
    column: $table.textRussian,
    builder: (column) => column,
  );

  $$SurahsTableAnnotationComposer get surahNumber {
    final $$SurahsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.surahNumber,
      referencedTable: $db.surahs,
      getReferencedColumn: (t) => t.number,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SurahsTableAnnotationComposer(
            $db: $db,
            $table: $db.surahs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AyahsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AyahsTable,
          Ayah,
          $$AyahsTableFilterComposer,
          $$AyahsTableOrderingComposer,
          $$AyahsTableAnnotationComposer,
          $$AyahsTableCreateCompanionBuilder,
          $$AyahsTableUpdateCompanionBuilder,
          (Ayah, $$AyahsTableReferences),
          Ayah,
          PrefetchHooks Function({bool surahNumber})
        > {
  $$AyahsTableTableManager(_$AppDatabase db, $AyahsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AyahsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AyahsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AyahsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> surahNumber = const Value.absent(),
                Value<int> ayahNumber = const Value.absent(),
                Value<String> textArabic = const Value.absent(),
                Value<String> textEnglish = const Value.absent(),
                Value<String> textRussian = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AyahsCompanion(
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                textArabic: textArabic,
                textEnglish: textEnglish,
                textRussian: textRussian,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int surahNumber,
                required int ayahNumber,
                required String textArabic,
                required String textEnglish,
                required String textRussian,
                Value<int> rowid = const Value.absent(),
              }) => AyahsCompanion.insert(
                surahNumber: surahNumber,
                ayahNumber: ayahNumber,
                textArabic: textArabic,
                textEnglish: textEnglish,
                textRussian: textRussian,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$AyahsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({surahNumber = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (surahNumber) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.surahNumber,
                                referencedTable: $$AyahsTableReferences
                                    ._surahNumberTable(db),
                                referencedColumn: $$AyahsTableReferences
                                    ._surahNumberTable(db)
                                    .number,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AyahsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AyahsTable,
      Ayah,
      $$AyahsTableFilterComposer,
      $$AyahsTableOrderingComposer,
      $$AyahsTableAnnotationComposer,
      $$AyahsTableCreateCompanionBuilder,
      $$AyahsTableUpdateCompanionBuilder,
      (Ayah, $$AyahsTableReferences),
      Ayah,
      PrefetchHooks Function({bool surahNumber})
    >;
typedef $$DuasTableCreateCompanionBuilder =
    DuasCompanion Function({
      Value<int> id,
      required String category,
      required String arabic,
      required String transliteration,
      required String translationEn,
      required String translationRu,
      required String source,
    });
typedef $$DuasTableUpdateCompanionBuilder =
    DuasCompanion Function({
      Value<int> id,
      Value<String> category,
      Value<String> arabic,
      Value<String> transliteration,
      Value<String> translationEn,
      Value<String> translationRu,
      Value<String> source,
    });

class $$DuasTableFilterComposer extends Composer<_$AppDatabase, $DuasTable> {
  $$DuasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arabic => $composableBuilder(
    column: $table.arabic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transliteration => $composableBuilder(
    column: $table.transliteration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationEn => $composableBuilder(
    column: $table.translationEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get translationRu => $composableBuilder(
    column: $table.translationRu,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DuasTableOrderingComposer extends Composer<_$AppDatabase, $DuasTable> {
  $$DuasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arabic => $composableBuilder(
    column: $table.arabic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transliteration => $composableBuilder(
    column: $table.transliteration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationEn => $composableBuilder(
    column: $table.translationEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get translationRu => $composableBuilder(
    column: $table.translationRu,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DuasTableAnnotationComposer
    extends Composer<_$AppDatabase, $DuasTable> {
  $$DuasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get arabic =>
      $composableBuilder(column: $table.arabic, builder: (column) => column);

  GeneratedColumn<String> get transliteration => $composableBuilder(
    column: $table.transliteration,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translationEn => $composableBuilder(
    column: $table.translationEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get translationRu => $composableBuilder(
    column: $table.translationRu,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);
}

class $$DuasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DuasTable,
          Dua,
          $$DuasTableFilterComposer,
          $$DuasTableOrderingComposer,
          $$DuasTableAnnotationComposer,
          $$DuasTableCreateCompanionBuilder,
          $$DuasTableUpdateCompanionBuilder,
          (Dua, BaseReferences<_$AppDatabase, $DuasTable, Dua>),
          Dua,
          PrefetchHooks Function()
        > {
  $$DuasTableTableManager(_$AppDatabase db, $DuasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DuasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DuasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DuasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> arabic = const Value.absent(),
                Value<String> transliteration = const Value.absent(),
                Value<String> translationEn = const Value.absent(),
                Value<String> translationRu = const Value.absent(),
                Value<String> source = const Value.absent(),
              }) => DuasCompanion(
                id: id,
                category: category,
                arabic: arabic,
                transliteration: transliteration,
                translationEn: translationEn,
                translationRu: translationRu,
                source: source,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String category,
                required String arabic,
                required String transliteration,
                required String translationEn,
                required String translationRu,
                required String source,
              }) => DuasCompanion.insert(
                id: id,
                category: category,
                arabic: arabic,
                transliteration: transliteration,
                translationEn: translationEn,
                translationRu: translationRu,
                source: source,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DuasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DuasTable,
      Dua,
      $$DuasTableFilterComposer,
      $$DuasTableOrderingComposer,
      $$DuasTableAnnotationComposer,
      $$DuasTableCreateCompanionBuilder,
      $$DuasTableUpdateCompanionBuilder,
      (Dua, BaseReferences<_$AppDatabase, $DuasTable, Dua>),
      Dua,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SurahsTableTableManager get surahs =>
      $$SurahsTableTableManager(_db, _db.surahs);
  $$AyahsTableTableManager get ayahs =>
      $$AyahsTableTableManager(_db, _db.ayahs);
  $$DuasTableTableManager get duas => $$DuasTableTableManager(_db, _db.duas);
}
