// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, CategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
    'name_ar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('folder'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nameAr,
    iconName,
    sortOrder,
    isSystem,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(
        _nameArMeta,
        nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta),
      );
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ar'],
      ),
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class CategoryRow extends DataClass implements Insertable<CategoryRow> {
  final String id;
  final String name;
  final String? nameAr;
  final String iconName;
  final int sortOrder;
  final bool isSystem;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CategoryRow({
    required this.id,
    required this.name,
    this.nameAr,
    required this.iconName,
    required this.sortOrder,
    required this.isSystem,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || nameAr != null) {
      map['name_ar'] = Variable<String>(nameAr);
    }
    map['icon_name'] = Variable<String>(iconName);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_system'] = Variable<bool>(isSystem);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      nameAr: nameAr == null && nullToAbsent
          ? const Value.absent()
          : Value(nameAr),
      iconName: Value(iconName),
      sortOrder: Value(sortOrder),
      isSystem: Value(isSystem),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameAr: serializer.fromJson<String?>(json['nameAr']),
      iconName: serializer.fromJson<String>(json['iconName']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'nameAr': serializer.toJson<String?>(nameAr),
      'iconName': serializer.toJson<String>(iconName),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isSystem': serializer.toJson<bool>(isSystem),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoryRow copyWith({
    String? id,
    String? name,
    Value<String?> nameAr = const Value.absent(),
    String? iconName,
    int? sortOrder,
    bool? isSystem,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CategoryRow(
    id: id ?? this.id,
    name: name ?? this.name,
    nameAr: nameAr.present ? nameAr.value : this.nameAr,
    iconName: iconName ?? this.iconName,
    sortOrder: sortOrder ?? this.sortOrder,
    isSystem: isSystem ?? this.isSystem,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CategoryRow copyWithCompanion(CategoriesCompanion data) {
    return CategoryRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameAr: $nameAr, ')
          ..write('iconName: $iconName, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isSystem: $isSystem, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    nameAr,
    iconName,
    sortOrder,
    isSystem,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameAr == this.nameAr &&
          other.iconName == this.iconName &&
          other.sortOrder == this.sortOrder &&
          other.isSystem == this.isSystem &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriesCompanion extends UpdateCompanion<CategoryRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> nameAr;
  final Value<String> iconName;
  final Value<int> sortOrder;
  final Value<bool> isSystem;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.iconName = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    this.nameAr = const Value.absent(),
    this.iconName = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isSystem = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CategoryRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? nameAr,
    Expression<String>? iconName,
    Expression<int>? sortOrder,
    Expression<bool>? isSystem,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameAr != null) 'name_ar': nameAr,
      if (iconName != null) 'icon_name': iconName,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isSystem != null) 'is_system': isSystem,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? nameAr,
    Value<String>? iconName,
    Value<int>? sortOrder,
    Value<bool>? isSystem,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameAr: nameAr ?? this.nameAr,
      iconName: iconName ?? this.iconName,
      sortOrder: sortOrder ?? this.sortOrder,
      isSystem: isSystem ?? this.isSystem,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameAr: $nameAr, ')
          ..write('iconName: $iconName, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isSystem: $isSystem, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, WordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
    'word',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arabicMeaningMeta = const VerificationMeta(
    'arabicMeaning',
  );
  @override
  late final GeneratedColumn<String> arabicMeaning = GeneratedColumn<String>(
    'arabic_meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cefrLevelMeta = const VerificationMeta(
    'cefrLevel',
  );
  @override
  late final GeneratedColumn<String> cefrLevel = GeneratedColumn<String>(
    'cefr_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneticMeta = const VerificationMeta(
    'phonetic',
  );
  @override
  late final GeneratedColumn<String> phonetic = GeneratedColumn<String>(
    'phonetic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exampleSentenceMeta = const VerificationMeta(
    'exampleSentence',
  );
  @override
  late final GeneratedColumn<String> exampleSentence = GeneratedColumn<String>(
    'example_sentence',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exampleTranslationMeta =
      const VerificationMeta('exampleTranslation');
  @override
  late final GeneratedColumn<String> exampleTranslation =
      GeneratedColumn<String>(
        'example_translation',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _inReviewSystemMeta = const VerificationMeta(
    'inReviewSystem',
  );
  @override
  late final GeneratedColumn<bool> inReviewSystem = GeneratedColumn<bool>(
    'in_review_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("in_review_system" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _masteryStatusMeta = const VerificationMeta(
    'masteryStatus',
  );
  @override
  late final GeneratedColumn<String> masteryStatus = GeneratedColumn<String>(
    'mastery_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('new'),
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastReviewedAtMeta = const VerificationMeta(
    'lastReviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewedAt =
      GeneratedColumn<DateTime>(
        'last_reviewed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    word,
    arabicMeaning,
    cefrLevel,
    partOfSpeech,
    phonetic,
    notes,
    exampleSentence,
    exampleTranslation,
    isFavorite,
    inReviewSystem,
    masteryStatus,
    reviewCount,
    lastReviewedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('word')) {
      context.handle(
        _wordMeta,
        word.isAcceptableOrUnknown(data['word']!, _wordMeta),
      );
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('arabic_meaning')) {
      context.handle(
        _arabicMeaningMeta,
        arabicMeaning.isAcceptableOrUnknown(
          data['arabic_meaning']!,
          _arabicMeaningMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arabicMeaningMeta);
    }
    if (data.containsKey('cefr_level')) {
      context.handle(
        _cefrLevelMeta,
        cefrLevel.isAcceptableOrUnknown(data['cefr_level']!, _cefrLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_cefrLevelMeta);
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_partOfSpeechMeta);
    }
    if (data.containsKey('phonetic')) {
      context.handle(
        _phoneticMeta,
        phonetic.isAcceptableOrUnknown(data['phonetic']!, _phoneticMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('example_sentence')) {
      context.handle(
        _exampleSentenceMeta,
        exampleSentence.isAcceptableOrUnknown(
          data['example_sentence']!,
          _exampleSentenceMeta,
        ),
      );
    }
    if (data.containsKey('example_translation')) {
      context.handle(
        _exampleTranslationMeta,
        exampleTranslation.isAcceptableOrUnknown(
          data['example_translation']!,
          _exampleTranslationMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('in_review_system')) {
      context.handle(
        _inReviewSystemMeta,
        inReviewSystem.isAcceptableOrUnknown(
          data['in_review_system']!,
          _inReviewSystemMeta,
        ),
      );
    }
    if (data.containsKey('mastery_status')) {
      context.handle(
        _masteryStatusMeta,
        masteryStatus.isAcceptableOrUnknown(
          data['mastery_status']!,
          _masteryStatusMeta,
        ),
      );
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(
        _lastReviewedAtMeta,
        lastReviewedAt.isAcceptableOrUnknown(
          data['last_reviewed_at']!,
          _lastReviewedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {word},
  ];
  @override
  WordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      word: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word'],
      )!,
      arabicMeaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arabic_meaning'],
      )!,
      cefrLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cefr_level'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_of_speech'],
      )!,
      phonetic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phonetic'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      exampleSentence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example_sentence'],
      ),
      exampleTranslation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example_translation'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      inReviewSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}in_review_system'],
      )!,
      masteryStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mastery_status'],
      )!,
      reviewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_count'],
      )!,
      lastReviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(attachedDatabase, alias);
  }
}

class WordRow extends DataClass implements Insertable<WordRow> {
  final String id;
  final String word;
  final String arabicMeaning;
  final String cefrLevel;
  final String partOfSpeech;
  final String? phonetic;
  final String? notes;
  final String? exampleSentence;
  final String? exampleTranslation;
  final bool isFavorite;
  final bool inReviewSystem;
  final String masteryStatus;
  final int reviewCount;
  final DateTime? lastReviewedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WordRow({
    required this.id,
    required this.word,
    required this.arabicMeaning,
    required this.cefrLevel,
    required this.partOfSpeech,
    this.phonetic,
    this.notes,
    this.exampleSentence,
    this.exampleTranslation,
    required this.isFavorite,
    required this.inReviewSystem,
    required this.masteryStatus,
    required this.reviewCount,
    this.lastReviewedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['word'] = Variable<String>(word);
    map['arabic_meaning'] = Variable<String>(arabicMeaning);
    map['cefr_level'] = Variable<String>(cefrLevel);
    map['part_of_speech'] = Variable<String>(partOfSpeech);
    if (!nullToAbsent || phonetic != null) {
      map['phonetic'] = Variable<String>(phonetic);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || exampleSentence != null) {
      map['example_sentence'] = Variable<String>(exampleSentence);
    }
    if (!nullToAbsent || exampleTranslation != null) {
      map['example_translation'] = Variable<String>(exampleTranslation);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['in_review_system'] = Variable<bool>(inReviewSystem);
    map['mastery_status'] = Variable<String>(masteryStatus);
    map['review_count'] = Variable<int>(reviewCount);
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      id: Value(id),
      word: Value(word),
      arabicMeaning: Value(arabicMeaning),
      cefrLevel: Value(cefrLevel),
      partOfSpeech: Value(partOfSpeech),
      phonetic: phonetic == null && nullToAbsent
          ? const Value.absent()
          : Value(phonetic),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      exampleSentence: exampleSentence == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleSentence),
      exampleTranslation: exampleTranslation == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleTranslation),
      isFavorite: Value(isFavorite),
      inReviewSystem: Value(inReviewSystem),
      masteryStatus: Value(masteryStatus),
      reviewCount: Value(reviewCount),
      lastReviewedAt: lastReviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordRow(
      id: serializer.fromJson<String>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      arabicMeaning: serializer.fromJson<String>(json['arabicMeaning']),
      cefrLevel: serializer.fromJson<String>(json['cefrLevel']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      phonetic: serializer.fromJson<String?>(json['phonetic']),
      notes: serializer.fromJson<String?>(json['notes']),
      exampleSentence: serializer.fromJson<String?>(json['exampleSentence']),
      exampleTranslation: serializer.fromJson<String?>(
        json['exampleTranslation'],
      ),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      inReviewSystem: serializer.fromJson<bool>(json['inReviewSystem']),
      masteryStatus: serializer.fromJson<String>(json['masteryStatus']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      lastReviewedAt: serializer.fromJson<DateTime?>(json['lastReviewedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'word': serializer.toJson<String>(word),
      'arabicMeaning': serializer.toJson<String>(arabicMeaning),
      'cefrLevel': serializer.toJson<String>(cefrLevel),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'phonetic': serializer.toJson<String?>(phonetic),
      'notes': serializer.toJson<String?>(notes),
      'exampleSentence': serializer.toJson<String?>(exampleSentence),
      'exampleTranslation': serializer.toJson<String?>(exampleTranslation),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'inReviewSystem': serializer.toJson<bool>(inReviewSystem),
      'masteryStatus': serializer.toJson<String>(masteryStatus),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'lastReviewedAt': serializer.toJson<DateTime?>(lastReviewedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WordRow copyWith({
    String? id,
    String? word,
    String? arabicMeaning,
    String? cefrLevel,
    String? partOfSpeech,
    Value<String?> phonetic = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> exampleSentence = const Value.absent(),
    Value<String?> exampleTranslation = const Value.absent(),
    bool? isFavorite,
    bool? inReviewSystem,
    String? masteryStatus,
    int? reviewCount,
    Value<DateTime?> lastReviewedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WordRow(
    id: id ?? this.id,
    word: word ?? this.word,
    arabicMeaning: arabicMeaning ?? this.arabicMeaning,
    cefrLevel: cefrLevel ?? this.cefrLevel,
    partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    phonetic: phonetic.present ? phonetic.value : this.phonetic,
    notes: notes.present ? notes.value : this.notes,
    exampleSentence: exampleSentence.present
        ? exampleSentence.value
        : this.exampleSentence,
    exampleTranslation: exampleTranslation.present
        ? exampleTranslation.value
        : this.exampleTranslation,
    isFavorite: isFavorite ?? this.isFavorite,
    inReviewSystem: inReviewSystem ?? this.inReviewSystem,
    masteryStatus: masteryStatus ?? this.masteryStatus,
    reviewCount: reviewCount ?? this.reviewCount,
    lastReviewedAt: lastReviewedAt.present
        ? lastReviewedAt.value
        : this.lastReviewedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WordRow copyWithCompanion(WordsCompanion data) {
    return WordRow(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      arabicMeaning: data.arabicMeaning.present
          ? data.arabicMeaning.value
          : this.arabicMeaning,
      cefrLevel: data.cefrLevel.present ? data.cefrLevel.value : this.cefrLevel,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      phonetic: data.phonetic.present ? data.phonetic.value : this.phonetic,
      notes: data.notes.present ? data.notes.value : this.notes,
      exampleSentence: data.exampleSentence.present
          ? data.exampleSentence.value
          : this.exampleSentence,
      exampleTranslation: data.exampleTranslation.present
          ? data.exampleTranslation.value
          : this.exampleTranslation,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      inReviewSystem: data.inReviewSystem.present
          ? data.inReviewSystem.value
          : this.inReviewSystem,
      masteryStatus: data.masteryStatus.present
          ? data.masteryStatus.value
          : this.masteryStatus,
      reviewCount: data.reviewCount.present
          ? data.reviewCount.value
          : this.reviewCount,
      lastReviewedAt: data.lastReviewedAt.present
          ? data.lastReviewedAt.value
          : this.lastReviewedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordRow(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('arabicMeaning: $arabicMeaning, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('phonetic: $phonetic, ')
          ..write('notes: $notes, ')
          ..write('exampleSentence: $exampleSentence, ')
          ..write('exampleTranslation: $exampleTranslation, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('inReviewSystem: $inReviewSystem, ')
          ..write('masteryStatus: $masteryStatus, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    word,
    arabicMeaning,
    cefrLevel,
    partOfSpeech,
    phonetic,
    notes,
    exampleSentence,
    exampleTranslation,
    isFavorite,
    inReviewSystem,
    masteryStatus,
    reviewCount,
    lastReviewedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordRow &&
          other.id == this.id &&
          other.word == this.word &&
          other.arabicMeaning == this.arabicMeaning &&
          other.cefrLevel == this.cefrLevel &&
          other.partOfSpeech == this.partOfSpeech &&
          other.phonetic == this.phonetic &&
          other.notes == this.notes &&
          other.exampleSentence == this.exampleSentence &&
          other.exampleTranslation == this.exampleTranslation &&
          other.isFavorite == this.isFavorite &&
          other.inReviewSystem == this.inReviewSystem &&
          other.masteryStatus == this.masteryStatus &&
          other.reviewCount == this.reviewCount &&
          other.lastReviewedAt == this.lastReviewedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WordsCompanion extends UpdateCompanion<WordRow> {
  final Value<String> id;
  final Value<String> word;
  final Value<String> arabicMeaning;
  final Value<String> cefrLevel;
  final Value<String> partOfSpeech;
  final Value<String?> phonetic;
  final Value<String?> notes;
  final Value<String?> exampleSentence;
  final Value<String?> exampleTranslation;
  final Value<bool> isFavorite;
  final Value<bool> inReviewSystem;
  final Value<String> masteryStatus;
  final Value<int> reviewCount;
  final Value<DateTime?> lastReviewedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WordsCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.arabicMeaning = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.phonetic = const Value.absent(),
    this.notes = const Value.absent(),
    this.exampleSentence = const Value.absent(),
    this.exampleTranslation = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.inReviewSystem = const Value.absent(),
    this.masteryStatus = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordsCompanion.insert({
    required String id,
    required String word,
    required String arabicMeaning,
    required String cefrLevel,
    required String partOfSpeech,
    this.phonetic = const Value.absent(),
    this.notes = const Value.absent(),
    this.exampleSentence = const Value.absent(),
    this.exampleTranslation = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.inReviewSystem = const Value.absent(),
    this.masteryStatus = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       word = Value(word),
       arabicMeaning = Value(arabicMeaning),
       cefrLevel = Value(cefrLevel),
       partOfSpeech = Value(partOfSpeech),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WordRow> custom({
    Expression<String>? id,
    Expression<String>? word,
    Expression<String>? arabicMeaning,
    Expression<String>? cefrLevel,
    Expression<String>? partOfSpeech,
    Expression<String>? phonetic,
    Expression<String>? notes,
    Expression<String>? exampleSentence,
    Expression<String>? exampleTranslation,
    Expression<bool>? isFavorite,
    Expression<bool>? inReviewSystem,
    Expression<String>? masteryStatus,
    Expression<int>? reviewCount,
    Expression<DateTime>? lastReviewedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (arabicMeaning != null) 'arabic_meaning': arabicMeaning,
      if (cefrLevel != null) 'cefr_level': cefrLevel,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (phonetic != null) 'phonetic': phonetic,
      if (notes != null) 'notes': notes,
      if (exampleSentence != null) 'example_sentence': exampleSentence,
      if (exampleTranslation != null) 'example_translation': exampleTranslation,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (inReviewSystem != null) 'in_review_system': inReviewSystem,
      if (masteryStatus != null) 'mastery_status': masteryStatus,
      if (reviewCount != null) 'review_count': reviewCount,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordsCompanion copyWith({
    Value<String>? id,
    Value<String>? word,
    Value<String>? arabicMeaning,
    Value<String>? cefrLevel,
    Value<String>? partOfSpeech,
    Value<String?>? phonetic,
    Value<String?>? notes,
    Value<String?>? exampleSentence,
    Value<String?>? exampleTranslation,
    Value<bool>? isFavorite,
    Value<bool>? inReviewSystem,
    Value<String>? masteryStatus,
    Value<int>? reviewCount,
    Value<DateTime?>? lastReviewedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WordsCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      arabicMeaning: arabicMeaning ?? this.arabicMeaning,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      phonetic: phonetic ?? this.phonetic,
      notes: notes ?? this.notes,
      exampleSentence: exampleSentence ?? this.exampleSentence,
      exampleTranslation: exampleTranslation ?? this.exampleTranslation,
      isFavorite: isFavorite ?? this.isFavorite,
      inReviewSystem: inReviewSystem ?? this.inReviewSystem,
      masteryStatus: masteryStatus ?? this.masteryStatus,
      reviewCount: reviewCount ?? this.reviewCount,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (arabicMeaning.present) {
      map['arabic_meaning'] = Variable<String>(arabicMeaning.value);
    }
    if (cefrLevel.present) {
      map['cefr_level'] = Variable<String>(cefrLevel.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (phonetic.present) {
      map['phonetic'] = Variable<String>(phonetic.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (exampleSentence.present) {
      map['example_sentence'] = Variable<String>(exampleSentence.value);
    }
    if (exampleTranslation.present) {
      map['example_translation'] = Variable<String>(exampleTranslation.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (inReviewSystem.present) {
      map['in_review_system'] = Variable<bool>(inReviewSystem.value);
    }
    if (masteryStatus.present) {
      map['mastery_status'] = Variable<String>(masteryStatus.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('arabicMeaning: $arabicMeaning, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('phonetic: $phonetic, ')
          ..write('notes: $notes, ')
          ..write('exampleSentence: $exampleSentence, ')
          ..write('exampleTranslation: $exampleTranslation, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('inReviewSystem: $inReviewSystem, ')
          ..write('masteryStatus: $masteryStatus, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SentencePatternsTable extends SentencePatterns
    with TableInfo<$SentencePatternsTable, SentencePatternRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SentencePatternsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patternMeta = const VerificationMeta(
    'pattern',
  );
  @override
  late final GeneratedColumn<String> pattern = GeneratedColumn<String>(
    'pattern',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arabicExplanationMeta = const VerificationMeta(
    'arabicExplanation',
  );
  @override
  late final GeneratedColumn<String> arabicExplanation =
      GeneratedColumn<String>(
        'arabic_explanation',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _cefrLevelMeta = const VerificationMeta(
    'cefrLevel',
  );
  @override
  late final GeneratedColumn<String> cefrLevel = GeneratedColumn<String>(
    'cefr_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _grammarNotesMeta = const VerificationMeta(
    'grammarNotes',
  );
  @override
  late final GeneratedColumn<String> grammarNotes = GeneratedColumn<String>(
    'grammar_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _inReviewSystemMeta = const VerificationMeta(
    'inReviewSystem',
  );
  @override
  late final GeneratedColumn<bool> inReviewSystem = GeneratedColumn<bool>(
    'in_review_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("in_review_system" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _masteryStatusMeta = const VerificationMeta(
    'masteryStatus',
  );
  @override
  late final GeneratedColumn<String> masteryStatus = GeneratedColumn<String>(
    'mastery_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('new'),
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastReviewedAtMeta = const VerificationMeta(
    'lastReviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewedAt =
      GeneratedColumn<DateTime>(
        'last_reviewed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pattern,
    arabicExplanation,
    cefrLevel,
    grammarNotes,
    isFavorite,
    inReviewSystem,
    masteryStatus,
    reviewCount,
    lastReviewedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sentence_patterns';
  @override
  VerificationContext validateIntegrity(
    Insertable<SentencePatternRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pattern')) {
      context.handle(
        _patternMeta,
        pattern.isAcceptableOrUnknown(data['pattern']!, _patternMeta),
      );
    } else if (isInserting) {
      context.missing(_patternMeta);
    }
    if (data.containsKey('arabic_explanation')) {
      context.handle(
        _arabicExplanationMeta,
        arabicExplanation.isAcceptableOrUnknown(
          data['arabic_explanation']!,
          _arabicExplanationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arabicExplanationMeta);
    }
    if (data.containsKey('cefr_level')) {
      context.handle(
        _cefrLevelMeta,
        cefrLevel.isAcceptableOrUnknown(data['cefr_level']!, _cefrLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_cefrLevelMeta);
    }
    if (data.containsKey('grammar_notes')) {
      context.handle(
        _grammarNotesMeta,
        grammarNotes.isAcceptableOrUnknown(
          data['grammar_notes']!,
          _grammarNotesMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('in_review_system')) {
      context.handle(
        _inReviewSystemMeta,
        inReviewSystem.isAcceptableOrUnknown(
          data['in_review_system']!,
          _inReviewSystemMeta,
        ),
      );
    }
    if (data.containsKey('mastery_status')) {
      context.handle(
        _masteryStatusMeta,
        masteryStatus.isAcceptableOrUnknown(
          data['mastery_status']!,
          _masteryStatusMeta,
        ),
      );
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(
        _lastReviewedAtMeta,
        lastReviewedAt.isAcceptableOrUnknown(
          data['last_reviewed_at']!,
          _lastReviewedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SentencePatternRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SentencePatternRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pattern: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pattern'],
      )!,
      arabicExplanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arabic_explanation'],
      )!,
      cefrLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cefr_level'],
      )!,
      grammarNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grammar_notes'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      inReviewSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}in_review_system'],
      )!,
      masteryStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mastery_status'],
      )!,
      reviewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_count'],
      )!,
      lastReviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SentencePatternsTable createAlias(String alias) {
    return $SentencePatternsTable(attachedDatabase, alias);
  }
}

class SentencePatternRow extends DataClass
    implements Insertable<SentencePatternRow> {
  final String id;
  final String pattern;
  final String arabicExplanation;
  final String cefrLevel;
  final String? grammarNotes;
  final bool isFavorite;
  final bool inReviewSystem;
  final String masteryStatus;
  final int reviewCount;
  final DateTime? lastReviewedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SentencePatternRow({
    required this.id,
    required this.pattern,
    required this.arabicExplanation,
    required this.cefrLevel,
    this.grammarNotes,
    required this.isFavorite,
    required this.inReviewSystem,
    required this.masteryStatus,
    required this.reviewCount,
    this.lastReviewedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pattern'] = Variable<String>(pattern);
    map['arabic_explanation'] = Variable<String>(arabicExplanation);
    map['cefr_level'] = Variable<String>(cefrLevel);
    if (!nullToAbsent || grammarNotes != null) {
      map['grammar_notes'] = Variable<String>(grammarNotes);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['in_review_system'] = Variable<bool>(inReviewSystem);
    map['mastery_status'] = Variable<String>(masteryStatus);
    map['review_count'] = Variable<int>(reviewCount);
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SentencePatternsCompanion toCompanion(bool nullToAbsent) {
    return SentencePatternsCompanion(
      id: Value(id),
      pattern: Value(pattern),
      arabicExplanation: Value(arabicExplanation),
      cefrLevel: Value(cefrLevel),
      grammarNotes: grammarNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(grammarNotes),
      isFavorite: Value(isFavorite),
      inReviewSystem: Value(inReviewSystem),
      masteryStatus: Value(masteryStatus),
      reviewCount: Value(reviewCount),
      lastReviewedAt: lastReviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SentencePatternRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SentencePatternRow(
      id: serializer.fromJson<String>(json['id']),
      pattern: serializer.fromJson<String>(json['pattern']),
      arabicExplanation: serializer.fromJson<String>(json['arabicExplanation']),
      cefrLevel: serializer.fromJson<String>(json['cefrLevel']),
      grammarNotes: serializer.fromJson<String?>(json['grammarNotes']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      inReviewSystem: serializer.fromJson<bool>(json['inReviewSystem']),
      masteryStatus: serializer.fromJson<String>(json['masteryStatus']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      lastReviewedAt: serializer.fromJson<DateTime?>(json['lastReviewedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pattern': serializer.toJson<String>(pattern),
      'arabicExplanation': serializer.toJson<String>(arabicExplanation),
      'cefrLevel': serializer.toJson<String>(cefrLevel),
      'grammarNotes': serializer.toJson<String?>(grammarNotes),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'inReviewSystem': serializer.toJson<bool>(inReviewSystem),
      'masteryStatus': serializer.toJson<String>(masteryStatus),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'lastReviewedAt': serializer.toJson<DateTime?>(lastReviewedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SentencePatternRow copyWith({
    String? id,
    String? pattern,
    String? arabicExplanation,
    String? cefrLevel,
    Value<String?> grammarNotes = const Value.absent(),
    bool? isFavorite,
    bool? inReviewSystem,
    String? masteryStatus,
    int? reviewCount,
    Value<DateTime?> lastReviewedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SentencePatternRow(
    id: id ?? this.id,
    pattern: pattern ?? this.pattern,
    arabicExplanation: arabicExplanation ?? this.arabicExplanation,
    cefrLevel: cefrLevel ?? this.cefrLevel,
    grammarNotes: grammarNotes.present ? grammarNotes.value : this.grammarNotes,
    isFavorite: isFavorite ?? this.isFavorite,
    inReviewSystem: inReviewSystem ?? this.inReviewSystem,
    masteryStatus: masteryStatus ?? this.masteryStatus,
    reviewCount: reviewCount ?? this.reviewCount,
    lastReviewedAt: lastReviewedAt.present
        ? lastReviewedAt.value
        : this.lastReviewedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SentencePatternRow copyWithCompanion(SentencePatternsCompanion data) {
    return SentencePatternRow(
      id: data.id.present ? data.id.value : this.id,
      pattern: data.pattern.present ? data.pattern.value : this.pattern,
      arabicExplanation: data.arabicExplanation.present
          ? data.arabicExplanation.value
          : this.arabicExplanation,
      cefrLevel: data.cefrLevel.present ? data.cefrLevel.value : this.cefrLevel,
      grammarNotes: data.grammarNotes.present
          ? data.grammarNotes.value
          : this.grammarNotes,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      inReviewSystem: data.inReviewSystem.present
          ? data.inReviewSystem.value
          : this.inReviewSystem,
      masteryStatus: data.masteryStatus.present
          ? data.masteryStatus.value
          : this.masteryStatus,
      reviewCount: data.reviewCount.present
          ? data.reviewCount.value
          : this.reviewCount,
      lastReviewedAt: data.lastReviewedAt.present
          ? data.lastReviewedAt.value
          : this.lastReviewedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SentencePatternRow(')
          ..write('id: $id, ')
          ..write('pattern: $pattern, ')
          ..write('arabicExplanation: $arabicExplanation, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('grammarNotes: $grammarNotes, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('inReviewSystem: $inReviewSystem, ')
          ..write('masteryStatus: $masteryStatus, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pattern,
    arabicExplanation,
    cefrLevel,
    grammarNotes,
    isFavorite,
    inReviewSystem,
    masteryStatus,
    reviewCount,
    lastReviewedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SentencePatternRow &&
          other.id == this.id &&
          other.pattern == this.pattern &&
          other.arabicExplanation == this.arabicExplanation &&
          other.cefrLevel == this.cefrLevel &&
          other.grammarNotes == this.grammarNotes &&
          other.isFavorite == this.isFavorite &&
          other.inReviewSystem == this.inReviewSystem &&
          other.masteryStatus == this.masteryStatus &&
          other.reviewCount == this.reviewCount &&
          other.lastReviewedAt == this.lastReviewedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SentencePatternsCompanion extends UpdateCompanion<SentencePatternRow> {
  final Value<String> id;
  final Value<String> pattern;
  final Value<String> arabicExplanation;
  final Value<String> cefrLevel;
  final Value<String?> grammarNotes;
  final Value<bool> isFavorite;
  final Value<bool> inReviewSystem;
  final Value<String> masteryStatus;
  final Value<int> reviewCount;
  final Value<DateTime?> lastReviewedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SentencePatternsCompanion({
    this.id = const Value.absent(),
    this.pattern = const Value.absent(),
    this.arabicExplanation = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.grammarNotes = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.inReviewSystem = const Value.absent(),
    this.masteryStatus = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SentencePatternsCompanion.insert({
    required String id,
    required String pattern,
    required String arabicExplanation,
    required String cefrLevel,
    this.grammarNotes = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.inReviewSystem = const Value.absent(),
    this.masteryStatus = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pattern = Value(pattern),
       arabicExplanation = Value(arabicExplanation),
       cefrLevel = Value(cefrLevel),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SentencePatternRow> custom({
    Expression<String>? id,
    Expression<String>? pattern,
    Expression<String>? arabicExplanation,
    Expression<String>? cefrLevel,
    Expression<String>? grammarNotes,
    Expression<bool>? isFavorite,
    Expression<bool>? inReviewSystem,
    Expression<String>? masteryStatus,
    Expression<int>? reviewCount,
    Expression<DateTime>? lastReviewedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pattern != null) 'pattern': pattern,
      if (arabicExplanation != null) 'arabic_explanation': arabicExplanation,
      if (cefrLevel != null) 'cefr_level': cefrLevel,
      if (grammarNotes != null) 'grammar_notes': grammarNotes,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (inReviewSystem != null) 'in_review_system': inReviewSystem,
      if (masteryStatus != null) 'mastery_status': masteryStatus,
      if (reviewCount != null) 'review_count': reviewCount,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SentencePatternsCompanion copyWith({
    Value<String>? id,
    Value<String>? pattern,
    Value<String>? arabicExplanation,
    Value<String>? cefrLevel,
    Value<String?>? grammarNotes,
    Value<bool>? isFavorite,
    Value<bool>? inReviewSystem,
    Value<String>? masteryStatus,
    Value<int>? reviewCount,
    Value<DateTime?>? lastReviewedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SentencePatternsCompanion(
      id: id ?? this.id,
      pattern: pattern ?? this.pattern,
      arabicExplanation: arabicExplanation ?? this.arabicExplanation,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      grammarNotes: grammarNotes ?? this.grammarNotes,
      isFavorite: isFavorite ?? this.isFavorite,
      inReviewSystem: inReviewSystem ?? this.inReviewSystem,
      masteryStatus: masteryStatus ?? this.masteryStatus,
      reviewCount: reviewCount ?? this.reviewCount,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pattern.present) {
      map['pattern'] = Variable<String>(pattern.value);
    }
    if (arabicExplanation.present) {
      map['arabic_explanation'] = Variable<String>(arabicExplanation.value);
    }
    if (cefrLevel.present) {
      map['cefr_level'] = Variable<String>(cefrLevel.value);
    }
    if (grammarNotes.present) {
      map['grammar_notes'] = Variable<String>(grammarNotes.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (inReviewSystem.present) {
      map['in_review_system'] = Variable<bool>(inReviewSystem.value);
    }
    if (masteryStatus.present) {
      map['mastery_status'] = Variable<String>(masteryStatus.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SentencePatternsCompanion(')
          ..write('id: $id, ')
          ..write('pattern: $pattern, ')
          ..write('arabicExplanation: $arabicExplanation, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('grammarNotes: $grammarNotes, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('inReviewSystem: $inReviewSystem, ')
          ..write('masteryStatus: $masteryStatus, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SentencesTable extends Sentences
    with TableInfo<$SentencesTable, SentenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SentencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sentenceMeta = const VerificationMeta(
    'sentence',
  );
  @override
  late final GeneratedColumn<String> sentence = GeneratedColumn<String>(
    'sentence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arabicTranslationMeta = const VerificationMeta(
    'arabicTranslation',
  );
  @override
  late final GeneratedColumn<String> arabicTranslation =
      GeneratedColumn<String>(
        'arabic_translation',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _cefrLevelMeta = const VerificationMeta(
    'cefrLevel',
  );
  @override
  late final GeneratedColumn<String> cefrLevel = GeneratedColumn<String>(
    'cefr_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _patternIdMeta = const VerificationMeta(
    'patternId',
  );
  @override
  late final GeneratedColumn<String> patternId = GeneratedColumn<String>(
    'pattern_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sentence_patterns (id)',
    ),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _inReviewSystemMeta = const VerificationMeta(
    'inReviewSystem',
  );
  @override
  late final GeneratedColumn<bool> inReviewSystem = GeneratedColumn<bool>(
    'in_review_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("in_review_system" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _reminderEnabledMeta = const VerificationMeta(
    'reminderEnabled',
  );
  @override
  late final GeneratedColumn<bool> reminderEnabled = GeneratedColumn<bool>(
    'reminder_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _masteryStatusMeta = const VerificationMeta(
    'masteryStatus',
  );
  @override
  late final GeneratedColumn<String> masteryStatus = GeneratedColumn<String>(
    'mastery_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('new'),
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hasPronunciationPracticeMeta =
      const VerificationMeta('hasPronunciationPractice');
  @override
  late final GeneratedColumn<bool> hasPronunciationPractice =
      GeneratedColumn<bool>(
        'has_pronunciation_practice',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_pronunciation_practice" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _lastReviewedAtMeta = const VerificationMeta(
    'lastReviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewedAt =
      GeneratedColumn<DateTime>(
        'last_reviewed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sentence,
    arabicTranslation,
    cefrLevel,
    notes,
    patternId,
    isFavorite,
    inReviewSystem,
    reminderEnabled,
    masteryStatus,
    reviewCount,
    hasPronunciationPractice,
    lastReviewedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sentences';
  @override
  VerificationContext validateIntegrity(
    Insertable<SentenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sentence')) {
      context.handle(
        _sentenceMeta,
        sentence.isAcceptableOrUnknown(data['sentence']!, _sentenceMeta),
      );
    } else if (isInserting) {
      context.missing(_sentenceMeta);
    }
    if (data.containsKey('arabic_translation')) {
      context.handle(
        _arabicTranslationMeta,
        arabicTranslation.isAcceptableOrUnknown(
          data['arabic_translation']!,
          _arabicTranslationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arabicTranslationMeta);
    }
    if (data.containsKey('cefr_level')) {
      context.handle(
        _cefrLevelMeta,
        cefrLevel.isAcceptableOrUnknown(data['cefr_level']!, _cefrLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_cefrLevelMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('pattern_id')) {
      context.handle(
        _patternIdMeta,
        patternId.isAcceptableOrUnknown(data['pattern_id']!, _patternIdMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('in_review_system')) {
      context.handle(
        _inReviewSystemMeta,
        inReviewSystem.isAcceptableOrUnknown(
          data['in_review_system']!,
          _inReviewSystemMeta,
        ),
      );
    }
    if (data.containsKey('reminder_enabled')) {
      context.handle(
        _reminderEnabledMeta,
        reminderEnabled.isAcceptableOrUnknown(
          data['reminder_enabled']!,
          _reminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('mastery_status')) {
      context.handle(
        _masteryStatusMeta,
        masteryStatus.isAcceptableOrUnknown(
          data['mastery_status']!,
          _masteryStatusMeta,
        ),
      );
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    }
    if (data.containsKey('has_pronunciation_practice')) {
      context.handle(
        _hasPronunciationPracticeMeta,
        hasPronunciationPractice.isAcceptableOrUnknown(
          data['has_pronunciation_practice']!,
          _hasPronunciationPracticeMeta,
        ),
      );
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(
        _lastReviewedAtMeta,
        lastReviewedAt.isAcceptableOrUnknown(
          data['last_reviewed_at']!,
          _lastReviewedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SentenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SentenceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sentence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sentence'],
      )!,
      arabicTranslation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arabic_translation'],
      )!,
      cefrLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cefr_level'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      patternId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pattern_id'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      inReviewSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}in_review_system'],
      )!,
      reminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_enabled'],
      )!,
      masteryStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mastery_status'],
      )!,
      reviewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_count'],
      )!,
      hasPronunciationPractice: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_pronunciation_practice'],
      )!,
      lastReviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SentencesTable createAlias(String alias) {
    return $SentencesTable(attachedDatabase, alias);
  }
}

class SentenceRow extends DataClass implements Insertable<SentenceRow> {
  final String id;
  final String sentence;
  final String arabicTranslation;
  final String cefrLevel;
  final String? notes;
  final String? patternId;
  final bool isFavorite;
  final bool inReviewSystem;
  final bool reminderEnabled;
  final String masteryStatus;
  final int reviewCount;
  final bool hasPronunciationPractice;
  final DateTime? lastReviewedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SentenceRow({
    required this.id,
    required this.sentence,
    required this.arabicTranslation,
    required this.cefrLevel,
    this.notes,
    this.patternId,
    required this.isFavorite,
    required this.inReviewSystem,
    required this.reminderEnabled,
    required this.masteryStatus,
    required this.reviewCount,
    required this.hasPronunciationPractice,
    this.lastReviewedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sentence'] = Variable<String>(sentence);
    map['arabic_translation'] = Variable<String>(arabicTranslation);
    map['cefr_level'] = Variable<String>(cefrLevel);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || patternId != null) {
      map['pattern_id'] = Variable<String>(patternId);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['in_review_system'] = Variable<bool>(inReviewSystem);
    map['reminder_enabled'] = Variable<bool>(reminderEnabled);
    map['mastery_status'] = Variable<String>(masteryStatus);
    map['review_count'] = Variable<int>(reviewCount);
    map['has_pronunciation_practice'] = Variable<bool>(
      hasPronunciationPractice,
    );
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SentencesCompanion toCompanion(bool nullToAbsent) {
    return SentencesCompanion(
      id: Value(id),
      sentence: Value(sentence),
      arabicTranslation: Value(arabicTranslation),
      cefrLevel: Value(cefrLevel),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      patternId: patternId == null && nullToAbsent
          ? const Value.absent()
          : Value(patternId),
      isFavorite: Value(isFavorite),
      inReviewSystem: Value(inReviewSystem),
      reminderEnabled: Value(reminderEnabled),
      masteryStatus: Value(masteryStatus),
      reviewCount: Value(reviewCount),
      hasPronunciationPractice: Value(hasPronunciationPractice),
      lastReviewedAt: lastReviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SentenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SentenceRow(
      id: serializer.fromJson<String>(json['id']),
      sentence: serializer.fromJson<String>(json['sentence']),
      arabicTranslation: serializer.fromJson<String>(json['arabicTranslation']),
      cefrLevel: serializer.fromJson<String>(json['cefrLevel']),
      notes: serializer.fromJson<String?>(json['notes']),
      patternId: serializer.fromJson<String?>(json['patternId']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      inReviewSystem: serializer.fromJson<bool>(json['inReviewSystem']),
      reminderEnabled: serializer.fromJson<bool>(json['reminderEnabled']),
      masteryStatus: serializer.fromJson<String>(json['masteryStatus']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      hasPronunciationPractice: serializer.fromJson<bool>(
        json['hasPronunciationPractice'],
      ),
      lastReviewedAt: serializer.fromJson<DateTime?>(json['lastReviewedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sentence': serializer.toJson<String>(sentence),
      'arabicTranslation': serializer.toJson<String>(arabicTranslation),
      'cefrLevel': serializer.toJson<String>(cefrLevel),
      'notes': serializer.toJson<String?>(notes),
      'patternId': serializer.toJson<String?>(patternId),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'inReviewSystem': serializer.toJson<bool>(inReviewSystem),
      'reminderEnabled': serializer.toJson<bool>(reminderEnabled),
      'masteryStatus': serializer.toJson<String>(masteryStatus),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'hasPronunciationPractice': serializer.toJson<bool>(
        hasPronunciationPractice,
      ),
      'lastReviewedAt': serializer.toJson<DateTime?>(lastReviewedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SentenceRow copyWith({
    String? id,
    String? sentence,
    String? arabicTranslation,
    String? cefrLevel,
    Value<String?> notes = const Value.absent(),
    Value<String?> patternId = const Value.absent(),
    bool? isFavorite,
    bool? inReviewSystem,
    bool? reminderEnabled,
    String? masteryStatus,
    int? reviewCount,
    bool? hasPronunciationPractice,
    Value<DateTime?> lastReviewedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SentenceRow(
    id: id ?? this.id,
    sentence: sentence ?? this.sentence,
    arabicTranslation: arabicTranslation ?? this.arabicTranslation,
    cefrLevel: cefrLevel ?? this.cefrLevel,
    notes: notes.present ? notes.value : this.notes,
    patternId: patternId.present ? patternId.value : this.patternId,
    isFavorite: isFavorite ?? this.isFavorite,
    inReviewSystem: inReviewSystem ?? this.inReviewSystem,
    reminderEnabled: reminderEnabled ?? this.reminderEnabled,
    masteryStatus: masteryStatus ?? this.masteryStatus,
    reviewCount: reviewCount ?? this.reviewCount,
    hasPronunciationPractice:
        hasPronunciationPractice ?? this.hasPronunciationPractice,
    lastReviewedAt: lastReviewedAt.present
        ? lastReviewedAt.value
        : this.lastReviewedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SentenceRow copyWithCompanion(SentencesCompanion data) {
    return SentenceRow(
      id: data.id.present ? data.id.value : this.id,
      sentence: data.sentence.present ? data.sentence.value : this.sentence,
      arabicTranslation: data.arabicTranslation.present
          ? data.arabicTranslation.value
          : this.arabicTranslation,
      cefrLevel: data.cefrLevel.present ? data.cefrLevel.value : this.cefrLevel,
      notes: data.notes.present ? data.notes.value : this.notes,
      patternId: data.patternId.present ? data.patternId.value : this.patternId,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      inReviewSystem: data.inReviewSystem.present
          ? data.inReviewSystem.value
          : this.inReviewSystem,
      reminderEnabled: data.reminderEnabled.present
          ? data.reminderEnabled.value
          : this.reminderEnabled,
      masteryStatus: data.masteryStatus.present
          ? data.masteryStatus.value
          : this.masteryStatus,
      reviewCount: data.reviewCount.present
          ? data.reviewCount.value
          : this.reviewCount,
      hasPronunciationPractice: data.hasPronunciationPractice.present
          ? data.hasPronunciationPractice.value
          : this.hasPronunciationPractice,
      lastReviewedAt: data.lastReviewedAt.present
          ? data.lastReviewedAt.value
          : this.lastReviewedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SentenceRow(')
          ..write('id: $id, ')
          ..write('sentence: $sentence, ')
          ..write('arabicTranslation: $arabicTranslation, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('notes: $notes, ')
          ..write('patternId: $patternId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('inReviewSystem: $inReviewSystem, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('masteryStatus: $masteryStatus, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('hasPronunciationPractice: $hasPronunciationPractice, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sentence,
    arabicTranslation,
    cefrLevel,
    notes,
    patternId,
    isFavorite,
    inReviewSystem,
    reminderEnabled,
    masteryStatus,
    reviewCount,
    hasPronunciationPractice,
    lastReviewedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SentenceRow &&
          other.id == this.id &&
          other.sentence == this.sentence &&
          other.arabicTranslation == this.arabicTranslation &&
          other.cefrLevel == this.cefrLevel &&
          other.notes == this.notes &&
          other.patternId == this.patternId &&
          other.isFavorite == this.isFavorite &&
          other.inReviewSystem == this.inReviewSystem &&
          other.reminderEnabled == this.reminderEnabled &&
          other.masteryStatus == this.masteryStatus &&
          other.reviewCount == this.reviewCount &&
          other.hasPronunciationPractice == this.hasPronunciationPractice &&
          other.lastReviewedAt == this.lastReviewedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SentencesCompanion extends UpdateCompanion<SentenceRow> {
  final Value<String> id;
  final Value<String> sentence;
  final Value<String> arabicTranslation;
  final Value<String> cefrLevel;
  final Value<String?> notes;
  final Value<String?> patternId;
  final Value<bool> isFavorite;
  final Value<bool> inReviewSystem;
  final Value<bool> reminderEnabled;
  final Value<String> masteryStatus;
  final Value<int> reviewCount;
  final Value<bool> hasPronunciationPractice;
  final Value<DateTime?> lastReviewedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SentencesCompanion({
    this.id = const Value.absent(),
    this.sentence = const Value.absent(),
    this.arabicTranslation = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.notes = const Value.absent(),
    this.patternId = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.inReviewSystem = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.masteryStatus = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.hasPronunciationPractice = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SentencesCompanion.insert({
    required String id,
    required String sentence,
    required String arabicTranslation,
    required String cefrLevel,
    this.notes = const Value.absent(),
    this.patternId = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.inReviewSystem = const Value.absent(),
    this.reminderEnabled = const Value.absent(),
    this.masteryStatus = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.hasPronunciationPractice = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sentence = Value(sentence),
       arabicTranslation = Value(arabicTranslation),
       cefrLevel = Value(cefrLevel),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SentenceRow> custom({
    Expression<String>? id,
    Expression<String>? sentence,
    Expression<String>? arabicTranslation,
    Expression<String>? cefrLevel,
    Expression<String>? notes,
    Expression<String>? patternId,
    Expression<bool>? isFavorite,
    Expression<bool>? inReviewSystem,
    Expression<bool>? reminderEnabled,
    Expression<String>? masteryStatus,
    Expression<int>? reviewCount,
    Expression<bool>? hasPronunciationPractice,
    Expression<DateTime>? lastReviewedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sentence != null) 'sentence': sentence,
      if (arabicTranslation != null) 'arabic_translation': arabicTranslation,
      if (cefrLevel != null) 'cefr_level': cefrLevel,
      if (notes != null) 'notes': notes,
      if (patternId != null) 'pattern_id': patternId,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (inReviewSystem != null) 'in_review_system': inReviewSystem,
      if (reminderEnabled != null) 'reminder_enabled': reminderEnabled,
      if (masteryStatus != null) 'mastery_status': masteryStatus,
      if (reviewCount != null) 'review_count': reviewCount,
      if (hasPronunciationPractice != null)
        'has_pronunciation_practice': hasPronunciationPractice,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SentencesCompanion copyWith({
    Value<String>? id,
    Value<String>? sentence,
    Value<String>? arabicTranslation,
    Value<String>? cefrLevel,
    Value<String?>? notes,
    Value<String?>? patternId,
    Value<bool>? isFavorite,
    Value<bool>? inReviewSystem,
    Value<bool>? reminderEnabled,
    Value<String>? masteryStatus,
    Value<int>? reviewCount,
    Value<bool>? hasPronunciationPractice,
    Value<DateTime?>? lastReviewedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SentencesCompanion(
      id: id ?? this.id,
      sentence: sentence ?? this.sentence,
      arabicTranslation: arabicTranslation ?? this.arabicTranslation,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      notes: notes ?? this.notes,
      patternId: patternId ?? this.patternId,
      isFavorite: isFavorite ?? this.isFavorite,
      inReviewSystem: inReviewSystem ?? this.inReviewSystem,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      masteryStatus: masteryStatus ?? this.masteryStatus,
      reviewCount: reviewCount ?? this.reviewCount,
      hasPronunciationPractice:
          hasPronunciationPractice ?? this.hasPronunciationPractice,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sentence.present) {
      map['sentence'] = Variable<String>(sentence.value);
    }
    if (arabicTranslation.present) {
      map['arabic_translation'] = Variable<String>(arabicTranslation.value);
    }
    if (cefrLevel.present) {
      map['cefr_level'] = Variable<String>(cefrLevel.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (patternId.present) {
      map['pattern_id'] = Variable<String>(patternId.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (inReviewSystem.present) {
      map['in_review_system'] = Variable<bool>(inReviewSystem.value);
    }
    if (reminderEnabled.present) {
      map['reminder_enabled'] = Variable<bool>(reminderEnabled.value);
    }
    if (masteryStatus.present) {
      map['mastery_status'] = Variable<String>(masteryStatus.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (hasPronunciationPractice.present) {
      map['has_pronunciation_practice'] = Variable<bool>(
        hasPronunciationPractice.value,
      );
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SentencesCompanion(')
          ..write('id: $id, ')
          ..write('sentence: $sentence, ')
          ..write('arabicTranslation: $arabicTranslation, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('notes: $notes, ')
          ..write('patternId: $patternId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('inReviewSystem: $inReviewSystem, ')
          ..write('reminderEnabled: $reminderEnabled, ')
          ..write('masteryStatus: $masteryStatus, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('hasPronunciationPractice: $hasPronunciationPractice, ')
          ..write('lastReviewedAt: $lastReviewedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WordCategoriesTable extends WordCategories
    with TableInfo<$WordCategoriesTable, WordCategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WordCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<String> wordId = GeneratedColumn<String>(
    'word_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES words (id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [wordId, categoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'word_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<WordCategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word_id')) {
      context.handle(
        _wordIdMeta,
        wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {wordId, categoryId};
  @override
  WordCategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WordCategoryRow(
      wordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
    );
  }

  @override
  $WordCategoriesTable createAlias(String alias) {
    return $WordCategoriesTable(attachedDatabase, alias);
  }
}

class WordCategoryRow extends DataClass implements Insertable<WordCategoryRow> {
  final String wordId;
  final String categoryId;
  const WordCategoryRow({required this.wordId, required this.categoryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word_id'] = Variable<String>(wordId);
    map['category_id'] = Variable<String>(categoryId);
    return map;
  }

  WordCategoriesCompanion toCompanion(bool nullToAbsent) {
    return WordCategoriesCompanion(
      wordId: Value(wordId),
      categoryId: Value(categoryId),
    );
  }

  factory WordCategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WordCategoryRow(
      wordId: serializer.fromJson<String>(json['wordId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'wordId': serializer.toJson<String>(wordId),
      'categoryId': serializer.toJson<String>(categoryId),
    };
  }

  WordCategoryRow copyWith({String? wordId, String? categoryId}) =>
      WordCategoryRow(
        wordId: wordId ?? this.wordId,
        categoryId: categoryId ?? this.categoryId,
      );
  WordCategoryRow copyWithCompanion(WordCategoriesCompanion data) {
    return WordCategoryRow(
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WordCategoryRow(')
          ..write('wordId: $wordId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(wordId, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WordCategoryRow &&
          other.wordId == this.wordId &&
          other.categoryId == this.categoryId);
}

class WordCategoriesCompanion extends UpdateCompanion<WordCategoryRow> {
  final Value<String> wordId;
  final Value<String> categoryId;
  final Value<int> rowid;
  const WordCategoriesCompanion({
    this.wordId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WordCategoriesCompanion.insert({
    required String wordId,
    required String categoryId,
    this.rowid = const Value.absent(),
  }) : wordId = Value(wordId),
       categoryId = Value(categoryId);
  static Insertable<WordCategoryRow> custom({
    Expression<String>? wordId,
    Expression<String>? categoryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (wordId != null) 'word_id': wordId,
      if (categoryId != null) 'category_id': categoryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WordCategoriesCompanion copyWith({
    Value<String>? wordId,
    Value<String>? categoryId,
    Value<int>? rowid,
  }) {
    return WordCategoriesCompanion(
      wordId: wordId ?? this.wordId,
      categoryId: categoryId ?? this.categoryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (wordId.present) {
      map['word_id'] = Variable<String>(wordId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordCategoriesCompanion(')
          ..write('wordId: $wordId, ')
          ..write('categoryId: $categoryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SentenceCategoriesTable extends SentenceCategories
    with TableInfo<$SentenceCategoriesTable, SentenceCategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SentenceCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sentenceIdMeta = const VerificationMeta(
    'sentenceId',
  );
  @override
  late final GeneratedColumn<String> sentenceId = GeneratedColumn<String>(
    'sentence_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sentences (id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [sentenceId, categoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sentence_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<SentenceCategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sentence_id')) {
      context.handle(
        _sentenceIdMeta,
        sentenceId.isAcceptableOrUnknown(data['sentence_id']!, _sentenceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sentenceIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sentenceId, categoryId};
  @override
  SentenceCategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SentenceCategoryRow(
      sentenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sentence_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
    );
  }

  @override
  $SentenceCategoriesTable createAlias(String alias) {
    return $SentenceCategoriesTable(attachedDatabase, alias);
  }
}

class SentenceCategoryRow extends DataClass
    implements Insertable<SentenceCategoryRow> {
  final String sentenceId;
  final String categoryId;
  const SentenceCategoryRow({
    required this.sentenceId,
    required this.categoryId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sentence_id'] = Variable<String>(sentenceId);
    map['category_id'] = Variable<String>(categoryId);
    return map;
  }

  SentenceCategoriesCompanion toCompanion(bool nullToAbsent) {
    return SentenceCategoriesCompanion(
      sentenceId: Value(sentenceId),
      categoryId: Value(categoryId),
    );
  }

  factory SentenceCategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SentenceCategoryRow(
      sentenceId: serializer.fromJson<String>(json['sentenceId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sentenceId': serializer.toJson<String>(sentenceId),
      'categoryId': serializer.toJson<String>(categoryId),
    };
  }

  SentenceCategoryRow copyWith({String? sentenceId, String? categoryId}) =>
      SentenceCategoryRow(
        sentenceId: sentenceId ?? this.sentenceId,
        categoryId: categoryId ?? this.categoryId,
      );
  SentenceCategoryRow copyWithCompanion(SentenceCategoriesCompanion data) {
    return SentenceCategoryRow(
      sentenceId: data.sentenceId.present
          ? data.sentenceId.value
          : this.sentenceId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SentenceCategoryRow(')
          ..write('sentenceId: $sentenceId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sentenceId, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SentenceCategoryRow &&
          other.sentenceId == this.sentenceId &&
          other.categoryId == this.categoryId);
}

class SentenceCategoriesCompanion extends UpdateCompanion<SentenceCategoryRow> {
  final Value<String> sentenceId;
  final Value<String> categoryId;
  final Value<int> rowid;
  const SentenceCategoriesCompanion({
    this.sentenceId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SentenceCategoriesCompanion.insert({
    required String sentenceId,
    required String categoryId,
    this.rowid = const Value.absent(),
  }) : sentenceId = Value(sentenceId),
       categoryId = Value(categoryId);
  static Insertable<SentenceCategoryRow> custom({
    Expression<String>? sentenceId,
    Expression<String>? categoryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sentenceId != null) 'sentence_id': sentenceId,
      if (categoryId != null) 'category_id': categoryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SentenceCategoriesCompanion copyWith({
    Value<String>? sentenceId,
    Value<String>? categoryId,
    Value<int>? rowid,
  }) {
    return SentenceCategoriesCompanion(
      sentenceId: sentenceId ?? this.sentenceId,
      categoryId: categoryId ?? this.categoryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sentenceId.present) {
      map['sentence_id'] = Variable<String>(sentenceId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SentenceCategoriesCompanion(')
          ..write('sentenceId: $sentenceId, ')
          ..write('categoryId: $categoryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PatternCategoriesTable extends PatternCategories
    with TableInfo<$PatternCategoriesTable, PatternCategoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatternCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _patternIdMeta = const VerificationMeta(
    'patternId',
  );
  @override
  late final GeneratedColumn<String> patternId = GeneratedColumn<String>(
    'pattern_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sentence_patterns (id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [patternId, categoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pattern_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<PatternCategoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pattern_id')) {
      context.handle(
        _patternIdMeta,
        patternId.isAcceptableOrUnknown(data['pattern_id']!, _patternIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patternIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {patternId, categoryId};
  @override
  PatternCategoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PatternCategoryRow(
      patternId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pattern_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
    );
  }

  @override
  $PatternCategoriesTable createAlias(String alias) {
    return $PatternCategoriesTable(attachedDatabase, alias);
  }
}

class PatternCategoryRow extends DataClass
    implements Insertable<PatternCategoryRow> {
  final String patternId;
  final String categoryId;
  const PatternCategoryRow({required this.patternId, required this.categoryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pattern_id'] = Variable<String>(patternId);
    map['category_id'] = Variable<String>(categoryId);
    return map;
  }

  PatternCategoriesCompanion toCompanion(bool nullToAbsent) {
    return PatternCategoriesCompanion(
      patternId: Value(patternId),
      categoryId: Value(categoryId),
    );
  }

  factory PatternCategoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PatternCategoryRow(
      patternId: serializer.fromJson<String>(json['patternId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'patternId': serializer.toJson<String>(patternId),
      'categoryId': serializer.toJson<String>(categoryId),
    };
  }

  PatternCategoryRow copyWith({String? patternId, String? categoryId}) =>
      PatternCategoryRow(
        patternId: patternId ?? this.patternId,
        categoryId: categoryId ?? this.categoryId,
      );
  PatternCategoryRow copyWithCompanion(PatternCategoriesCompanion data) {
    return PatternCategoryRow(
      patternId: data.patternId.present ? data.patternId.value : this.patternId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PatternCategoryRow(')
          ..write('patternId: $patternId, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(patternId, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PatternCategoryRow &&
          other.patternId == this.patternId &&
          other.categoryId == this.categoryId);
}

class PatternCategoriesCompanion extends UpdateCompanion<PatternCategoryRow> {
  final Value<String> patternId;
  final Value<String> categoryId;
  final Value<int> rowid;
  const PatternCategoriesCompanion({
    this.patternId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PatternCategoriesCompanion.insert({
    required String patternId,
    required String categoryId,
    this.rowid = const Value.absent(),
  }) : patternId = Value(patternId),
       categoryId = Value(categoryId);
  static Insertable<PatternCategoryRow> custom({
    Expression<String>? patternId,
    Expression<String>? categoryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (patternId != null) 'pattern_id': patternId,
      if (categoryId != null) 'category_id': categoryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PatternCategoriesCompanion copyWith({
    Value<String>? patternId,
    Value<String>? categoryId,
    Value<int>? rowid,
  }) {
    return PatternCategoriesCompanion(
      patternId: patternId ?? this.patternId,
      categoryId: categoryId ?? this.categoryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (patternId.present) {
      map['pattern_id'] = Variable<String>(patternId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatternCategoriesCompanion(')
          ..write('patternId: $patternId, ')
          ..write('categoryId: $categoryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SentenceWordsTable extends SentenceWords
    with TableInfo<$SentenceWordsTable, SentenceWordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SentenceWordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sentenceIdMeta = const VerificationMeta(
    'sentenceId',
  );
  @override
  late final GeneratedColumn<String> sentenceId = GeneratedColumn<String>(
    'sentence_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sentences (id)',
    ),
  );
  static const VerificationMeta _wordIdMeta = const VerificationMeta('wordId');
  @override
  late final GeneratedColumn<String> wordId = GeneratedColumn<String>(
    'word_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES words (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [sentenceId, wordId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sentence_words';
  @override
  VerificationContext validateIntegrity(
    Insertable<SentenceWordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sentence_id')) {
      context.handle(
        _sentenceIdMeta,
        sentenceId.isAcceptableOrUnknown(data['sentence_id']!, _sentenceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sentenceIdMeta);
    }
    if (data.containsKey('word_id')) {
      context.handle(
        _wordIdMeta,
        wordId.isAcceptableOrUnknown(data['word_id']!, _wordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wordIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sentenceId, wordId};
  @override
  SentenceWordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SentenceWordRow(
      sentenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sentence_id'],
      )!,
      wordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}word_id'],
      )!,
    );
  }

  @override
  $SentenceWordsTable createAlias(String alias) {
    return $SentenceWordsTable(attachedDatabase, alias);
  }
}

class SentenceWordRow extends DataClass implements Insertable<SentenceWordRow> {
  final String sentenceId;
  final String wordId;
  const SentenceWordRow({required this.sentenceId, required this.wordId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sentence_id'] = Variable<String>(sentenceId);
    map['word_id'] = Variable<String>(wordId);
    return map;
  }

  SentenceWordsCompanion toCompanion(bool nullToAbsent) {
    return SentenceWordsCompanion(
      sentenceId: Value(sentenceId),
      wordId: Value(wordId),
    );
  }

  factory SentenceWordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SentenceWordRow(
      sentenceId: serializer.fromJson<String>(json['sentenceId']),
      wordId: serializer.fromJson<String>(json['wordId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sentenceId': serializer.toJson<String>(sentenceId),
      'wordId': serializer.toJson<String>(wordId),
    };
  }

  SentenceWordRow copyWith({String? sentenceId, String? wordId}) =>
      SentenceWordRow(
        sentenceId: sentenceId ?? this.sentenceId,
        wordId: wordId ?? this.wordId,
      );
  SentenceWordRow copyWithCompanion(SentenceWordsCompanion data) {
    return SentenceWordRow(
      sentenceId: data.sentenceId.present
          ? data.sentenceId.value
          : this.sentenceId,
      wordId: data.wordId.present ? data.wordId.value : this.wordId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SentenceWordRow(')
          ..write('sentenceId: $sentenceId, ')
          ..write('wordId: $wordId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sentenceId, wordId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SentenceWordRow &&
          other.sentenceId == this.sentenceId &&
          other.wordId == this.wordId);
}

class SentenceWordsCompanion extends UpdateCompanion<SentenceWordRow> {
  final Value<String> sentenceId;
  final Value<String> wordId;
  final Value<int> rowid;
  const SentenceWordsCompanion({
    this.sentenceId = const Value.absent(),
    this.wordId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SentenceWordsCompanion.insert({
    required String sentenceId,
    required String wordId,
    this.rowid = const Value.absent(),
  }) : sentenceId = Value(sentenceId),
       wordId = Value(wordId);
  static Insertable<SentenceWordRow> custom({
    Expression<String>? sentenceId,
    Expression<String>? wordId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sentenceId != null) 'sentence_id': sentenceId,
      if (wordId != null) 'word_id': wordId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SentenceWordsCompanion copyWith({
    Value<String>? sentenceId,
    Value<String>? wordId,
    Value<int>? rowid,
  }) {
    return SentenceWordsCompanion(
      sentenceId: sentenceId ?? this.sentenceId,
      wordId: wordId ?? this.wordId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sentenceId.present) {
      map['sentence_id'] = Variable<String>(sentenceId.value);
    }
    if (wordId.present) {
      map['word_id'] = Variable<String>(wordId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SentenceWordsCompanion(')
          ..write('sentenceId: $sentenceId, ')
          ..write('wordId: $wordId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewItemsTable extends ReviewItems
    with TableInfo<$ReviewItemsTable, ReviewItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _easeFactorMeta = const VerificationMeta(
    'easeFactor',
  );
  @override
  late final GeneratedColumn<double> easeFactor = GeneratedColumn<double>(
    'ease_factor',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.5),
  );
  static const VerificationMeta _intervalDaysMeta = const VerificationMeta(
    'intervalDays',
  );
  @override
  late final GeneratedColumn<int> intervalDays = GeneratedColumn<int>(
    'interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _repetitionsMeta = const VerificationMeta(
    'repetitions',
  );
  @override
  late final GeneratedColumn<int> repetitions = GeneratedColumn<int>(
    'repetitions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _nextReviewAtMeta = const VerificationMeta(
    'nextReviewAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextReviewAt = GeneratedColumn<DateTime>(
    'next_review_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemType,
    itemId,
    easeFactor,
    intervalDays,
    repetitions,
    nextReviewAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('ease_factor')) {
      context.handle(
        _easeFactorMeta,
        easeFactor.isAcceptableOrUnknown(data['ease_factor']!, _easeFactorMeta),
      );
    }
    if (data.containsKey('interval_days')) {
      context.handle(
        _intervalDaysMeta,
        intervalDays.isAcceptableOrUnknown(
          data['interval_days']!,
          _intervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('repetitions')) {
      context.handle(
        _repetitionsMeta,
        repetitions.isAcceptableOrUnknown(
          data['repetitions']!,
          _repetitionsMeta,
        ),
      );
    }
    if (data.containsKey('next_review_at')) {
      context.handle(
        _nextReviewAtMeta,
        nextReviewAt.isAcceptableOrUnknown(
          data['next_review_at']!,
          _nextReviewAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextReviewAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {itemType, itemId},
  ];
  @override
  ReviewItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      itemType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_type'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      easeFactor: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ease_factor'],
      )!,
      intervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_days'],
      )!,
      repetitions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repetitions'],
      )!,
      nextReviewAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_review_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReviewItemsTable createAlias(String alias) {
    return $ReviewItemsTable(attachedDatabase, alias);
  }
}

class ReviewItemRow extends DataClass implements Insertable<ReviewItemRow> {
  final String id;
  final String itemType;
  final String itemId;
  final double easeFactor;
  final int intervalDays;
  final int repetitions;
  final DateTime nextReviewAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ReviewItemRow({
    required this.id,
    required this.itemType,
    required this.itemId,
    required this.easeFactor,
    required this.intervalDays,
    required this.repetitions,
    required this.nextReviewAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['item_type'] = Variable<String>(itemType);
    map['item_id'] = Variable<String>(itemId);
    map['ease_factor'] = Variable<double>(easeFactor);
    map['interval_days'] = Variable<int>(intervalDays);
    map['repetitions'] = Variable<int>(repetitions);
    map['next_review_at'] = Variable<DateTime>(nextReviewAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReviewItemsCompanion toCompanion(bool nullToAbsent) {
    return ReviewItemsCompanion(
      id: Value(id),
      itemType: Value(itemType),
      itemId: Value(itemId),
      easeFactor: Value(easeFactor),
      intervalDays: Value(intervalDays),
      repetitions: Value(repetitions),
      nextReviewAt: Value(nextReviewAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ReviewItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewItemRow(
      id: serializer.fromJson<String>(json['id']),
      itemType: serializer.fromJson<String>(json['itemType']),
      itemId: serializer.fromJson<String>(json['itemId']),
      easeFactor: serializer.fromJson<double>(json['easeFactor']),
      intervalDays: serializer.fromJson<int>(json['intervalDays']),
      repetitions: serializer.fromJson<int>(json['repetitions']),
      nextReviewAt: serializer.fromJson<DateTime>(json['nextReviewAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemType': serializer.toJson<String>(itemType),
      'itemId': serializer.toJson<String>(itemId),
      'easeFactor': serializer.toJson<double>(easeFactor),
      'intervalDays': serializer.toJson<int>(intervalDays),
      'repetitions': serializer.toJson<int>(repetitions),
      'nextReviewAt': serializer.toJson<DateTime>(nextReviewAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ReviewItemRow copyWith({
    String? id,
    String? itemType,
    String? itemId,
    double? easeFactor,
    int? intervalDays,
    int? repetitions,
    DateTime? nextReviewAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ReviewItemRow(
    id: id ?? this.id,
    itemType: itemType ?? this.itemType,
    itemId: itemId ?? this.itemId,
    easeFactor: easeFactor ?? this.easeFactor,
    intervalDays: intervalDays ?? this.intervalDays,
    repetitions: repetitions ?? this.repetitions,
    nextReviewAt: nextReviewAt ?? this.nextReviewAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ReviewItemRow copyWithCompanion(ReviewItemsCompanion data) {
    return ReviewItemRow(
      id: data.id.present ? data.id.value : this.id,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      easeFactor: data.easeFactor.present
          ? data.easeFactor.value
          : this.easeFactor,
      intervalDays: data.intervalDays.present
          ? data.intervalDays.value
          : this.intervalDays,
      repetitions: data.repetitions.present
          ? data.repetitions.value
          : this.repetitions,
      nextReviewAt: data.nextReviewAt.present
          ? data.nextReviewAt.value
          : this.nextReviewAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewItemRow(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('itemId: $itemId, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('repetitions: $repetitions, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itemType,
    itemId,
    easeFactor,
    intervalDays,
    repetitions,
    nextReviewAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewItemRow &&
          other.id == this.id &&
          other.itemType == this.itemType &&
          other.itemId == this.itemId &&
          other.easeFactor == this.easeFactor &&
          other.intervalDays == this.intervalDays &&
          other.repetitions == this.repetitions &&
          other.nextReviewAt == this.nextReviewAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ReviewItemsCompanion extends UpdateCompanion<ReviewItemRow> {
  final Value<String> id;
  final Value<String> itemType;
  final Value<String> itemId;
  final Value<double> easeFactor;
  final Value<int> intervalDays;
  final Value<int> repetitions;
  final Value<DateTime> nextReviewAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ReviewItemsCompanion({
    this.id = const Value.absent(),
    this.itemType = const Value.absent(),
    this.itemId = const Value.absent(),
    this.easeFactor = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.repetitions = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewItemsCompanion.insert({
    required String id,
    required String itemType,
    required String itemId,
    this.easeFactor = const Value.absent(),
    this.intervalDays = const Value.absent(),
    this.repetitions = const Value.absent(),
    required DateTime nextReviewAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       itemType = Value(itemType),
       itemId = Value(itemId),
       nextReviewAt = Value(nextReviewAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ReviewItemRow> custom({
    Expression<String>? id,
    Expression<String>? itemType,
    Expression<String>? itemId,
    Expression<double>? easeFactor,
    Expression<int>? intervalDays,
    Expression<int>? repetitions,
    Expression<DateTime>? nextReviewAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemType != null) 'item_type': itemType,
      if (itemId != null) 'item_id': itemId,
      if (easeFactor != null) 'ease_factor': easeFactor,
      if (intervalDays != null) 'interval_days': intervalDays,
      if (repetitions != null) 'repetitions': repetitions,
      if (nextReviewAt != null) 'next_review_at': nextReviewAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? itemType,
    Value<String>? itemId,
    Value<double>? easeFactor,
    Value<int>? intervalDays,
    Value<int>? repetitions,
    Value<DateTime>? nextReviewAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ReviewItemsCompanion(
      id: id ?? this.id,
      itemType: itemType ?? this.itemType,
      itemId: itemId ?? this.itemId,
      easeFactor: easeFactor ?? this.easeFactor,
      intervalDays: intervalDays ?? this.intervalDays,
      repetitions: repetitions ?? this.repetitions,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (easeFactor.present) {
      map['ease_factor'] = Variable<double>(easeFactor.value);
    }
    if (intervalDays.present) {
      map['interval_days'] = Variable<int>(intervalDays.value);
    }
    if (repetitions.present) {
      map['repetitions'] = Variable<int>(repetitions.value);
    }
    if (nextReviewAt.present) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewItemsCompanion(')
          ..write('id: $id, ')
          ..write('itemType: $itemType, ')
          ..write('itemId: $itemId, ')
          ..write('easeFactor: $easeFactor, ')
          ..write('intervalDays: $intervalDays, ')
          ..write('repetitions: $repetitions, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewHistoryTable extends ReviewHistory
    with TableInfo<$ReviewHistoryTable, ReviewHistoryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewItemIdMeta = const VerificationMeta(
    'reviewItemId',
  );
  @override
  late final GeneratedColumn<String> reviewItemId = GeneratedColumn<String>(
    'review_item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES review_items (id)',
    ),
  );
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousIntervalMeta = const VerificationMeta(
    'previousInterval',
  );
  @override
  late final GeneratedColumn<int> previousInterval = GeneratedColumn<int>(
    'previous_interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _newIntervalMeta = const VerificationMeta(
    'newInterval',
  );
  @override
  late final GeneratedColumn<int> newInterval = GeneratedColumn<int>(
    'new_interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewedAtMeta = const VerificationMeta(
    'reviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> reviewedAt = GeneratedColumn<DateTime>(
    'reviewed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reviewItemId,
    itemType,
    itemId,
    rating,
    previousInterval,
    newInterval,
    reviewedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewHistoryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('review_item_id')) {
      context.handle(
        _reviewItemIdMeta,
        reviewItemId.isAcceptableOrUnknown(
          data['review_item_id']!,
          _reviewItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reviewItemIdMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('previous_interval')) {
      context.handle(
        _previousIntervalMeta,
        previousInterval.isAcceptableOrUnknown(
          data['previous_interval']!,
          _previousIntervalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_previousIntervalMeta);
    }
    if (data.containsKey('new_interval')) {
      context.handle(
        _newIntervalMeta,
        newInterval.isAcceptableOrUnknown(
          data['new_interval']!,
          _newIntervalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_newIntervalMeta);
    }
    if (data.containsKey('reviewed_at')) {
      context.handle(
        _reviewedAtMeta,
        reviewedAt.isAcceptableOrUnknown(data['reviewed_at']!, _reviewedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewHistoryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewHistoryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      reviewItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}review_item_id'],
      )!,
      itemType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_type'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      previousInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}previous_interval'],
      )!,
      newInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}new_interval'],
      )!,
      reviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}reviewed_at'],
      )!,
    );
  }

  @override
  $ReviewHistoryTable createAlias(String alias) {
    return $ReviewHistoryTable(attachedDatabase, alias);
  }
}

class ReviewHistoryRow extends DataClass
    implements Insertable<ReviewHistoryRow> {
  final String id;
  final String reviewItemId;
  final String itemType;
  final String itemId;
  final int rating;
  final int previousInterval;
  final int newInterval;
  final DateTime reviewedAt;
  const ReviewHistoryRow({
    required this.id,
    required this.reviewItemId,
    required this.itemType,
    required this.itemId,
    required this.rating,
    required this.previousInterval,
    required this.newInterval,
    required this.reviewedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['review_item_id'] = Variable<String>(reviewItemId);
    map['item_type'] = Variable<String>(itemType);
    map['item_id'] = Variable<String>(itemId);
    map['rating'] = Variable<int>(rating);
    map['previous_interval'] = Variable<int>(previousInterval);
    map['new_interval'] = Variable<int>(newInterval);
    map['reviewed_at'] = Variable<DateTime>(reviewedAt);
    return map;
  }

  ReviewHistoryCompanion toCompanion(bool nullToAbsent) {
    return ReviewHistoryCompanion(
      id: Value(id),
      reviewItemId: Value(reviewItemId),
      itemType: Value(itemType),
      itemId: Value(itemId),
      rating: Value(rating),
      previousInterval: Value(previousInterval),
      newInterval: Value(newInterval),
      reviewedAt: Value(reviewedAt),
    );
  }

  factory ReviewHistoryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewHistoryRow(
      id: serializer.fromJson<String>(json['id']),
      reviewItemId: serializer.fromJson<String>(json['reviewItemId']),
      itemType: serializer.fromJson<String>(json['itemType']),
      itemId: serializer.fromJson<String>(json['itemId']),
      rating: serializer.fromJson<int>(json['rating']),
      previousInterval: serializer.fromJson<int>(json['previousInterval']),
      newInterval: serializer.fromJson<int>(json['newInterval']),
      reviewedAt: serializer.fromJson<DateTime>(json['reviewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'reviewItemId': serializer.toJson<String>(reviewItemId),
      'itemType': serializer.toJson<String>(itemType),
      'itemId': serializer.toJson<String>(itemId),
      'rating': serializer.toJson<int>(rating),
      'previousInterval': serializer.toJson<int>(previousInterval),
      'newInterval': serializer.toJson<int>(newInterval),
      'reviewedAt': serializer.toJson<DateTime>(reviewedAt),
    };
  }

  ReviewHistoryRow copyWith({
    String? id,
    String? reviewItemId,
    String? itemType,
    String? itemId,
    int? rating,
    int? previousInterval,
    int? newInterval,
    DateTime? reviewedAt,
  }) => ReviewHistoryRow(
    id: id ?? this.id,
    reviewItemId: reviewItemId ?? this.reviewItemId,
    itemType: itemType ?? this.itemType,
    itemId: itemId ?? this.itemId,
    rating: rating ?? this.rating,
    previousInterval: previousInterval ?? this.previousInterval,
    newInterval: newInterval ?? this.newInterval,
    reviewedAt: reviewedAt ?? this.reviewedAt,
  );
  ReviewHistoryRow copyWithCompanion(ReviewHistoryCompanion data) {
    return ReviewHistoryRow(
      id: data.id.present ? data.id.value : this.id,
      reviewItemId: data.reviewItemId.present
          ? data.reviewItemId.value
          : this.reviewItemId,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      rating: data.rating.present ? data.rating.value : this.rating,
      previousInterval: data.previousInterval.present
          ? data.previousInterval.value
          : this.previousInterval,
      newInterval: data.newInterval.present
          ? data.newInterval.value
          : this.newInterval,
      reviewedAt: data.reviewedAt.present
          ? data.reviewedAt.value
          : this.reviewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewHistoryRow(')
          ..write('id: $id, ')
          ..write('reviewItemId: $reviewItemId, ')
          ..write('itemType: $itemType, ')
          ..write('itemId: $itemId, ')
          ..write('rating: $rating, ')
          ..write('previousInterval: $previousInterval, ')
          ..write('newInterval: $newInterval, ')
          ..write('reviewedAt: $reviewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    reviewItemId,
    itemType,
    itemId,
    rating,
    previousInterval,
    newInterval,
    reviewedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewHistoryRow &&
          other.id == this.id &&
          other.reviewItemId == this.reviewItemId &&
          other.itemType == this.itemType &&
          other.itemId == this.itemId &&
          other.rating == this.rating &&
          other.previousInterval == this.previousInterval &&
          other.newInterval == this.newInterval &&
          other.reviewedAt == this.reviewedAt);
}

class ReviewHistoryCompanion extends UpdateCompanion<ReviewHistoryRow> {
  final Value<String> id;
  final Value<String> reviewItemId;
  final Value<String> itemType;
  final Value<String> itemId;
  final Value<int> rating;
  final Value<int> previousInterval;
  final Value<int> newInterval;
  final Value<DateTime> reviewedAt;
  final Value<int> rowid;
  const ReviewHistoryCompanion({
    this.id = const Value.absent(),
    this.reviewItemId = const Value.absent(),
    this.itemType = const Value.absent(),
    this.itemId = const Value.absent(),
    this.rating = const Value.absent(),
    this.previousInterval = const Value.absent(),
    this.newInterval = const Value.absent(),
    this.reviewedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewHistoryCompanion.insert({
    required String id,
    required String reviewItemId,
    required String itemType,
    required String itemId,
    required int rating,
    required int previousInterval,
    required int newInterval,
    required DateTime reviewedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       reviewItemId = Value(reviewItemId),
       itemType = Value(itemType),
       itemId = Value(itemId),
       rating = Value(rating),
       previousInterval = Value(previousInterval),
       newInterval = Value(newInterval),
       reviewedAt = Value(reviewedAt);
  static Insertable<ReviewHistoryRow> custom({
    Expression<String>? id,
    Expression<String>? reviewItemId,
    Expression<String>? itemType,
    Expression<String>? itemId,
    Expression<int>? rating,
    Expression<int>? previousInterval,
    Expression<int>? newInterval,
    Expression<DateTime>? reviewedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reviewItemId != null) 'review_item_id': reviewItemId,
      if (itemType != null) 'item_type': itemType,
      if (itemId != null) 'item_id': itemId,
      if (rating != null) 'rating': rating,
      if (previousInterval != null) 'previous_interval': previousInterval,
      if (newInterval != null) 'new_interval': newInterval,
      if (reviewedAt != null) 'reviewed_at': reviewedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewHistoryCompanion copyWith({
    Value<String>? id,
    Value<String>? reviewItemId,
    Value<String>? itemType,
    Value<String>? itemId,
    Value<int>? rating,
    Value<int>? previousInterval,
    Value<int>? newInterval,
    Value<DateTime>? reviewedAt,
    Value<int>? rowid,
  }) {
    return ReviewHistoryCompanion(
      id: id ?? this.id,
      reviewItemId: reviewItemId ?? this.reviewItemId,
      itemType: itemType ?? this.itemType,
      itemId: itemId ?? this.itemId,
      rating: rating ?? this.rating,
      previousInterval: previousInterval ?? this.previousInterval,
      newInterval: newInterval ?? this.newInterval,
      reviewedAt: reviewedAt ?? this.reviewedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (reviewItemId.present) {
      map['review_item_id'] = Variable<String>(reviewItemId.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (previousInterval.present) {
      map['previous_interval'] = Variable<int>(previousInterval.value);
    }
    if (newInterval.present) {
      map['new_interval'] = Variable<int>(newInterval.value);
    }
    if (reviewedAt.present) {
      map['reviewed_at'] = Variable<DateTime>(reviewedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewHistoryCompanion(')
          ..write('id: $id, ')
          ..write('reviewItemId: $reviewItemId, ')
          ..write('itemType: $itemType, ')
          ..write('itemId: $itemId, ')
          ..write('rating: $rating, ')
          ..write('previousInterval: $previousInterval, ')
          ..write('newInterval: $newInterval, ')
          ..write('reviewedAt: $reviewedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PronunciationCacheTable extends PronunciationCache
    with TableInfo<$PronunciationCacheTable, PronunciationCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PronunciationCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentHashMeta = const VerificationMeta(
    'contentHash',
  );
  @override
  late final GeneratedColumn<String> contentHash = GeneratedColumn<String>(
    'content_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _textContentMeta = const VerificationMeta(
    'textContent',
  );
  @override
  late final GeneratedColumn<String> textContent = GeneratedColumn<String>(
    'text_content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accentMeta = const VerificationMeta('accent');
  @override
  late final GeneratedColumn<String> accent = GeneratedColumn<String>(
    'accent',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speedMeta = const VerificationMeta('speed');
  @override
  late final GeneratedColumn<double> speed = GeneratedColumn<double>(
    'speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    contentHash,
    textContent,
    accent,
    speed,
    filePath,
    provider,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pronunciation_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<PronunciationCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('content_hash')) {
      context.handle(
        _contentHashMeta,
        contentHash.isAcceptableOrUnknown(
          data['content_hash']!,
          _contentHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentHashMeta);
    }
    if (data.containsKey('text_content')) {
      context.handle(
        _textContentMeta,
        textContent.isAcceptableOrUnknown(
          data['text_content']!,
          _textContentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_textContentMeta);
    }
    if (data.containsKey('accent')) {
      context.handle(
        _accentMeta,
        accent.isAcceptableOrUnknown(data['accent']!, _accentMeta),
      );
    } else if (isInserting) {
      context.missing(_accentMeta);
    }
    if (data.containsKey('speed')) {
      context.handle(
        _speedMeta,
        speed.isAcceptableOrUnknown(data['speed']!, _speedMeta),
      );
    } else if (isInserting) {
      context.missing(_speedMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    } else if (isInserting) {
      context.missing(_providerMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {contentHash, accent, speed, provider},
  ];
  @override
  PronunciationCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PronunciationCacheRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      contentHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_hash'],
      )!,
      textContent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text_content'],
      )!,
      accent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent'],
      )!,
      speed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PronunciationCacheTable createAlias(String alias) {
    return $PronunciationCacheTable(attachedDatabase, alias);
  }
}

class PronunciationCacheRow extends DataClass
    implements Insertable<PronunciationCacheRow> {
  final String id;
  final String contentHash;
  final String textContent;
  final String accent;
  final double speed;
  final String filePath;
  final String provider;
  final DateTime createdAt;
  const PronunciationCacheRow({
    required this.id,
    required this.contentHash,
    required this.textContent,
    required this.accent,
    required this.speed,
    required this.filePath,
    required this.provider,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['content_hash'] = Variable<String>(contentHash);
    map['text_content'] = Variable<String>(textContent);
    map['accent'] = Variable<String>(accent);
    map['speed'] = Variable<double>(speed);
    map['file_path'] = Variable<String>(filePath);
    map['provider'] = Variable<String>(provider);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PronunciationCacheCompanion toCompanion(bool nullToAbsent) {
    return PronunciationCacheCompanion(
      id: Value(id),
      contentHash: Value(contentHash),
      textContent: Value(textContent),
      accent: Value(accent),
      speed: Value(speed),
      filePath: Value(filePath),
      provider: Value(provider),
      createdAt: Value(createdAt),
    );
  }

  factory PronunciationCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PronunciationCacheRow(
      id: serializer.fromJson<String>(json['id']),
      contentHash: serializer.fromJson<String>(json['contentHash']),
      textContent: serializer.fromJson<String>(json['textContent']),
      accent: serializer.fromJson<String>(json['accent']),
      speed: serializer.fromJson<double>(json['speed']),
      filePath: serializer.fromJson<String>(json['filePath']),
      provider: serializer.fromJson<String>(json['provider']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'contentHash': serializer.toJson<String>(contentHash),
      'textContent': serializer.toJson<String>(textContent),
      'accent': serializer.toJson<String>(accent),
      'speed': serializer.toJson<double>(speed),
      'filePath': serializer.toJson<String>(filePath),
      'provider': serializer.toJson<String>(provider),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PronunciationCacheRow copyWith({
    String? id,
    String? contentHash,
    String? textContent,
    String? accent,
    double? speed,
    String? filePath,
    String? provider,
    DateTime? createdAt,
  }) => PronunciationCacheRow(
    id: id ?? this.id,
    contentHash: contentHash ?? this.contentHash,
    textContent: textContent ?? this.textContent,
    accent: accent ?? this.accent,
    speed: speed ?? this.speed,
    filePath: filePath ?? this.filePath,
    provider: provider ?? this.provider,
    createdAt: createdAt ?? this.createdAt,
  );
  PronunciationCacheRow copyWithCompanion(PronunciationCacheCompanion data) {
    return PronunciationCacheRow(
      id: data.id.present ? data.id.value : this.id,
      contentHash: data.contentHash.present
          ? data.contentHash.value
          : this.contentHash,
      textContent: data.textContent.present
          ? data.textContent.value
          : this.textContent,
      accent: data.accent.present ? data.accent.value : this.accent,
      speed: data.speed.present ? data.speed.value : this.speed,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      provider: data.provider.present ? data.provider.value : this.provider,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PronunciationCacheRow(')
          ..write('id: $id, ')
          ..write('contentHash: $contentHash, ')
          ..write('textContent: $textContent, ')
          ..write('accent: $accent, ')
          ..write('speed: $speed, ')
          ..write('filePath: $filePath, ')
          ..write('provider: $provider, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    contentHash,
    textContent,
    accent,
    speed,
    filePath,
    provider,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PronunciationCacheRow &&
          other.id == this.id &&
          other.contentHash == this.contentHash &&
          other.textContent == this.textContent &&
          other.accent == this.accent &&
          other.speed == this.speed &&
          other.filePath == this.filePath &&
          other.provider == this.provider &&
          other.createdAt == this.createdAt);
}

class PronunciationCacheCompanion
    extends UpdateCompanion<PronunciationCacheRow> {
  final Value<String> id;
  final Value<String> contentHash;
  final Value<String> textContent;
  final Value<String> accent;
  final Value<double> speed;
  final Value<String> filePath;
  final Value<String> provider;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PronunciationCacheCompanion({
    this.id = const Value.absent(),
    this.contentHash = const Value.absent(),
    this.textContent = const Value.absent(),
    this.accent = const Value.absent(),
    this.speed = const Value.absent(),
    this.filePath = const Value.absent(),
    this.provider = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PronunciationCacheCompanion.insert({
    required String id,
    required String contentHash,
    required String textContent,
    required String accent,
    required double speed,
    required String filePath,
    required String provider,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       contentHash = Value(contentHash),
       textContent = Value(textContent),
       accent = Value(accent),
       speed = Value(speed),
       filePath = Value(filePath),
       provider = Value(provider),
       createdAt = Value(createdAt);
  static Insertable<PronunciationCacheRow> custom({
    Expression<String>? id,
    Expression<String>? contentHash,
    Expression<String>? textContent,
    Expression<String>? accent,
    Expression<double>? speed,
    Expression<String>? filePath,
    Expression<String>? provider,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentHash != null) 'content_hash': contentHash,
      if (textContent != null) 'text_content': textContent,
      if (accent != null) 'accent': accent,
      if (speed != null) 'speed': speed,
      if (filePath != null) 'file_path': filePath,
      if (provider != null) 'provider': provider,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PronunciationCacheCompanion copyWith({
    Value<String>? id,
    Value<String>? contentHash,
    Value<String>? textContent,
    Value<String>? accent,
    Value<double>? speed,
    Value<String>? filePath,
    Value<String>? provider,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PronunciationCacheCompanion(
      id: id ?? this.id,
      contentHash: contentHash ?? this.contentHash,
      textContent: textContent ?? this.textContent,
      accent: accent ?? this.accent,
      speed: speed ?? this.speed,
      filePath: filePath ?? this.filePath,
      provider: provider ?? this.provider,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (contentHash.present) {
      map['content_hash'] = Variable<String>(contentHash.value);
    }
    if (textContent.present) {
      map['text_content'] = Variable<String>(textContent.value);
    }
    if (accent.present) {
      map['accent'] = Variable<String>(accent.value);
    }
    if (speed.present) {
      map['speed'] = Variable<double>(speed.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PronunciationCacheCompanion(')
          ..write('id: $id, ')
          ..write('contentHash: $contentHash, ')
          ..write('textContent: $textContent, ')
          ..write('accent: $accent, ')
          ..write('speed: $speed, ')
          ..write('filePath: $filePath, ')
          ..write('provider: $provider, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearningSessionsTable extends LearningSessions
    with TableInfo<$LearningSessionsTable, LearningSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionTypeMeta = const VerificationMeta(
    'sessionType',
  );
  @override
  late final GeneratedColumn<String> sessionType = GeneratedColumn<String>(
    'session_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reviewedCountMeta = const VerificationMeta(
    'reviewedCount',
  );
  @override
  late final GeneratedColumn<int> reviewedCount = GeneratedColumn<int>(
    'reviewed_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _incorrectCountMeta = const VerificationMeta(
    'incorrectCount',
  );
  @override
  late final GeneratedColumn<int> incorrectCount = GeneratedColumn<int>(
    'incorrect_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _skippedCountMeta = const VerificationMeta(
    'skippedCount',
  );
  @override
  late final GeneratedColumn<int> skippedCount = GeneratedColumn<int>(
    'skipped_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionType,
    reviewedCount,
    correctCount,
    incorrectCount,
    skippedCount,
    startedAt,
    endedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningSessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_type')) {
      context.handle(
        _sessionTypeMeta,
        sessionType.isAcceptableOrUnknown(
          data['session_type']!,
          _sessionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionTypeMeta);
    }
    if (data.containsKey('reviewed_count')) {
      context.handle(
        _reviewedCountMeta,
        reviewedCount.isAcceptableOrUnknown(
          data['reviewed_count']!,
          _reviewedCountMeta,
        ),
      );
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('incorrect_count')) {
      context.handle(
        _incorrectCountMeta,
        incorrectCount.isAcceptableOrUnknown(
          data['incorrect_count']!,
          _incorrectCountMeta,
        ),
      );
    }
    if (data.containsKey('skipped_count')) {
      context.handle(
        _skippedCountMeta,
        skippedCount.isAcceptableOrUnknown(
          data['skipped_count']!,
          _skippedCountMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_type'],
      )!,
      reviewedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reviewed_count'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      incorrectCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}incorrect_count'],
      )!,
      skippedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}skipped_count'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
    );
  }

  @override
  $LearningSessionsTable createAlias(String alias) {
    return $LearningSessionsTable(attachedDatabase, alias);
  }
}

class LearningSessionRow extends DataClass
    implements Insertable<LearningSessionRow> {
  final String id;
  final String sessionType;
  final int reviewedCount;
  final int correctCount;
  final int incorrectCount;
  final int skippedCount;
  final DateTime startedAt;
  final DateTime? endedAt;
  const LearningSessionRow({
    required this.id,
    required this.sessionType,
    required this.reviewedCount,
    required this.correctCount,
    required this.incorrectCount,
    required this.skippedCount,
    required this.startedAt,
    this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_type'] = Variable<String>(sessionType);
    map['reviewed_count'] = Variable<int>(reviewedCount);
    map['correct_count'] = Variable<int>(correctCount);
    map['incorrect_count'] = Variable<int>(incorrectCount);
    map['skipped_count'] = Variable<int>(skippedCount);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    return map;
  }

  LearningSessionsCompanion toCompanion(bool nullToAbsent) {
    return LearningSessionsCompanion(
      id: Value(id),
      sessionType: Value(sessionType),
      reviewedCount: Value(reviewedCount),
      correctCount: Value(correctCount),
      incorrectCount: Value(incorrectCount),
      skippedCount: Value(skippedCount),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
    );
  }

  factory LearningSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningSessionRow(
      id: serializer.fromJson<String>(json['id']),
      sessionType: serializer.fromJson<String>(json['sessionType']),
      reviewedCount: serializer.fromJson<int>(json['reviewedCount']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      incorrectCount: serializer.fromJson<int>(json['incorrectCount']),
      skippedCount: serializer.fromJson<int>(json['skippedCount']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionType': serializer.toJson<String>(sessionType),
      'reviewedCount': serializer.toJson<int>(reviewedCount),
      'correctCount': serializer.toJson<int>(correctCount),
      'incorrectCount': serializer.toJson<int>(incorrectCount),
      'skippedCount': serializer.toJson<int>(skippedCount),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
    };
  }

  LearningSessionRow copyWith({
    String? id,
    String? sessionType,
    int? reviewedCount,
    int? correctCount,
    int? incorrectCount,
    int? skippedCount,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
  }) => LearningSessionRow(
    id: id ?? this.id,
    sessionType: sessionType ?? this.sessionType,
    reviewedCount: reviewedCount ?? this.reviewedCount,
    correctCount: correctCount ?? this.correctCount,
    incorrectCount: incorrectCount ?? this.incorrectCount,
    skippedCount: skippedCount ?? this.skippedCount,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
  );
  LearningSessionRow copyWithCompanion(LearningSessionsCompanion data) {
    return LearningSessionRow(
      id: data.id.present ? data.id.value : this.id,
      sessionType: data.sessionType.present
          ? data.sessionType.value
          : this.sessionType,
      reviewedCount: data.reviewedCount.present
          ? data.reviewedCount.value
          : this.reviewedCount,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      incorrectCount: data.incorrectCount.present
          ? data.incorrectCount.value
          : this.incorrectCount,
      skippedCount: data.skippedCount.present
          ? data.skippedCount.value
          : this.skippedCount,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningSessionRow(')
          ..write('id: $id, ')
          ..write('sessionType: $sessionType, ')
          ..write('reviewedCount: $reviewedCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('incorrectCount: $incorrectCount, ')
          ..write('skippedCount: $skippedCount, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionType,
    reviewedCount,
    correctCount,
    incorrectCount,
    skippedCount,
    startedAt,
    endedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningSessionRow &&
          other.id == this.id &&
          other.sessionType == this.sessionType &&
          other.reviewedCount == this.reviewedCount &&
          other.correctCount == this.correctCount &&
          other.incorrectCount == this.incorrectCount &&
          other.skippedCount == this.skippedCount &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt);
}

class LearningSessionsCompanion extends UpdateCompanion<LearningSessionRow> {
  final Value<String> id;
  final Value<String> sessionType;
  final Value<int> reviewedCount;
  final Value<int> correctCount;
  final Value<int> incorrectCount;
  final Value<int> skippedCount;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> rowid;
  const LearningSessionsCompanion({
    this.id = const Value.absent(),
    this.sessionType = const Value.absent(),
    this.reviewedCount = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.incorrectCount = const Value.absent(),
    this.skippedCount = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearningSessionsCompanion.insert({
    required String id,
    required String sessionType,
    this.reviewedCount = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.incorrectCount = const Value.absent(),
    this.skippedCount = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionType = Value(sessionType),
       startedAt = Value(startedAt);
  static Insertable<LearningSessionRow> custom({
    Expression<String>? id,
    Expression<String>? sessionType,
    Expression<int>? reviewedCount,
    Expression<int>? correctCount,
    Expression<int>? incorrectCount,
    Expression<int>? skippedCount,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionType != null) 'session_type': sessionType,
      if (reviewedCount != null) 'reviewed_count': reviewedCount,
      if (correctCount != null) 'correct_count': correctCount,
      if (incorrectCount != null) 'incorrect_count': incorrectCount,
      if (skippedCount != null) 'skipped_count': skippedCount,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearningSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionType,
    Value<int>? reviewedCount,
    Value<int>? correctCount,
    Value<int>? incorrectCount,
    Value<int>? skippedCount,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int>? rowid,
  }) {
    return LearningSessionsCompanion(
      id: id ?? this.id,
      sessionType: sessionType ?? this.sessionType,
      reviewedCount: reviewedCount ?? this.reviewedCount,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
      skippedCount: skippedCount ?? this.skippedCount,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionType.present) {
      map['session_type'] = Variable<String>(sessionType.value);
    }
    if (reviewedCount.present) {
      map['reviewed_count'] = Variable<int>(reviewedCount.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (incorrectCount.present) {
      map['incorrect_count'] = Variable<int>(incorrectCount.value);
    }
    if (skippedCount.present) {
      map['skipped_count'] = Variable<int>(skippedCount.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningSessionsCompanion(')
          ..write('id: $id, ')
          ..write('sessionType: $sessionType, ')
          ..write('reviewedCount: $reviewedCount, ')
          ..write('correctCount: $correctCount, ')
          ..write('incorrectCount: $incorrectCount, ')
          ..write('skippedCount: $skippedCount, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTable extends UserPreferences
    with TableInfo<$UserPreferencesTable, UserPreferenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreferenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  UserPreferenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreferenceRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserPreferencesTable createAlias(String alias) {
    return $UserPreferencesTable(attachedDatabase, alias);
  }
}

class UserPreferenceRow extends DataClass
    implements Insertable<UserPreferenceRow> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const UserPreferenceRow({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserPreferenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreferenceRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserPreferenceRow copyWith({
    String? key,
    String? value,
    DateTime? updatedAt,
  }) => UserPreferenceRow(
    key: key ?? this.key,
    value: value ?? this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserPreferenceRow copyWithCompanion(UserPreferencesCompanion data) {
    return UserPreferenceRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferenceRow(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreferenceRow &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class UserPreferencesCompanion extends UpdateCompanion<UserPreferenceRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserPreferencesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserPreferencesCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<UserPreferenceRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserPreferencesCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserPreferencesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppStatisticsTable extends AppStatistics
    with TableInfo<$AppStatisticsTable, AppStatisticRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppStatisticsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_statistics';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppStatisticRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppStatisticRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppStatisticRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppStatisticsTable createAlias(String alias) {
    return $AppStatisticsTable(attachedDatabase, alias);
  }
}

class AppStatisticRow extends DataClass implements Insertable<AppStatisticRow> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppStatisticRow({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppStatisticsCompanion toCompanion(bool nullToAbsent) {
    return AppStatisticsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppStatisticRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppStatisticRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppStatisticRow copyWith({String? key, String? value, DateTime? updatedAt}) =>
      AppStatisticRow(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppStatisticRow copyWithCompanion(AppStatisticsCompanion data) {
    return AppStatisticRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppStatisticRow(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppStatisticRow &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppStatisticsCompanion extends UpdateCompanion<AppStatisticRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppStatisticsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppStatisticsCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<AppStatisticRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppStatisticsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppStatisticsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppStatisticsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VocabularyEntriesTable extends VocabularyEntries
    with TableInfo<$VocabularyEntriesTable, VocabularyEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabularyEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lemmaMeta = const VerificationMeta('lemma');
  @override
  late final GeneratedColumn<String> lemma = GeneratedColumn<String>(
    'lemma',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cefrLevelMeta = const VerificationMeta(
    'cefrLevel',
  );
  @override
  late final GeneratedColumn<String> cefrLevel = GeneratedColumn<String>(
    'cefr_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partOfSpeechMeta = const VerificationMeta(
    'partOfSpeech',
  );
  @override
  late final GeneratedColumn<String> partOfSpeech = GeneratedColumn<String>(
    'part_of_speech',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _definitionEnMeta = const VerificationMeta(
    'definitionEn',
  );
  @override
  late final GeneratedColumn<String> definitionEn = GeneratedColumn<String>(
    'definition_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _arabicMeaningMeta = const VerificationMeta(
    'arabicMeaning',
  );
  @override
  late final GeneratedColumn<String> arabicMeaning = GeneratedColumn<String>(
    'arabic_meaning',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exampleSentenceMeta = const VerificationMeta(
    'exampleSentence',
  );
  @override
  late final GeneratedColumn<String> exampleSentence = GeneratedColumn<String>(
    'example_sentence',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneticMeta = const VerificationMeta(
    'phonetic',
  );
  @override
  late final GeneratedColumn<String> phonetic = GeneratedColumn<String>(
    'phonetic',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _academicMeta = const VerificationMeta(
    'academic',
  );
  @override
  late final GeneratedColumn<bool> academic = GeneratedColumn<bool>(
    'academic',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("academic" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _ieltsRelevantMeta = const VerificationMeta(
    'ieltsRelevant',
  );
  @override
  late final GeneratedColumn<bool> ieltsRelevant = GeneratedColumn<bool>(
    'ielts_relevant',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ielts_relevant" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _toeflRelevantMeta = const VerificationMeta(
    'toeflRelevant',
  );
  @override
  late final GeneratedColumn<bool> toeflRelevant = GeneratedColumn<bool>(
    'toefl_relevant',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("toefl_relevant" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _catalogVersionMeta = const VerificationMeta(
    'catalogVersion',
  );
  @override
  late final GeneratedColumn<int> catalogVersion = GeneratedColumn<int>(
    'catalog_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lemma,
    cefrLevel,
    partOfSpeech,
    definitionEn,
    arabicMeaning,
    exampleSentence,
    phonetic,
    academic,
    ieltsRelevant,
    toeflRelevant,
    catalogVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabulary_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<VocabularyEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lemma')) {
      context.handle(
        _lemmaMeta,
        lemma.isAcceptableOrUnknown(data['lemma']!, _lemmaMeta),
      );
    } else if (isInserting) {
      context.missing(_lemmaMeta);
    }
    if (data.containsKey('cefr_level')) {
      context.handle(
        _cefrLevelMeta,
        cefrLevel.isAcceptableOrUnknown(data['cefr_level']!, _cefrLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_cefrLevelMeta);
    }
    if (data.containsKey('part_of_speech')) {
      context.handle(
        _partOfSpeechMeta,
        partOfSpeech.isAcceptableOrUnknown(
          data['part_of_speech']!,
          _partOfSpeechMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_partOfSpeechMeta);
    }
    if (data.containsKey('definition_en')) {
      context.handle(
        _definitionEnMeta,
        definitionEn.isAcceptableOrUnknown(
          data['definition_en']!,
          _definitionEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_definitionEnMeta);
    }
    if (data.containsKey('arabic_meaning')) {
      context.handle(
        _arabicMeaningMeta,
        arabicMeaning.isAcceptableOrUnknown(
          data['arabic_meaning']!,
          _arabicMeaningMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_arabicMeaningMeta);
    }
    if (data.containsKey('example_sentence')) {
      context.handle(
        _exampleSentenceMeta,
        exampleSentence.isAcceptableOrUnknown(
          data['example_sentence']!,
          _exampleSentenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exampleSentenceMeta);
    }
    if (data.containsKey('phonetic')) {
      context.handle(
        _phoneticMeta,
        phonetic.isAcceptableOrUnknown(data['phonetic']!, _phoneticMeta),
      );
    }
    if (data.containsKey('academic')) {
      context.handle(
        _academicMeta,
        academic.isAcceptableOrUnknown(data['academic']!, _academicMeta),
      );
    }
    if (data.containsKey('ielts_relevant')) {
      context.handle(
        _ieltsRelevantMeta,
        ieltsRelevant.isAcceptableOrUnknown(
          data['ielts_relevant']!,
          _ieltsRelevantMeta,
        ),
      );
    }
    if (data.containsKey('toefl_relevant')) {
      context.handle(
        _toeflRelevantMeta,
        toeflRelevant.isAcceptableOrUnknown(
          data['toefl_relevant']!,
          _toeflRelevantMeta,
        ),
      );
    }
    if (data.containsKey('catalog_version')) {
      context.handle(
        _catalogVersionMeta,
        catalogVersion.isAcceptableOrUnknown(
          data['catalog_version']!,
          _catalogVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VocabularyEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabularyEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      lemma: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lemma'],
      )!,
      cefrLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cefr_level'],
      )!,
      partOfSpeech: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_of_speech'],
      )!,
      definitionEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}definition_en'],
      )!,
      arabicMeaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arabic_meaning'],
      )!,
      exampleSentence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}example_sentence'],
      )!,
      phonetic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phonetic'],
      ),
      academic: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}academic'],
      )!,
      ieltsRelevant: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ielts_relevant'],
      )!,
      toeflRelevant: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}toefl_relevant'],
      )!,
      catalogVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}catalog_version'],
      )!,
    );
  }

  @override
  $VocabularyEntriesTable createAlias(String alias) {
    return $VocabularyEntriesTable(attachedDatabase, alias);
  }
}

class VocabularyEntryRow extends DataClass
    implements Insertable<VocabularyEntryRow> {
  final String id;
  final String lemma;
  final String cefrLevel;
  final String partOfSpeech;
  final String definitionEn;
  final String arabicMeaning;
  final String exampleSentence;
  final String? phonetic;
  final bool academic;
  final bool ieltsRelevant;
  final bool toeflRelevant;
  final int catalogVersion;
  const VocabularyEntryRow({
    required this.id,
    required this.lemma,
    required this.cefrLevel,
    required this.partOfSpeech,
    required this.definitionEn,
    required this.arabicMeaning,
    required this.exampleSentence,
    this.phonetic,
    required this.academic,
    required this.ieltsRelevant,
    required this.toeflRelevant,
    required this.catalogVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['lemma'] = Variable<String>(lemma);
    map['cefr_level'] = Variable<String>(cefrLevel);
    map['part_of_speech'] = Variable<String>(partOfSpeech);
    map['definition_en'] = Variable<String>(definitionEn);
    map['arabic_meaning'] = Variable<String>(arabicMeaning);
    map['example_sentence'] = Variable<String>(exampleSentence);
    if (!nullToAbsent || phonetic != null) {
      map['phonetic'] = Variable<String>(phonetic);
    }
    map['academic'] = Variable<bool>(academic);
    map['ielts_relevant'] = Variable<bool>(ieltsRelevant);
    map['toefl_relevant'] = Variable<bool>(toeflRelevant);
    map['catalog_version'] = Variable<int>(catalogVersion);
    return map;
  }

  VocabularyEntriesCompanion toCompanion(bool nullToAbsent) {
    return VocabularyEntriesCompanion(
      id: Value(id),
      lemma: Value(lemma),
      cefrLevel: Value(cefrLevel),
      partOfSpeech: Value(partOfSpeech),
      definitionEn: Value(definitionEn),
      arabicMeaning: Value(arabicMeaning),
      exampleSentence: Value(exampleSentence),
      phonetic: phonetic == null && nullToAbsent
          ? const Value.absent()
          : Value(phonetic),
      academic: Value(academic),
      ieltsRelevant: Value(ieltsRelevant),
      toeflRelevant: Value(toeflRelevant),
      catalogVersion: Value(catalogVersion),
    );
  }

  factory VocabularyEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabularyEntryRow(
      id: serializer.fromJson<String>(json['id']),
      lemma: serializer.fromJson<String>(json['lemma']),
      cefrLevel: serializer.fromJson<String>(json['cefrLevel']),
      partOfSpeech: serializer.fromJson<String>(json['partOfSpeech']),
      definitionEn: serializer.fromJson<String>(json['definitionEn']),
      arabicMeaning: serializer.fromJson<String>(json['arabicMeaning']),
      exampleSentence: serializer.fromJson<String>(json['exampleSentence']),
      phonetic: serializer.fromJson<String?>(json['phonetic']),
      academic: serializer.fromJson<bool>(json['academic']),
      ieltsRelevant: serializer.fromJson<bool>(json['ieltsRelevant']),
      toeflRelevant: serializer.fromJson<bool>(json['toeflRelevant']),
      catalogVersion: serializer.fromJson<int>(json['catalogVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lemma': serializer.toJson<String>(lemma),
      'cefrLevel': serializer.toJson<String>(cefrLevel),
      'partOfSpeech': serializer.toJson<String>(partOfSpeech),
      'definitionEn': serializer.toJson<String>(definitionEn),
      'arabicMeaning': serializer.toJson<String>(arabicMeaning),
      'exampleSentence': serializer.toJson<String>(exampleSentence),
      'phonetic': serializer.toJson<String?>(phonetic),
      'academic': serializer.toJson<bool>(academic),
      'ieltsRelevant': serializer.toJson<bool>(ieltsRelevant),
      'toeflRelevant': serializer.toJson<bool>(toeflRelevant),
      'catalogVersion': serializer.toJson<int>(catalogVersion),
    };
  }

  VocabularyEntryRow copyWith({
    String? id,
    String? lemma,
    String? cefrLevel,
    String? partOfSpeech,
    String? definitionEn,
    String? arabicMeaning,
    String? exampleSentence,
    Value<String?> phonetic = const Value.absent(),
    bool? academic,
    bool? ieltsRelevant,
    bool? toeflRelevant,
    int? catalogVersion,
  }) => VocabularyEntryRow(
    id: id ?? this.id,
    lemma: lemma ?? this.lemma,
    cefrLevel: cefrLevel ?? this.cefrLevel,
    partOfSpeech: partOfSpeech ?? this.partOfSpeech,
    definitionEn: definitionEn ?? this.definitionEn,
    arabicMeaning: arabicMeaning ?? this.arabicMeaning,
    exampleSentence: exampleSentence ?? this.exampleSentence,
    phonetic: phonetic.present ? phonetic.value : this.phonetic,
    academic: academic ?? this.academic,
    ieltsRelevant: ieltsRelevant ?? this.ieltsRelevant,
    toeflRelevant: toeflRelevant ?? this.toeflRelevant,
    catalogVersion: catalogVersion ?? this.catalogVersion,
  );
  VocabularyEntryRow copyWithCompanion(VocabularyEntriesCompanion data) {
    return VocabularyEntryRow(
      id: data.id.present ? data.id.value : this.id,
      lemma: data.lemma.present ? data.lemma.value : this.lemma,
      cefrLevel: data.cefrLevel.present ? data.cefrLevel.value : this.cefrLevel,
      partOfSpeech: data.partOfSpeech.present
          ? data.partOfSpeech.value
          : this.partOfSpeech,
      definitionEn: data.definitionEn.present
          ? data.definitionEn.value
          : this.definitionEn,
      arabicMeaning: data.arabicMeaning.present
          ? data.arabicMeaning.value
          : this.arabicMeaning,
      exampleSentence: data.exampleSentence.present
          ? data.exampleSentence.value
          : this.exampleSentence,
      phonetic: data.phonetic.present ? data.phonetic.value : this.phonetic,
      academic: data.academic.present ? data.academic.value : this.academic,
      ieltsRelevant: data.ieltsRelevant.present
          ? data.ieltsRelevant.value
          : this.ieltsRelevant,
      toeflRelevant: data.toeflRelevant.present
          ? data.toeflRelevant.value
          : this.toeflRelevant,
      catalogVersion: data.catalogVersion.present
          ? data.catalogVersion.value
          : this.catalogVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyEntryRow(')
          ..write('id: $id, ')
          ..write('lemma: $lemma, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('definitionEn: $definitionEn, ')
          ..write('arabicMeaning: $arabicMeaning, ')
          ..write('exampleSentence: $exampleSentence, ')
          ..write('phonetic: $phonetic, ')
          ..write('academic: $academic, ')
          ..write('ieltsRelevant: $ieltsRelevant, ')
          ..write('toeflRelevant: $toeflRelevant, ')
          ..write('catalogVersion: $catalogVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lemma,
    cefrLevel,
    partOfSpeech,
    definitionEn,
    arabicMeaning,
    exampleSentence,
    phonetic,
    academic,
    ieltsRelevant,
    toeflRelevant,
    catalogVersion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabularyEntryRow &&
          other.id == this.id &&
          other.lemma == this.lemma &&
          other.cefrLevel == this.cefrLevel &&
          other.partOfSpeech == this.partOfSpeech &&
          other.definitionEn == this.definitionEn &&
          other.arabicMeaning == this.arabicMeaning &&
          other.exampleSentence == this.exampleSentence &&
          other.phonetic == this.phonetic &&
          other.academic == this.academic &&
          other.ieltsRelevant == this.ieltsRelevant &&
          other.toeflRelevant == this.toeflRelevant &&
          other.catalogVersion == this.catalogVersion);
}

class VocabularyEntriesCompanion extends UpdateCompanion<VocabularyEntryRow> {
  final Value<String> id;
  final Value<String> lemma;
  final Value<String> cefrLevel;
  final Value<String> partOfSpeech;
  final Value<String> definitionEn;
  final Value<String> arabicMeaning;
  final Value<String> exampleSentence;
  final Value<String?> phonetic;
  final Value<bool> academic;
  final Value<bool> ieltsRelevant;
  final Value<bool> toeflRelevant;
  final Value<int> catalogVersion;
  final Value<int> rowid;
  const VocabularyEntriesCompanion({
    this.id = const Value.absent(),
    this.lemma = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.partOfSpeech = const Value.absent(),
    this.definitionEn = const Value.absent(),
    this.arabicMeaning = const Value.absent(),
    this.exampleSentence = const Value.absent(),
    this.phonetic = const Value.absent(),
    this.academic = const Value.absent(),
    this.ieltsRelevant = const Value.absent(),
    this.toeflRelevant = const Value.absent(),
    this.catalogVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VocabularyEntriesCompanion.insert({
    required String id,
    required String lemma,
    required String cefrLevel,
    required String partOfSpeech,
    required String definitionEn,
    required String arabicMeaning,
    required String exampleSentence,
    this.phonetic = const Value.absent(),
    this.academic = const Value.absent(),
    this.ieltsRelevant = const Value.absent(),
    this.toeflRelevant = const Value.absent(),
    this.catalogVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       lemma = Value(lemma),
       cefrLevel = Value(cefrLevel),
       partOfSpeech = Value(partOfSpeech),
       definitionEn = Value(definitionEn),
       arabicMeaning = Value(arabicMeaning),
       exampleSentence = Value(exampleSentence);
  static Insertable<VocabularyEntryRow> custom({
    Expression<String>? id,
    Expression<String>? lemma,
    Expression<String>? cefrLevel,
    Expression<String>? partOfSpeech,
    Expression<String>? definitionEn,
    Expression<String>? arabicMeaning,
    Expression<String>? exampleSentence,
    Expression<String>? phonetic,
    Expression<bool>? academic,
    Expression<bool>? ieltsRelevant,
    Expression<bool>? toeflRelevant,
    Expression<int>? catalogVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lemma != null) 'lemma': lemma,
      if (cefrLevel != null) 'cefr_level': cefrLevel,
      if (partOfSpeech != null) 'part_of_speech': partOfSpeech,
      if (definitionEn != null) 'definition_en': definitionEn,
      if (arabicMeaning != null) 'arabic_meaning': arabicMeaning,
      if (exampleSentence != null) 'example_sentence': exampleSentence,
      if (phonetic != null) 'phonetic': phonetic,
      if (academic != null) 'academic': academic,
      if (ieltsRelevant != null) 'ielts_relevant': ieltsRelevant,
      if (toeflRelevant != null) 'toefl_relevant': toeflRelevant,
      if (catalogVersion != null) 'catalog_version': catalogVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VocabularyEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? lemma,
    Value<String>? cefrLevel,
    Value<String>? partOfSpeech,
    Value<String>? definitionEn,
    Value<String>? arabicMeaning,
    Value<String>? exampleSentence,
    Value<String?>? phonetic,
    Value<bool>? academic,
    Value<bool>? ieltsRelevant,
    Value<bool>? toeflRelevant,
    Value<int>? catalogVersion,
    Value<int>? rowid,
  }) {
    return VocabularyEntriesCompanion(
      id: id ?? this.id,
      lemma: lemma ?? this.lemma,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definitionEn: definitionEn ?? this.definitionEn,
      arabicMeaning: arabicMeaning ?? this.arabicMeaning,
      exampleSentence: exampleSentence ?? this.exampleSentence,
      phonetic: phonetic ?? this.phonetic,
      academic: academic ?? this.academic,
      ieltsRelevant: ieltsRelevant ?? this.ieltsRelevant,
      toeflRelevant: toeflRelevant ?? this.toeflRelevant,
      catalogVersion: catalogVersion ?? this.catalogVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lemma.present) {
      map['lemma'] = Variable<String>(lemma.value);
    }
    if (cefrLevel.present) {
      map['cefr_level'] = Variable<String>(cefrLevel.value);
    }
    if (partOfSpeech.present) {
      map['part_of_speech'] = Variable<String>(partOfSpeech.value);
    }
    if (definitionEn.present) {
      map['definition_en'] = Variable<String>(definitionEn.value);
    }
    if (arabicMeaning.present) {
      map['arabic_meaning'] = Variable<String>(arabicMeaning.value);
    }
    if (exampleSentence.present) {
      map['example_sentence'] = Variable<String>(exampleSentence.value);
    }
    if (phonetic.present) {
      map['phonetic'] = Variable<String>(phonetic.value);
    }
    if (academic.present) {
      map['academic'] = Variable<bool>(academic.value);
    }
    if (ieltsRelevant.present) {
      map['ielts_relevant'] = Variable<bool>(ieltsRelevant.value);
    }
    if (toeflRelevant.present) {
      map['toefl_relevant'] = Variable<bool>(toeflRelevant.value);
    }
    if (catalogVersion.present) {
      map['catalog_version'] = Variable<int>(catalogVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyEntriesCompanion(')
          ..write('id: $id, ')
          ..write('lemma: $lemma, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('partOfSpeech: $partOfSpeech, ')
          ..write('definitionEn: $definitionEn, ')
          ..write('arabicMeaning: $arabicMeaning, ')
          ..write('exampleSentence: $exampleSentence, ')
          ..write('phonetic: $phonetic, ')
          ..write('academic: $academic, ')
          ..write('ieltsRelevant: $ieltsRelevant, ')
          ..write('toeflRelevant: $toeflRelevant, ')
          ..write('catalogVersion: $catalogVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VocabularyFormsTable extends VocabularyForms
    with TableInfo<$VocabularyFormsTable, VocabularyFormRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabularyFormsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _surfaceMeta = const VerificationMeta(
    'surface',
  );
  @override
  late final GeneratedColumn<String> surface = GeneratedColumn<String>(
    'surface',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vocabulary_entries (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [surface, entryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabulary_forms';
  @override
  VerificationContext validateIntegrity(
    Insertable<VocabularyFormRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('surface')) {
      context.handle(
        _surfaceMeta,
        surface.isAcceptableOrUnknown(data['surface']!, _surfaceMeta),
      );
    } else if (isInserting) {
      context.missing(_surfaceMeta);
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {surface};
  @override
  VocabularyFormRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabularyFormRow(
      surface: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surface'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
    );
  }

  @override
  $VocabularyFormsTable createAlias(String alias) {
    return $VocabularyFormsTable(attachedDatabase, alias);
  }
}

class VocabularyFormRow extends DataClass
    implements Insertable<VocabularyFormRow> {
  final String surface;
  final String entryId;
  const VocabularyFormRow({required this.surface, required this.entryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['surface'] = Variable<String>(surface);
    map['entry_id'] = Variable<String>(entryId);
    return map;
  }

  VocabularyFormsCompanion toCompanion(bool nullToAbsent) {
    return VocabularyFormsCompanion(
      surface: Value(surface),
      entryId: Value(entryId),
    );
  }

  factory VocabularyFormRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabularyFormRow(
      surface: serializer.fromJson<String>(json['surface']),
      entryId: serializer.fromJson<String>(json['entryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'surface': serializer.toJson<String>(surface),
      'entryId': serializer.toJson<String>(entryId),
    };
  }

  VocabularyFormRow copyWith({String? surface, String? entryId}) =>
      VocabularyFormRow(
        surface: surface ?? this.surface,
        entryId: entryId ?? this.entryId,
      );
  VocabularyFormRow copyWithCompanion(VocabularyFormsCompanion data) {
    return VocabularyFormRow(
      surface: data.surface.present ? data.surface.value : this.surface,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyFormRow(')
          ..write('surface: $surface, ')
          ..write('entryId: $entryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(surface, entryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabularyFormRow &&
          other.surface == this.surface &&
          other.entryId == this.entryId);
}

class VocabularyFormsCompanion extends UpdateCompanion<VocabularyFormRow> {
  final Value<String> surface;
  final Value<String> entryId;
  final Value<int> rowid;
  const VocabularyFormsCompanion({
    this.surface = const Value.absent(),
    this.entryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VocabularyFormsCompanion.insert({
    required String surface,
    required String entryId,
    this.rowid = const Value.absent(),
  }) : surface = Value(surface),
       entryId = Value(entryId);
  static Insertable<VocabularyFormRow> custom({
    Expression<String>? surface,
    Expression<String>? entryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (surface != null) 'surface': surface,
      if (entryId != null) 'entry_id': entryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VocabularyFormsCompanion copyWith({
    Value<String>? surface,
    Value<String>? entryId,
    Value<int>? rowid,
  }) {
    return VocabularyFormsCompanion(
      surface: surface ?? this.surface,
      entryId: entryId ?? this.entryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (surface.present) {
      map['surface'] = Variable<String>(surface.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyFormsCompanion(')
          ..write('surface: $surface, ')
          ..write('entryId: $entryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserVocabularyTable extends UserVocabulary
    with TableInfo<$UserVocabularyTable, UserVocabularyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserVocabularyTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vocabulary_entries (id)',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('discovered'),
  );
  static const VerificationMeta _firstDiscoveredAtMeta = const VerificationMeta(
    'firstDiscoveredAt',
  );
  @override
  late final GeneratedColumn<DateTime> firstDiscoveredAt =
      GeneratedColumn<DateTime>(
        'first_discovered_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _discoveredInMeta = const VerificationMeta(
    'discoveredIn',
  );
  @override
  late final GeneratedColumn<String> discoveredIn = GeneratedColumn<String>(
    'discovered_in',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usageCountMeta = const VerificationMeta(
    'usageCount',
  );
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
    'usage_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _lastUsedAtMeta = const VerificationMeta(
    'lastUsedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsedAt = GeneratedColumn<DateTime>(
    'last_used_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    entryId,
    status,
    firstDiscoveredAt,
    discoveredIn,
    sourceId,
    usageCount,
    lastUsedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_vocabulary';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserVocabularyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('first_discovered_at')) {
      context.handle(
        _firstDiscoveredAtMeta,
        firstDiscoveredAt.isAcceptableOrUnknown(
          data['first_discovered_at']!,
          _firstDiscoveredAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstDiscoveredAtMeta);
    }
    if (data.containsKey('discovered_in')) {
      context.handle(
        _discoveredInMeta,
        discoveredIn.isAcceptableOrUnknown(
          data['discovered_in']!,
          _discoveredInMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discoveredInMeta);
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    }
    if (data.containsKey('usage_count')) {
      context.handle(
        _usageCountMeta,
        usageCount.isAcceptableOrUnknown(data['usage_count']!, _usageCountMeta),
      );
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
        _lastUsedAtMeta,
        lastUsedAt.isAcceptableOrUnknown(
          data['last_used_at']!,
          _lastUsedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUsedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entryId};
  @override
  UserVocabularyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserVocabularyRow(
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      firstDiscoveredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}first_discovered_at'],
      )!,
      discoveredIn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}discovered_in'],
      )!,
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      ),
      usageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage_count'],
      )!,
      lastUsedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used_at'],
      )!,
    );
  }

  @override
  $UserVocabularyTable createAlias(String alias) {
    return $UserVocabularyTable(attachedDatabase, alias);
  }
}

class UserVocabularyRow extends DataClass
    implements Insertable<UserVocabularyRow> {
  final String entryId;
  final String status;
  final DateTime firstDiscoveredAt;
  final String discoveredIn;
  final String? sourceId;
  final int usageCount;
  final DateTime lastUsedAt;
  const UserVocabularyRow({
    required this.entryId,
    required this.status,
    required this.firstDiscoveredAt,
    required this.discoveredIn,
    this.sourceId,
    required this.usageCount,
    required this.lastUsedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entry_id'] = Variable<String>(entryId);
    map['status'] = Variable<String>(status);
    map['first_discovered_at'] = Variable<DateTime>(firstDiscoveredAt);
    map['discovered_in'] = Variable<String>(discoveredIn);
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<String>(sourceId);
    }
    map['usage_count'] = Variable<int>(usageCount);
    map['last_used_at'] = Variable<DateTime>(lastUsedAt);
    return map;
  }

  UserVocabularyCompanion toCompanion(bool nullToAbsent) {
    return UserVocabularyCompanion(
      entryId: Value(entryId),
      status: Value(status),
      firstDiscoveredAt: Value(firstDiscoveredAt),
      discoveredIn: Value(discoveredIn),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      usageCount: Value(usageCount),
      lastUsedAt: Value(lastUsedAt),
    );
  }

  factory UserVocabularyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserVocabularyRow(
      entryId: serializer.fromJson<String>(json['entryId']),
      status: serializer.fromJson<String>(json['status']),
      firstDiscoveredAt: serializer.fromJson<DateTime>(
        json['firstDiscoveredAt'],
      ),
      discoveredIn: serializer.fromJson<String>(json['discoveredIn']),
      sourceId: serializer.fromJson<String?>(json['sourceId']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
      lastUsedAt: serializer.fromJson<DateTime>(json['lastUsedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entryId': serializer.toJson<String>(entryId),
      'status': serializer.toJson<String>(status),
      'firstDiscoveredAt': serializer.toJson<DateTime>(firstDiscoveredAt),
      'discoveredIn': serializer.toJson<String>(discoveredIn),
      'sourceId': serializer.toJson<String?>(sourceId),
      'usageCount': serializer.toJson<int>(usageCount),
      'lastUsedAt': serializer.toJson<DateTime>(lastUsedAt),
    };
  }

  UserVocabularyRow copyWith({
    String? entryId,
    String? status,
    DateTime? firstDiscoveredAt,
    String? discoveredIn,
    Value<String?> sourceId = const Value.absent(),
    int? usageCount,
    DateTime? lastUsedAt,
  }) => UserVocabularyRow(
    entryId: entryId ?? this.entryId,
    status: status ?? this.status,
    firstDiscoveredAt: firstDiscoveredAt ?? this.firstDiscoveredAt,
    discoveredIn: discoveredIn ?? this.discoveredIn,
    sourceId: sourceId.present ? sourceId.value : this.sourceId,
    usageCount: usageCount ?? this.usageCount,
    lastUsedAt: lastUsedAt ?? this.lastUsedAt,
  );
  UserVocabularyRow copyWithCompanion(UserVocabularyCompanion data) {
    return UserVocabularyRow(
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      status: data.status.present ? data.status.value : this.status,
      firstDiscoveredAt: data.firstDiscoveredAt.present
          ? data.firstDiscoveredAt.value
          : this.firstDiscoveredAt,
      discoveredIn: data.discoveredIn.present
          ? data.discoveredIn.value
          : this.discoveredIn,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      usageCount: data.usageCount.present
          ? data.usageCount.value
          : this.usageCount,
      lastUsedAt: data.lastUsedAt.present
          ? data.lastUsedAt.value
          : this.lastUsedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserVocabularyRow(')
          ..write('entryId: $entryId, ')
          ..write('status: $status, ')
          ..write('firstDiscoveredAt: $firstDiscoveredAt, ')
          ..write('discoveredIn: $discoveredIn, ')
          ..write('sourceId: $sourceId, ')
          ..write('usageCount: $usageCount, ')
          ..write('lastUsedAt: $lastUsedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    entryId,
    status,
    firstDiscoveredAt,
    discoveredIn,
    sourceId,
    usageCount,
    lastUsedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserVocabularyRow &&
          other.entryId == this.entryId &&
          other.status == this.status &&
          other.firstDiscoveredAt == this.firstDiscoveredAt &&
          other.discoveredIn == this.discoveredIn &&
          other.sourceId == this.sourceId &&
          other.usageCount == this.usageCount &&
          other.lastUsedAt == this.lastUsedAt);
}

class UserVocabularyCompanion extends UpdateCompanion<UserVocabularyRow> {
  final Value<String> entryId;
  final Value<String> status;
  final Value<DateTime> firstDiscoveredAt;
  final Value<String> discoveredIn;
  final Value<String?> sourceId;
  final Value<int> usageCount;
  final Value<DateTime> lastUsedAt;
  final Value<int> rowid;
  const UserVocabularyCompanion({
    this.entryId = const Value.absent(),
    this.status = const Value.absent(),
    this.firstDiscoveredAt = const Value.absent(),
    this.discoveredIn = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserVocabularyCompanion.insert({
    required String entryId,
    this.status = const Value.absent(),
    required DateTime firstDiscoveredAt,
    required String discoveredIn,
    this.sourceId = const Value.absent(),
    this.usageCount = const Value.absent(),
    required DateTime lastUsedAt,
    this.rowid = const Value.absent(),
  }) : entryId = Value(entryId),
       firstDiscoveredAt = Value(firstDiscoveredAt),
       discoveredIn = Value(discoveredIn),
       lastUsedAt = Value(lastUsedAt);
  static Insertable<UserVocabularyRow> custom({
    Expression<String>? entryId,
    Expression<String>? status,
    Expression<DateTime>? firstDiscoveredAt,
    Expression<String>? discoveredIn,
    Expression<String>? sourceId,
    Expression<int>? usageCount,
    Expression<DateTime>? lastUsedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entryId != null) 'entry_id': entryId,
      if (status != null) 'status': status,
      if (firstDiscoveredAt != null) 'first_discovered_at': firstDiscoveredAt,
      if (discoveredIn != null) 'discovered_in': discoveredIn,
      if (sourceId != null) 'source_id': sourceId,
      if (usageCount != null) 'usage_count': usageCount,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserVocabularyCompanion copyWith({
    Value<String>? entryId,
    Value<String>? status,
    Value<DateTime>? firstDiscoveredAt,
    Value<String>? discoveredIn,
    Value<String?>? sourceId,
    Value<int>? usageCount,
    Value<DateTime>? lastUsedAt,
    Value<int>? rowid,
  }) {
    return UserVocabularyCompanion(
      entryId: entryId ?? this.entryId,
      status: status ?? this.status,
      firstDiscoveredAt: firstDiscoveredAt ?? this.firstDiscoveredAt,
      discoveredIn: discoveredIn ?? this.discoveredIn,
      sourceId: sourceId ?? this.sourceId,
      usageCount: usageCount ?? this.usageCount,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (firstDiscoveredAt.present) {
      map['first_discovered_at'] = Variable<DateTime>(firstDiscoveredAt.value);
    }
    if (discoveredIn.present) {
      map['discovered_in'] = Variable<String>(discoveredIn.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserVocabularyCompanion(')
          ..write('entryId: $entryId, ')
          ..write('status: $status, ')
          ..write('firstDiscoveredAt: $firstDiscoveredAt, ')
          ..write('discoveredIn: $discoveredIn, ')
          ..write('sourceId: $sourceId, ')
          ..write('usageCount: $usageCount, ')
          ..write('lastUsedAt: $lastUsedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BlogEntriesTable extends BlogEntries
    with TableInfo<$BlogEntriesTable, BlogEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlogEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wordCountMeta = const VerificationMeta(
    'wordCount',
  );
  @override
  late final GeneratedColumn<int> wordCount = GeneratedColumn<int>(
    'word_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _uniqueClassifiedMeta = const VerificationMeta(
    'uniqueClassified',
  );
  @override
  late final GeneratedColumn<int> uniqueClassified = GeneratedColumn<int>(
    'unique_classified',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _newDiscoveriesMeta = const VerificationMeta(
    'newDiscoveries',
  );
  @override
  late final GeneratedColumn<int> newDiscoveries = GeneratedColumn<int>(
    'new_discoveries',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _cefrDistributionJsonMeta =
      const VerificationMeta('cefrDistributionJson');
  @override
  late final GeneratedColumn<String> cefrDistributionJson =
      GeneratedColumn<String>(
        'cefr_distribution_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('{}'),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    content,
    wordCount,
    uniqueClassified,
    newDiscoveries,
    cefrDistributionJson,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blog_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<BlogEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('word_count')) {
      context.handle(
        _wordCountMeta,
        wordCount.isAcceptableOrUnknown(data['word_count']!, _wordCountMeta),
      );
    }
    if (data.containsKey('unique_classified')) {
      context.handle(
        _uniqueClassifiedMeta,
        uniqueClassified.isAcceptableOrUnknown(
          data['unique_classified']!,
          _uniqueClassifiedMeta,
        ),
      );
    }
    if (data.containsKey('new_discoveries')) {
      context.handle(
        _newDiscoveriesMeta,
        newDiscoveries.isAcceptableOrUnknown(
          data['new_discoveries']!,
          _newDiscoveriesMeta,
        ),
      );
    }
    if (data.containsKey('cefr_distribution_json')) {
      context.handle(
        _cefrDistributionJsonMeta,
        cefrDistributionJson.isAcceptableOrUnknown(
          data['cefr_distribution_json']!,
          _cefrDistributionJsonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BlogEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlogEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      wordCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}word_count'],
      )!,
      uniqueClassified: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unique_classified'],
      )!,
      newDiscoveries: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}new_discoveries'],
      )!,
      cefrDistributionJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cefr_distribution_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BlogEntriesTable createAlias(String alias) {
    return $BlogEntriesTable(attachedDatabase, alias);
  }
}

class BlogEntryRow extends DataClass implements Insertable<BlogEntryRow> {
  final String id;
  final String title;
  final String content;
  final int wordCount;
  final int uniqueClassified;
  final int newDiscoveries;
  final String cefrDistributionJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BlogEntryRow({
    required this.id,
    required this.title,
    required this.content,
    required this.wordCount,
    required this.uniqueClassified,
    required this.newDiscoveries,
    required this.cefrDistributionJson,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['word_count'] = Variable<int>(wordCount);
    map['unique_classified'] = Variable<int>(uniqueClassified);
    map['new_discoveries'] = Variable<int>(newDiscoveries);
    map['cefr_distribution_json'] = Variable<String>(cefrDistributionJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BlogEntriesCompanion toCompanion(bool nullToAbsent) {
    return BlogEntriesCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      wordCount: Value(wordCount),
      uniqueClassified: Value(uniqueClassified),
      newDiscoveries: Value(newDiscoveries),
      cefrDistributionJson: Value(cefrDistributionJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BlogEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlogEntryRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      wordCount: serializer.fromJson<int>(json['wordCount']),
      uniqueClassified: serializer.fromJson<int>(json['uniqueClassified']),
      newDiscoveries: serializer.fromJson<int>(json['newDiscoveries']),
      cefrDistributionJson: serializer.fromJson<String>(
        json['cefrDistributionJson'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'wordCount': serializer.toJson<int>(wordCount),
      'uniqueClassified': serializer.toJson<int>(uniqueClassified),
      'newDiscoveries': serializer.toJson<int>(newDiscoveries),
      'cefrDistributionJson': serializer.toJson<String>(cefrDistributionJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BlogEntryRow copyWith({
    String? id,
    String? title,
    String? content,
    int? wordCount,
    int? uniqueClassified,
    int? newDiscoveries,
    String? cefrDistributionJson,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BlogEntryRow(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    wordCount: wordCount ?? this.wordCount,
    uniqueClassified: uniqueClassified ?? this.uniqueClassified,
    newDiscoveries: newDiscoveries ?? this.newDiscoveries,
    cefrDistributionJson: cefrDistributionJson ?? this.cefrDistributionJson,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BlogEntryRow copyWithCompanion(BlogEntriesCompanion data) {
    return BlogEntryRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      wordCount: data.wordCount.present ? data.wordCount.value : this.wordCount,
      uniqueClassified: data.uniqueClassified.present
          ? data.uniqueClassified.value
          : this.uniqueClassified,
      newDiscoveries: data.newDiscoveries.present
          ? data.newDiscoveries.value
          : this.newDiscoveries,
      cefrDistributionJson: data.cefrDistributionJson.present
          ? data.cefrDistributionJson.value
          : this.cefrDistributionJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlogEntryRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('wordCount: $wordCount, ')
          ..write('uniqueClassified: $uniqueClassified, ')
          ..write('newDiscoveries: $newDiscoveries, ')
          ..write('cefrDistributionJson: $cefrDistributionJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    content,
    wordCount,
    uniqueClassified,
    newDiscoveries,
    cefrDistributionJson,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlogEntryRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.wordCount == this.wordCount &&
          other.uniqueClassified == this.uniqueClassified &&
          other.newDiscoveries == this.newDiscoveries &&
          other.cefrDistributionJson == this.cefrDistributionJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BlogEntriesCompanion extends UpdateCompanion<BlogEntryRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> content;
  final Value<int> wordCount;
  final Value<int> uniqueClassified;
  final Value<int> newDiscoveries;
  final Value<String> cefrDistributionJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BlogEntriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.wordCount = const Value.absent(),
    this.uniqueClassified = const Value.absent(),
    this.newDiscoveries = const Value.absent(),
    this.cefrDistributionJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BlogEntriesCompanion.insert({
    required String id,
    required String title,
    required String content,
    this.wordCount = const Value.absent(),
    this.uniqueClassified = const Value.absent(),
    this.newDiscoveries = const Value.absent(),
    this.cefrDistributionJson = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       content = Value(content),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BlogEntryRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? content,
    Expression<int>? wordCount,
    Expression<int>? uniqueClassified,
    Expression<int>? newDiscoveries,
    Expression<String>? cefrDistributionJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (wordCount != null) 'word_count': wordCount,
      if (uniqueClassified != null) 'unique_classified': uniqueClassified,
      if (newDiscoveries != null) 'new_discoveries': newDiscoveries,
      if (cefrDistributionJson != null)
        'cefr_distribution_json': cefrDistributionJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BlogEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? content,
    Value<int>? wordCount,
    Value<int>? uniqueClassified,
    Value<int>? newDiscoveries,
    Value<String>? cefrDistributionJson,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BlogEntriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      wordCount: wordCount ?? this.wordCount,
      uniqueClassified: uniqueClassified ?? this.uniqueClassified,
      newDiscoveries: newDiscoveries ?? this.newDiscoveries,
      cefrDistributionJson: cefrDistributionJson ?? this.cefrDistributionJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (wordCount.present) {
      map['word_count'] = Variable<int>(wordCount.value);
    }
    if (uniqueClassified.present) {
      map['unique_classified'] = Variable<int>(uniqueClassified.value);
    }
    if (newDiscoveries.present) {
      map['new_discoveries'] = Variable<int>(newDiscoveries.value);
    }
    if (cefrDistributionJson.present) {
      map['cefr_distribution_json'] = Variable<String>(
        cefrDistributionJson.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlogEntriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('wordCount: $wordCount, ')
          ..write('uniqueClassified: $uniqueClassified, ')
          ..write('newDiscoveries: $newDiscoveries, ')
          ..write('cefrDistributionJson: $cefrDistributionJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BlogVocabularyTable extends BlogVocabulary
    with TableInfo<$BlogVocabularyTable, BlogVocabularyRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlogVocabularyTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _blogIdMeta = const VerificationMeta('blogId');
  @override
  late final GeneratedColumn<String> blogId = GeneratedColumn<String>(
    'blog_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES blog_entries (id)',
    ),
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vocabulary_entries (id)',
    ),
  );
  static const VerificationMeta _occurrencesMeta = const VerificationMeta(
    'occurrences',
  );
  @override
  late final GeneratedColumn<int> occurrences = GeneratedColumn<int>(
    'occurrences',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [blogId, entryId, occurrences];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blog_vocabulary';
  @override
  VerificationContext validateIntegrity(
    Insertable<BlogVocabularyRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('blog_id')) {
      context.handle(
        _blogIdMeta,
        blogId.isAcceptableOrUnknown(data['blog_id']!, _blogIdMeta),
      );
    } else if (isInserting) {
      context.missing(_blogIdMeta);
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('occurrences')) {
      context.handle(
        _occurrencesMeta,
        occurrences.isAcceptableOrUnknown(
          data['occurrences']!,
          _occurrencesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {blogId, entryId};
  @override
  BlogVocabularyRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlogVocabularyRow(
      blogId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blog_id'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
      occurrences: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}occurrences'],
      )!,
    );
  }

  @override
  $BlogVocabularyTable createAlias(String alias) {
    return $BlogVocabularyTable(attachedDatabase, alias);
  }
}

class BlogVocabularyRow extends DataClass
    implements Insertable<BlogVocabularyRow> {
  final String blogId;
  final String entryId;
  final int occurrences;
  const BlogVocabularyRow({
    required this.blogId,
    required this.entryId,
    required this.occurrences,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['blog_id'] = Variable<String>(blogId);
    map['entry_id'] = Variable<String>(entryId);
    map['occurrences'] = Variable<int>(occurrences);
    return map;
  }

  BlogVocabularyCompanion toCompanion(bool nullToAbsent) {
    return BlogVocabularyCompanion(
      blogId: Value(blogId),
      entryId: Value(entryId),
      occurrences: Value(occurrences),
    );
  }

  factory BlogVocabularyRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlogVocabularyRow(
      blogId: serializer.fromJson<String>(json['blogId']),
      entryId: serializer.fromJson<String>(json['entryId']),
      occurrences: serializer.fromJson<int>(json['occurrences']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'blogId': serializer.toJson<String>(blogId),
      'entryId': serializer.toJson<String>(entryId),
      'occurrences': serializer.toJson<int>(occurrences),
    };
  }

  BlogVocabularyRow copyWith({
    String? blogId,
    String? entryId,
    int? occurrences,
  }) => BlogVocabularyRow(
    blogId: blogId ?? this.blogId,
    entryId: entryId ?? this.entryId,
    occurrences: occurrences ?? this.occurrences,
  );
  BlogVocabularyRow copyWithCompanion(BlogVocabularyCompanion data) {
    return BlogVocabularyRow(
      blogId: data.blogId.present ? data.blogId.value : this.blogId,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      occurrences: data.occurrences.present
          ? data.occurrences.value
          : this.occurrences,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlogVocabularyRow(')
          ..write('blogId: $blogId, ')
          ..write('entryId: $entryId, ')
          ..write('occurrences: $occurrences')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(blogId, entryId, occurrences);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlogVocabularyRow &&
          other.blogId == this.blogId &&
          other.entryId == this.entryId &&
          other.occurrences == this.occurrences);
}

class BlogVocabularyCompanion extends UpdateCompanion<BlogVocabularyRow> {
  final Value<String> blogId;
  final Value<String> entryId;
  final Value<int> occurrences;
  final Value<int> rowid;
  const BlogVocabularyCompanion({
    this.blogId = const Value.absent(),
    this.entryId = const Value.absent(),
    this.occurrences = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BlogVocabularyCompanion.insert({
    required String blogId,
    required String entryId,
    this.occurrences = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : blogId = Value(blogId),
       entryId = Value(entryId);
  static Insertable<BlogVocabularyRow> custom({
    Expression<String>? blogId,
    Expression<String>? entryId,
    Expression<int>? occurrences,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (blogId != null) 'blog_id': blogId,
      if (entryId != null) 'entry_id': entryId,
      if (occurrences != null) 'occurrences': occurrences,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BlogVocabularyCompanion copyWith({
    Value<String>? blogId,
    Value<String>? entryId,
    Value<int>? occurrences,
    Value<int>? rowid,
  }) {
    return BlogVocabularyCompanion(
      blogId: blogId ?? this.blogId,
      entryId: entryId ?? this.entryId,
      occurrences: occurrences ?? this.occurrences,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (blogId.present) {
      map['blog_id'] = Variable<String>(blogId.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (occurrences.present) {
      map['occurrences'] = Variable<int>(occurrences.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlogVocabularyCompanion(')
          ..write('blogId: $blogId, ')
          ..write('entryId: $entryId, ')
          ..write('occurrences: $occurrences, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VocabularyEntryRanksTable extends VocabularyEntryRanks
    with TableInfo<$VocabularyEntryRanksTable, VocabularyEntryRankRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabularyEntryRanksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vocabulary_entries (id)',
    ),
  );
  static const VerificationMeta _frequencyRankMeta = const VerificationMeta(
    'frequencyRank',
  );
  @override
  late final GeneratedColumn<int> frequencyRank = GeneratedColumn<int>(
    'frequency_rank',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _generalImportanceMeta = const VerificationMeta(
    'generalImportance',
  );
  @override
  late final GeneratedColumn<int> generalImportance = GeneratedColumn<int>(
    'general_importance',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _spokenRelevanceMeta = const VerificationMeta(
    'spokenRelevance',
  );
  @override
  late final GeneratedColumn<int> spokenRelevance = GeneratedColumn<int>(
    'spoken_relevance',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _newsRelevanceMeta = const VerificationMeta(
    'newsRelevance',
  );
  @override
  late final GeneratedColumn<int> newsRelevance = GeneratedColumn<int>(
    'news_relevance',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _academicRankMeta = const VerificationMeta(
    'academicRank',
  );
  @override
  late final GeneratedColumn<int> academicRank = GeneratedColumn<int>(
    'academic_rank',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    entryId,
    frequencyRank,
    generalImportance,
    spokenRelevance,
    newsRelevance,
    academicRank,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabulary_entry_ranks';
  @override
  VerificationContext validateIntegrity(
    Insertable<VocabularyEntryRankRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('frequency_rank')) {
      context.handle(
        _frequencyRankMeta,
        frequencyRank.isAcceptableOrUnknown(
          data['frequency_rank']!,
          _frequencyRankMeta,
        ),
      );
    }
    if (data.containsKey('general_importance')) {
      context.handle(
        _generalImportanceMeta,
        generalImportance.isAcceptableOrUnknown(
          data['general_importance']!,
          _generalImportanceMeta,
        ),
      );
    }
    if (data.containsKey('spoken_relevance')) {
      context.handle(
        _spokenRelevanceMeta,
        spokenRelevance.isAcceptableOrUnknown(
          data['spoken_relevance']!,
          _spokenRelevanceMeta,
        ),
      );
    }
    if (data.containsKey('news_relevance')) {
      context.handle(
        _newsRelevanceMeta,
        newsRelevance.isAcceptableOrUnknown(
          data['news_relevance']!,
          _newsRelevanceMeta,
        ),
      );
    }
    if (data.containsKey('academic_rank')) {
      context.handle(
        _academicRankMeta,
        academicRank.isAcceptableOrUnknown(
          data['academic_rank']!,
          _academicRankMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entryId};
  @override
  VocabularyEntryRankRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabularyEntryRankRow(
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
      frequencyRank: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frequency_rank'],
      ),
      generalImportance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}general_importance'],
      ),
      spokenRelevance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}spoken_relevance'],
      ),
      newsRelevance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}news_relevance'],
      ),
      academicRank: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}academic_rank'],
      ),
    );
  }

  @override
  $VocabularyEntryRanksTable createAlias(String alias) {
    return $VocabularyEntryRanksTable(attachedDatabase, alias);
  }
}

class VocabularyEntryRankRow extends DataClass
    implements Insertable<VocabularyEntryRankRow> {
  final String entryId;
  final int? frequencyRank;
  final int? generalImportance;
  final int? spokenRelevance;
  final int? newsRelevance;
  final int? academicRank;
  const VocabularyEntryRankRow({
    required this.entryId,
    this.frequencyRank,
    this.generalImportance,
    this.spokenRelevance,
    this.newsRelevance,
    this.academicRank,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entry_id'] = Variable<String>(entryId);
    if (!nullToAbsent || frequencyRank != null) {
      map['frequency_rank'] = Variable<int>(frequencyRank);
    }
    if (!nullToAbsent || generalImportance != null) {
      map['general_importance'] = Variable<int>(generalImportance);
    }
    if (!nullToAbsent || spokenRelevance != null) {
      map['spoken_relevance'] = Variable<int>(spokenRelevance);
    }
    if (!nullToAbsent || newsRelevance != null) {
      map['news_relevance'] = Variable<int>(newsRelevance);
    }
    if (!nullToAbsent || academicRank != null) {
      map['academic_rank'] = Variable<int>(academicRank);
    }
    return map;
  }

  VocabularyEntryRanksCompanion toCompanion(bool nullToAbsent) {
    return VocabularyEntryRanksCompanion(
      entryId: Value(entryId),
      frequencyRank: frequencyRank == null && nullToAbsent
          ? const Value.absent()
          : Value(frequencyRank),
      generalImportance: generalImportance == null && nullToAbsent
          ? const Value.absent()
          : Value(generalImportance),
      spokenRelevance: spokenRelevance == null && nullToAbsent
          ? const Value.absent()
          : Value(spokenRelevance),
      newsRelevance: newsRelevance == null && nullToAbsent
          ? const Value.absent()
          : Value(newsRelevance),
      academicRank: academicRank == null && nullToAbsent
          ? const Value.absent()
          : Value(academicRank),
    );
  }

  factory VocabularyEntryRankRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabularyEntryRankRow(
      entryId: serializer.fromJson<String>(json['entryId']),
      frequencyRank: serializer.fromJson<int?>(json['frequencyRank']),
      generalImportance: serializer.fromJson<int?>(json['generalImportance']),
      spokenRelevance: serializer.fromJson<int?>(json['spokenRelevance']),
      newsRelevance: serializer.fromJson<int?>(json['newsRelevance']),
      academicRank: serializer.fromJson<int?>(json['academicRank']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entryId': serializer.toJson<String>(entryId),
      'frequencyRank': serializer.toJson<int?>(frequencyRank),
      'generalImportance': serializer.toJson<int?>(generalImportance),
      'spokenRelevance': serializer.toJson<int?>(spokenRelevance),
      'newsRelevance': serializer.toJson<int?>(newsRelevance),
      'academicRank': serializer.toJson<int?>(academicRank),
    };
  }

  VocabularyEntryRankRow copyWith({
    String? entryId,
    Value<int?> frequencyRank = const Value.absent(),
    Value<int?> generalImportance = const Value.absent(),
    Value<int?> spokenRelevance = const Value.absent(),
    Value<int?> newsRelevance = const Value.absent(),
    Value<int?> academicRank = const Value.absent(),
  }) => VocabularyEntryRankRow(
    entryId: entryId ?? this.entryId,
    frequencyRank: frequencyRank.present
        ? frequencyRank.value
        : this.frequencyRank,
    generalImportance: generalImportance.present
        ? generalImportance.value
        : this.generalImportance,
    spokenRelevance: spokenRelevance.present
        ? spokenRelevance.value
        : this.spokenRelevance,
    newsRelevance: newsRelevance.present
        ? newsRelevance.value
        : this.newsRelevance,
    academicRank: academicRank.present ? academicRank.value : this.academicRank,
  );
  VocabularyEntryRankRow copyWithCompanion(VocabularyEntryRanksCompanion data) {
    return VocabularyEntryRankRow(
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      frequencyRank: data.frequencyRank.present
          ? data.frequencyRank.value
          : this.frequencyRank,
      generalImportance: data.generalImportance.present
          ? data.generalImportance.value
          : this.generalImportance,
      spokenRelevance: data.spokenRelevance.present
          ? data.spokenRelevance.value
          : this.spokenRelevance,
      newsRelevance: data.newsRelevance.present
          ? data.newsRelevance.value
          : this.newsRelevance,
      academicRank: data.academicRank.present
          ? data.academicRank.value
          : this.academicRank,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyEntryRankRow(')
          ..write('entryId: $entryId, ')
          ..write('frequencyRank: $frequencyRank, ')
          ..write('generalImportance: $generalImportance, ')
          ..write('spokenRelevance: $spokenRelevance, ')
          ..write('newsRelevance: $newsRelevance, ')
          ..write('academicRank: $academicRank')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    entryId,
    frequencyRank,
    generalImportance,
    spokenRelevance,
    newsRelevance,
    academicRank,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabularyEntryRankRow &&
          other.entryId == this.entryId &&
          other.frequencyRank == this.frequencyRank &&
          other.generalImportance == this.generalImportance &&
          other.spokenRelevance == this.spokenRelevance &&
          other.newsRelevance == this.newsRelevance &&
          other.academicRank == this.academicRank);
}

class VocabularyEntryRanksCompanion
    extends UpdateCompanion<VocabularyEntryRankRow> {
  final Value<String> entryId;
  final Value<int?> frequencyRank;
  final Value<int?> generalImportance;
  final Value<int?> spokenRelevance;
  final Value<int?> newsRelevance;
  final Value<int?> academicRank;
  final Value<int> rowid;
  const VocabularyEntryRanksCompanion({
    this.entryId = const Value.absent(),
    this.frequencyRank = const Value.absent(),
    this.generalImportance = const Value.absent(),
    this.spokenRelevance = const Value.absent(),
    this.newsRelevance = const Value.absent(),
    this.academicRank = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VocabularyEntryRanksCompanion.insert({
    required String entryId,
    this.frequencyRank = const Value.absent(),
    this.generalImportance = const Value.absent(),
    this.spokenRelevance = const Value.absent(),
    this.newsRelevance = const Value.absent(),
    this.academicRank = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : entryId = Value(entryId);
  static Insertable<VocabularyEntryRankRow> custom({
    Expression<String>? entryId,
    Expression<int>? frequencyRank,
    Expression<int>? generalImportance,
    Expression<int>? spokenRelevance,
    Expression<int>? newsRelevance,
    Expression<int>? academicRank,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entryId != null) 'entry_id': entryId,
      if (frequencyRank != null) 'frequency_rank': frequencyRank,
      if (generalImportance != null) 'general_importance': generalImportance,
      if (spokenRelevance != null) 'spoken_relevance': spokenRelevance,
      if (newsRelevance != null) 'news_relevance': newsRelevance,
      if (academicRank != null) 'academic_rank': academicRank,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VocabularyEntryRanksCompanion copyWith({
    Value<String>? entryId,
    Value<int?>? frequencyRank,
    Value<int?>? generalImportance,
    Value<int?>? spokenRelevance,
    Value<int?>? newsRelevance,
    Value<int?>? academicRank,
    Value<int>? rowid,
  }) {
    return VocabularyEntryRanksCompanion(
      entryId: entryId ?? this.entryId,
      frequencyRank: frequencyRank ?? this.frequencyRank,
      generalImportance: generalImportance ?? this.generalImportance,
      spokenRelevance: spokenRelevance ?? this.spokenRelevance,
      newsRelevance: newsRelevance ?? this.newsRelevance,
      academicRank: academicRank ?? this.academicRank,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (frequencyRank.present) {
      map['frequency_rank'] = Variable<int>(frequencyRank.value);
    }
    if (generalImportance.present) {
      map['general_importance'] = Variable<int>(generalImportance.value);
    }
    if (spokenRelevance.present) {
      map['spoken_relevance'] = Variable<int>(spokenRelevance.value);
    }
    if (newsRelevance.present) {
      map['news_relevance'] = Variable<int>(newsRelevance.value);
    }
    if (academicRank.present) {
      map['academic_rank'] = Variable<int>(academicRank.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyEntryRanksCompanion(')
          ..write('entryId: $entryId, ')
          ..write('frequencyRank: $frequencyRank, ')
          ..write('generalImportance: $generalImportance, ')
          ..write('spokenRelevance: $spokenRelevance, ')
          ..write('newsRelevance: $newsRelevance, ')
          ..write('academicRank: $academicRank, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TopicGroupsTable extends TopicGroups
    with TableInfo<$TopicGroupsTable, TopicGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
    'name_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, nameEn, nameAr, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topic_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<TopicGroupRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(
        _nameArMeta,
        nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta),
      );
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TopicGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TopicGroupRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ar'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $TopicGroupsTable createAlias(String alias) {
    return $TopicGroupsTable(attachedDatabase, alias);
  }
}

class TopicGroupRow extends DataClass implements Insertable<TopicGroupRow> {
  final String id;
  final String nameEn;
  final String nameAr;
  final int sortOrder;
  const TopicGroupRow({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name_en'] = Variable<String>(nameEn);
    map['name_ar'] = Variable<String>(nameAr);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  TopicGroupsCompanion toCompanion(bool nullToAbsent) {
    return TopicGroupsCompanion(
      id: Value(id),
      nameEn: Value(nameEn),
      nameAr: Value(nameAr),
      sortOrder: Value(sortOrder),
    );
  }

  factory TopicGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TopicGroupRow(
      id: serializer.fromJson<String>(json['id']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameAr': serializer.toJson<String>(nameAr),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  TopicGroupRow copyWith({
    String? id,
    String? nameEn,
    String? nameAr,
    int? sortOrder,
  }) => TopicGroupRow(
    id: id ?? this.id,
    nameEn: nameEn ?? this.nameEn,
    nameAr: nameAr ?? this.nameAr,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  TopicGroupRow copyWithCompanion(TopicGroupsCompanion data) {
    return TopicGroupRow(
      id: data.id.present ? data.id.value : this.id,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TopicGroupRow(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAr: $nameAr, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nameEn, nameAr, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopicGroupRow &&
          other.id == this.id &&
          other.nameEn == this.nameEn &&
          other.nameAr == this.nameAr &&
          other.sortOrder == this.sortOrder);
}

class TopicGroupsCompanion extends UpdateCompanion<TopicGroupRow> {
  final Value<String> id;
  final Value<String> nameEn;
  final Value<String> nameAr;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const TopicGroupsCompanion({
    this.id = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TopicGroupsCompanion.insert({
    required String id,
    required String nameEn,
    required String nameAr,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nameEn = Value(nameEn),
       nameAr = Value(nameAr);
  static Insertable<TopicGroupRow> custom({
    Expression<String>? id,
    Expression<String>? nameEn,
    Expression<String>? nameAr,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nameEn != null) 'name_en': nameEn,
      if (nameAr != null) 'name_ar': nameAr,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TopicGroupsCompanion copyWith({
    Value<String>? id,
    Value<String>? nameEn,
    Value<String>? nameAr,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return TopicGroupsCompanion(
      id: id ?? this.id,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicGroupsCompanion(')
          ..write('id: $id, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAr: $nameAr, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TopicsTable extends Topics with TableInfo<$TopicsTable, TopicRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topic_groups (id)',
    ),
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
    'name_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionEnMeta = const VerificationMeta(
    'descriptionEn',
  );
  @override
  late final GeneratedColumn<String> descriptionEn = GeneratedColumn<String>(
    'description_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionArMeta = const VerificationMeta(
    'descriptionAr',
  );
  @override
  late final GeneratedColumn<String> descriptionAr = GeneratedColumn<String>(
    'description_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconKeyMeta = const VerificationMeta(
    'iconKey',
  );
  @override
  late final GeneratedColumn<String> iconKey = GeneratedColumn<String>(
    'icon_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    groupId,
    nameEn,
    nameAr,
    descriptionEn,
    descriptionAr,
    iconKey,
    sortOrder,
    enabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<TopicRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(
        _nameArMeta,
        nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta),
      );
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('description_en')) {
      context.handle(
        _descriptionEnMeta,
        descriptionEn.isAcceptableOrUnknown(
          data['description_en']!,
          _descriptionEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionEnMeta);
    }
    if (data.containsKey('description_ar')) {
      context.handle(
        _descriptionArMeta,
        descriptionAr.isAcceptableOrUnknown(
          data['description_ar']!,
          _descriptionArMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionArMeta);
    }
    if (data.containsKey('icon_key')) {
      context.handle(
        _iconKeyMeta,
        iconKey.isAcceptableOrUnknown(data['icon_key']!, _iconKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_iconKeyMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TopicRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TopicRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ar'],
      )!,
      descriptionEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_en'],
      )!,
      descriptionAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_ar'],
      )!,
      iconKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_key'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $TopicsTable createAlias(String alias) {
    return $TopicsTable(attachedDatabase, alias);
  }
}

class TopicRow extends DataClass implements Insertable<TopicRow> {
  final String id;
  final String slug;
  final String groupId;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String iconKey;
  final int sortOrder;
  final bool enabled;
  const TopicRow({
    required this.id,
    required this.slug,
    required this.groupId,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.iconKey,
    required this.sortOrder,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['slug'] = Variable<String>(slug);
    map['group_id'] = Variable<String>(groupId);
    map['name_en'] = Variable<String>(nameEn);
    map['name_ar'] = Variable<String>(nameAr);
    map['description_en'] = Variable<String>(descriptionEn);
    map['description_ar'] = Variable<String>(descriptionAr);
    map['icon_key'] = Variable<String>(iconKey);
    map['sort_order'] = Variable<int>(sortOrder);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  TopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicsCompanion(
      id: Value(id),
      slug: Value(slug),
      groupId: Value(groupId),
      nameEn: Value(nameEn),
      nameAr: Value(nameAr),
      descriptionEn: Value(descriptionEn),
      descriptionAr: Value(descriptionAr),
      iconKey: Value(iconKey),
      sortOrder: Value(sortOrder),
      enabled: Value(enabled),
    );
  }

  factory TopicRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TopicRow(
      id: serializer.fromJson<String>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      groupId: serializer.fromJson<String>(json['groupId']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      descriptionEn: serializer.fromJson<String>(json['descriptionEn']),
      descriptionAr: serializer.fromJson<String>(json['descriptionAr']),
      iconKey: serializer.fromJson<String>(json['iconKey']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'slug': serializer.toJson<String>(slug),
      'groupId': serializer.toJson<String>(groupId),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameAr': serializer.toJson<String>(nameAr),
      'descriptionEn': serializer.toJson<String>(descriptionEn),
      'descriptionAr': serializer.toJson<String>(descriptionAr),
      'iconKey': serializer.toJson<String>(iconKey),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  TopicRow copyWith({
    String? id,
    String? slug,
    String? groupId,
    String? nameEn,
    String? nameAr,
    String? descriptionEn,
    String? descriptionAr,
    String? iconKey,
    int? sortOrder,
    bool? enabled,
  }) => TopicRow(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    groupId: groupId ?? this.groupId,
    nameEn: nameEn ?? this.nameEn,
    nameAr: nameAr ?? this.nameAr,
    descriptionEn: descriptionEn ?? this.descriptionEn,
    descriptionAr: descriptionAr ?? this.descriptionAr,
    iconKey: iconKey ?? this.iconKey,
    sortOrder: sortOrder ?? this.sortOrder,
    enabled: enabled ?? this.enabled,
  );
  TopicRow copyWithCompanion(TopicsCompanion data) {
    return TopicRow(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      descriptionEn: data.descriptionEn.present
          ? data.descriptionEn.value
          : this.descriptionEn,
      descriptionAr: data.descriptionAr.present
          ? data.descriptionAr.value
          : this.descriptionAr,
      iconKey: data.iconKey.present ? data.iconKey.value : this.iconKey,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TopicRow(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('groupId: $groupId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAr: $nameAr, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('descriptionAr: $descriptionAr, ')
          ..write('iconKey: $iconKey, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    slug,
    groupId,
    nameEn,
    nameAr,
    descriptionEn,
    descriptionAr,
    iconKey,
    sortOrder,
    enabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopicRow &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.groupId == this.groupId &&
          other.nameEn == this.nameEn &&
          other.nameAr == this.nameAr &&
          other.descriptionEn == this.descriptionEn &&
          other.descriptionAr == this.descriptionAr &&
          other.iconKey == this.iconKey &&
          other.sortOrder == this.sortOrder &&
          other.enabled == this.enabled);
}

class TopicsCompanion extends UpdateCompanion<TopicRow> {
  final Value<String> id;
  final Value<String> slug;
  final Value<String> groupId;
  final Value<String> nameEn;
  final Value<String> nameAr;
  final Value<String> descriptionEn;
  final Value<String> descriptionAr;
  final Value<String> iconKey;
  final Value<int> sortOrder;
  final Value<bool> enabled;
  final Value<int> rowid;
  const TopicsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.groupId = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.descriptionEn = const Value.absent(),
    this.descriptionAr = const Value.absent(),
    this.iconKey = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TopicsCompanion.insert({
    required String id,
    required String slug,
    required String groupId,
    required String nameEn,
    required String nameAr,
    required String descriptionEn,
    required String descriptionAr,
    required String iconKey,
    this.sortOrder = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       slug = Value(slug),
       groupId = Value(groupId),
       nameEn = Value(nameEn),
       nameAr = Value(nameAr),
       descriptionEn = Value(descriptionEn),
       descriptionAr = Value(descriptionAr),
       iconKey = Value(iconKey);
  static Insertable<TopicRow> custom({
    Expression<String>? id,
    Expression<String>? slug,
    Expression<String>? groupId,
    Expression<String>? nameEn,
    Expression<String>? nameAr,
    Expression<String>? descriptionEn,
    Expression<String>? descriptionAr,
    Expression<String>? iconKey,
    Expression<int>? sortOrder,
    Expression<bool>? enabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (groupId != null) 'group_id': groupId,
      if (nameEn != null) 'name_en': nameEn,
      if (nameAr != null) 'name_ar': nameAr,
      if (descriptionEn != null) 'description_en': descriptionEn,
      if (descriptionAr != null) 'description_ar': descriptionAr,
      if (iconKey != null) 'icon_key': iconKey,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (enabled != null) 'enabled': enabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TopicsCompanion copyWith({
    Value<String>? id,
    Value<String>? slug,
    Value<String>? groupId,
    Value<String>? nameEn,
    Value<String>? nameAr,
    Value<String>? descriptionEn,
    Value<String>? descriptionAr,
    Value<String>? iconKey,
    Value<int>? sortOrder,
    Value<bool>? enabled,
    Value<int>? rowid,
  }) {
    return TopicsCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      groupId: groupId ?? this.groupId,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      iconKey: iconKey ?? this.iconKey,
      sortOrder: sortOrder ?? this.sortOrder,
      enabled: enabled ?? this.enabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (descriptionEn.present) {
      map['description_en'] = Variable<String>(descriptionEn.value);
    }
    if (descriptionAr.present) {
      map['description_ar'] = Variable<String>(descriptionAr.value);
    }
    if (iconKey.present) {
      map['icon_key'] = Variable<String>(iconKey.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('groupId: $groupId, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAr: $nameAr, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('descriptionAr: $descriptionAr, ')
          ..write('iconKey: $iconKey, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('enabled: $enabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VocabularyTopicsTable extends VocabularyTopics
    with TableInfo<$VocabularyTopicsTable, VocabularyTopicRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabularyTopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vocabulary_entries (id)',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id)',
    ),
  );
  static const VerificationMeta _relevanceMeta = const VerificationMeta(
    'relevance',
  );
  @override
  late final GeneratedColumn<String> relevance = GeneratedColumn<String>(
    'relevance',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [entryId, topicId, relevance, weight];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabulary_topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<VocabularyTopicRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('relevance')) {
      context.handle(
        _relevanceMeta,
        relevance.isAcceptableOrUnknown(data['relevance']!, _relevanceMeta),
      );
    } else if (isInserting) {
      context.missing(_relevanceMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entryId, topicId};
  @override
  VocabularyTopicRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabularyTopicRow(
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      )!,
      relevance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}relevance'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      )!,
    );
  }

  @override
  $VocabularyTopicsTable createAlias(String alias) {
    return $VocabularyTopicsTable(attachedDatabase, alias);
  }
}

class VocabularyTopicRow extends DataClass
    implements Insertable<VocabularyTopicRow> {
  final String entryId;
  final String topicId;
  final String relevance;
  final int weight;
  const VocabularyTopicRow({
    required this.entryId,
    required this.topicId,
    required this.relevance,
    required this.weight,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entry_id'] = Variable<String>(entryId);
    map['topic_id'] = Variable<String>(topicId);
    map['relevance'] = Variable<String>(relevance);
    map['weight'] = Variable<int>(weight);
    return map;
  }

  VocabularyTopicsCompanion toCompanion(bool nullToAbsent) {
    return VocabularyTopicsCompanion(
      entryId: Value(entryId),
      topicId: Value(topicId),
      relevance: Value(relevance),
      weight: Value(weight),
    );
  }

  factory VocabularyTopicRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabularyTopicRow(
      entryId: serializer.fromJson<String>(json['entryId']),
      topicId: serializer.fromJson<String>(json['topicId']),
      relevance: serializer.fromJson<String>(json['relevance']),
      weight: serializer.fromJson<int>(json['weight']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entryId': serializer.toJson<String>(entryId),
      'topicId': serializer.toJson<String>(topicId),
      'relevance': serializer.toJson<String>(relevance),
      'weight': serializer.toJson<int>(weight),
    };
  }

  VocabularyTopicRow copyWith({
    String? entryId,
    String? topicId,
    String? relevance,
    int? weight,
  }) => VocabularyTopicRow(
    entryId: entryId ?? this.entryId,
    topicId: topicId ?? this.topicId,
    relevance: relevance ?? this.relevance,
    weight: weight ?? this.weight,
  );
  VocabularyTopicRow copyWithCompanion(VocabularyTopicsCompanion data) {
    return VocabularyTopicRow(
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      relevance: data.relevance.present ? data.relevance.value : this.relevance,
      weight: data.weight.present ? data.weight.value : this.weight,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyTopicRow(')
          ..write('entryId: $entryId, ')
          ..write('topicId: $topicId, ')
          ..write('relevance: $relevance, ')
          ..write('weight: $weight')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entryId, topicId, relevance, weight);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabularyTopicRow &&
          other.entryId == this.entryId &&
          other.topicId == this.topicId &&
          other.relevance == this.relevance &&
          other.weight == this.weight);
}

class VocabularyTopicsCompanion extends UpdateCompanion<VocabularyTopicRow> {
  final Value<String> entryId;
  final Value<String> topicId;
  final Value<String> relevance;
  final Value<int> weight;
  final Value<int> rowid;
  const VocabularyTopicsCompanion({
    this.entryId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.relevance = const Value.absent(),
    this.weight = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VocabularyTopicsCompanion.insert({
    required String entryId,
    required String topicId,
    required String relevance,
    required int weight,
    this.rowid = const Value.absent(),
  }) : entryId = Value(entryId),
       topicId = Value(topicId),
       relevance = Value(relevance),
       weight = Value(weight);
  static Insertable<VocabularyTopicRow> custom({
    Expression<String>? entryId,
    Expression<String>? topicId,
    Expression<String>? relevance,
    Expression<int>? weight,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entryId != null) 'entry_id': entryId,
      if (topicId != null) 'topic_id': topicId,
      if (relevance != null) 'relevance': relevance,
      if (weight != null) 'weight': weight,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VocabularyTopicsCompanion copyWith({
    Value<String>? entryId,
    Value<String>? topicId,
    Value<String>? relevance,
    Value<int>? weight,
    Value<int>? rowid,
  }) {
    return VocabularyTopicsCompanion(
      entryId: entryId ?? this.entryId,
      topicId: topicId ?? this.topicId,
      relevance: relevance ?? this.relevance,
      weight: weight ?? this.weight,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (relevance.present) {
      map['relevance'] = Variable<String>(relevance.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyTopicsCompanion(')
          ..write('entryId: $entryId, ')
          ..write('topicId: $topicId, ')
          ..write('relevance: $relevance, ')
          ..write('weight: $weight, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TopicSentencesTable extends TopicSentences
    with TableInfo<$TopicSentencesTable, TopicSentenceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicSentencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sentenceEnMeta = const VerificationMeta(
    'sentenceEn',
  );
  @override
  late final GeneratedColumn<String> sentenceEn = GeneratedColumn<String>(
    'sentence_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sentenceArMeta = const VerificationMeta(
    'sentenceAr',
  );
  @override
  late final GeneratedColumn<String> sentenceAr = GeneratedColumn<String>(
    'sentence_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cefrLevelMeta = const VerificationMeta(
    'cefrLevel',
  );
  @override
  late final GeneratedColumn<String> cefrLevel = GeneratedColumn<String>(
    'cefr_level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sentenceEn,
    sentenceAr,
    cefrLevel,
    sortOrder,
    enabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topic_sentences';
  @override
  VerificationContext validateIntegrity(
    Insertable<TopicSentenceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sentence_en')) {
      context.handle(
        _sentenceEnMeta,
        sentenceEn.isAcceptableOrUnknown(data['sentence_en']!, _sentenceEnMeta),
      );
    } else if (isInserting) {
      context.missing(_sentenceEnMeta);
    }
    if (data.containsKey('sentence_ar')) {
      context.handle(
        _sentenceArMeta,
        sentenceAr.isAcceptableOrUnknown(data['sentence_ar']!, _sentenceArMeta),
      );
    } else if (isInserting) {
      context.missing(_sentenceArMeta);
    }
    if (data.containsKey('cefr_level')) {
      context.handle(
        _cefrLevelMeta,
        cefrLevel.isAcceptableOrUnknown(data['cefr_level']!, _cefrLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_cefrLevelMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TopicSentenceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TopicSentenceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sentenceEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sentence_en'],
      )!,
      sentenceAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sentence_ar'],
      )!,
      cefrLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cefr_level'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $TopicSentencesTable createAlias(String alias) {
    return $TopicSentencesTable(attachedDatabase, alias);
  }
}

class TopicSentenceRow extends DataClass
    implements Insertable<TopicSentenceRow> {
  final String id;
  final String sentenceEn;
  final String sentenceAr;
  final String cefrLevel;
  final int sortOrder;
  final bool enabled;
  const TopicSentenceRow({
    required this.id,
    required this.sentenceEn,
    required this.sentenceAr,
    required this.cefrLevel,
    required this.sortOrder,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sentence_en'] = Variable<String>(sentenceEn);
    map['sentence_ar'] = Variable<String>(sentenceAr);
    map['cefr_level'] = Variable<String>(cefrLevel);
    map['sort_order'] = Variable<int>(sortOrder);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  TopicSentencesCompanion toCompanion(bool nullToAbsent) {
    return TopicSentencesCompanion(
      id: Value(id),
      sentenceEn: Value(sentenceEn),
      sentenceAr: Value(sentenceAr),
      cefrLevel: Value(cefrLevel),
      sortOrder: Value(sortOrder),
      enabled: Value(enabled),
    );
  }

  factory TopicSentenceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TopicSentenceRow(
      id: serializer.fromJson<String>(json['id']),
      sentenceEn: serializer.fromJson<String>(json['sentenceEn']),
      sentenceAr: serializer.fromJson<String>(json['sentenceAr']),
      cefrLevel: serializer.fromJson<String>(json['cefrLevel']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sentenceEn': serializer.toJson<String>(sentenceEn),
      'sentenceAr': serializer.toJson<String>(sentenceAr),
      'cefrLevel': serializer.toJson<String>(cefrLevel),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  TopicSentenceRow copyWith({
    String? id,
    String? sentenceEn,
    String? sentenceAr,
    String? cefrLevel,
    int? sortOrder,
    bool? enabled,
  }) => TopicSentenceRow(
    id: id ?? this.id,
    sentenceEn: sentenceEn ?? this.sentenceEn,
    sentenceAr: sentenceAr ?? this.sentenceAr,
    cefrLevel: cefrLevel ?? this.cefrLevel,
    sortOrder: sortOrder ?? this.sortOrder,
    enabled: enabled ?? this.enabled,
  );
  TopicSentenceRow copyWithCompanion(TopicSentencesCompanion data) {
    return TopicSentenceRow(
      id: data.id.present ? data.id.value : this.id,
      sentenceEn: data.sentenceEn.present
          ? data.sentenceEn.value
          : this.sentenceEn,
      sentenceAr: data.sentenceAr.present
          ? data.sentenceAr.value
          : this.sentenceAr,
      cefrLevel: data.cefrLevel.present ? data.cefrLevel.value : this.cefrLevel,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TopicSentenceRow(')
          ..write('id: $id, ')
          ..write('sentenceEn: $sentenceEn, ')
          ..write('sentenceAr: $sentenceAr, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, sentenceEn, sentenceAr, cefrLevel, sortOrder, enabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopicSentenceRow &&
          other.id == this.id &&
          other.sentenceEn == this.sentenceEn &&
          other.sentenceAr == this.sentenceAr &&
          other.cefrLevel == this.cefrLevel &&
          other.sortOrder == this.sortOrder &&
          other.enabled == this.enabled);
}

class TopicSentencesCompanion extends UpdateCompanion<TopicSentenceRow> {
  final Value<String> id;
  final Value<String> sentenceEn;
  final Value<String> sentenceAr;
  final Value<String> cefrLevel;
  final Value<int> sortOrder;
  final Value<bool> enabled;
  final Value<int> rowid;
  const TopicSentencesCompanion({
    this.id = const Value.absent(),
    this.sentenceEn = const Value.absent(),
    this.sentenceAr = const Value.absent(),
    this.cefrLevel = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TopicSentencesCompanion.insert({
    required String id,
    required String sentenceEn,
    required String sentenceAr,
    required String cefrLevel,
    this.sortOrder = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sentenceEn = Value(sentenceEn),
       sentenceAr = Value(sentenceAr),
       cefrLevel = Value(cefrLevel);
  static Insertable<TopicSentenceRow> custom({
    Expression<String>? id,
    Expression<String>? sentenceEn,
    Expression<String>? sentenceAr,
    Expression<String>? cefrLevel,
    Expression<int>? sortOrder,
    Expression<bool>? enabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sentenceEn != null) 'sentence_en': sentenceEn,
      if (sentenceAr != null) 'sentence_ar': sentenceAr,
      if (cefrLevel != null) 'cefr_level': cefrLevel,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (enabled != null) 'enabled': enabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TopicSentencesCompanion copyWith({
    Value<String>? id,
    Value<String>? sentenceEn,
    Value<String>? sentenceAr,
    Value<String>? cefrLevel,
    Value<int>? sortOrder,
    Value<bool>? enabled,
    Value<int>? rowid,
  }) {
    return TopicSentencesCompanion(
      id: id ?? this.id,
      sentenceEn: sentenceEn ?? this.sentenceEn,
      sentenceAr: sentenceAr ?? this.sentenceAr,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      sortOrder: sortOrder ?? this.sortOrder,
      enabled: enabled ?? this.enabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sentenceEn.present) {
      map['sentence_en'] = Variable<String>(sentenceEn.value);
    }
    if (sentenceAr.present) {
      map['sentence_ar'] = Variable<String>(sentenceAr.value);
    }
    if (cefrLevel.present) {
      map['cefr_level'] = Variable<String>(cefrLevel.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicSentencesCompanion(')
          ..write('id: $id, ')
          ..write('sentenceEn: $sentenceEn, ')
          ..write('sentenceAr: $sentenceAr, ')
          ..write('cefrLevel: $cefrLevel, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('enabled: $enabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TopicSentenceTopicsTable extends TopicSentenceTopics
    with TableInfo<$TopicSentenceTopicsTable, TopicSentenceTopicRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TopicSentenceTopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sentenceIdMeta = const VerificationMeta(
    'sentenceId',
  );
  @override
  late final GeneratedColumn<String> sentenceId = GeneratedColumn<String>(
    'sentence_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topic_sentences (id)',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [sentenceId, topicId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'topic_sentence_topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<TopicSentenceTopicRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('sentence_id')) {
      context.handle(
        _sentenceIdMeta,
        sentenceId.isAcceptableOrUnknown(data['sentence_id']!, _sentenceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sentenceIdMeta);
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sentenceId, topicId};
  @override
  TopicSentenceTopicRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TopicSentenceTopicRow(
      sentenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sentence_id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      )!,
    );
  }

  @override
  $TopicSentenceTopicsTable createAlias(String alias) {
    return $TopicSentenceTopicsTable(attachedDatabase, alias);
  }
}

class TopicSentenceTopicRow extends DataClass
    implements Insertable<TopicSentenceTopicRow> {
  final String sentenceId;
  final String topicId;
  const TopicSentenceTopicRow({
    required this.sentenceId,
    required this.topicId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['sentence_id'] = Variable<String>(sentenceId);
    map['topic_id'] = Variable<String>(topicId);
    return map;
  }

  TopicSentenceTopicsCompanion toCompanion(bool nullToAbsent) {
    return TopicSentenceTopicsCompanion(
      sentenceId: Value(sentenceId),
      topicId: Value(topicId),
    );
  }

  factory TopicSentenceTopicRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TopicSentenceTopicRow(
      sentenceId: serializer.fromJson<String>(json['sentenceId']),
      topicId: serializer.fromJson<String>(json['topicId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sentenceId': serializer.toJson<String>(sentenceId),
      'topicId': serializer.toJson<String>(topicId),
    };
  }

  TopicSentenceTopicRow copyWith({String? sentenceId, String? topicId}) =>
      TopicSentenceTopicRow(
        sentenceId: sentenceId ?? this.sentenceId,
        topicId: topicId ?? this.topicId,
      );
  TopicSentenceTopicRow copyWithCompanion(TopicSentenceTopicsCompanion data) {
    return TopicSentenceTopicRow(
      sentenceId: data.sentenceId.present
          ? data.sentenceId.value
          : this.sentenceId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TopicSentenceTopicRow(')
          ..write('sentenceId: $sentenceId, ')
          ..write('topicId: $topicId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sentenceId, topicId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TopicSentenceTopicRow &&
          other.sentenceId == this.sentenceId &&
          other.topicId == this.topicId);
}

class TopicSentenceTopicsCompanion
    extends UpdateCompanion<TopicSentenceTopicRow> {
  final Value<String> sentenceId;
  final Value<String> topicId;
  final Value<int> rowid;
  const TopicSentenceTopicsCompanion({
    this.sentenceId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TopicSentenceTopicsCompanion.insert({
    required String sentenceId,
    required String topicId,
    this.rowid = const Value.absent(),
  }) : sentenceId = Value(sentenceId),
       topicId = Value(topicId);
  static Insertable<TopicSentenceTopicRow> custom({
    Expression<String>? sentenceId,
    Expression<String>? topicId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sentenceId != null) 'sentence_id': sentenceId,
      if (topicId != null) 'topic_id': topicId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TopicSentenceTopicsCompanion copyWith({
    Value<String>? sentenceId,
    Value<String>? topicId,
    Value<int>? rowid,
  }) {
    return TopicSentenceTopicsCompanion(
      sentenceId: sentenceId ?? this.sentenceId,
      topicId: topicId ?? this.topicId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sentenceId.present) {
      map['sentence_id'] = Variable<String>(sentenceId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TopicSentenceTopicsCompanion(')
          ..write('sentenceId: $sentenceId, ')
          ..write('topicId: $topicId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearningPathsTable extends LearningPaths
    with TableInfo<$LearningPathsTable, LearningPathRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningPathsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
    'name_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameArMeta = const VerificationMeta('nameAr');
  @override
  late final GeneratedColumn<String> nameAr = GeneratedColumn<String>(
    'name_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionEnMeta = const VerificationMeta(
    'descriptionEn',
  );
  @override
  late final GeneratedColumn<String> descriptionEn = GeneratedColumn<String>(
    'description_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionArMeta = const VerificationMeta(
    'descriptionAr',
  );
  @override
  late final GeneratedColumn<String> descriptionAr = GeneratedColumn<String>(
    'description_ar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    nameEn,
    nameAr,
    descriptionEn,
    descriptionAr,
    sortOrder,
    enabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_paths';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningPathRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(
        _nameEnMeta,
        nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta),
      );
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('name_ar')) {
      context.handle(
        _nameArMeta,
        nameAr.isAcceptableOrUnknown(data['name_ar']!, _nameArMeta),
      );
    } else if (isInserting) {
      context.missing(_nameArMeta);
    }
    if (data.containsKey('description_en')) {
      context.handle(
        _descriptionEnMeta,
        descriptionEn.isAcceptableOrUnknown(
          data['description_en']!,
          _descriptionEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionEnMeta);
    }
    if (data.containsKey('description_ar')) {
      context.handle(
        _descriptionArMeta,
        descriptionAr.isAcceptableOrUnknown(
          data['description_ar']!,
          _descriptionArMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionArMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningPathRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningPathRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      nameEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_en'],
      )!,
      nameAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_ar'],
      )!,
      descriptionEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_en'],
      )!,
      descriptionAr: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_ar'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
    );
  }

  @override
  $LearningPathsTable createAlias(String alias) {
    return $LearningPathsTable(attachedDatabase, alias);
  }
}

class LearningPathRow extends DataClass implements Insertable<LearningPathRow> {
  final String id;
  final String slug;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final int sortOrder;
  final bool enabled;
  const LearningPathRow({
    required this.id,
    required this.slug,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.sortOrder,
    required this.enabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['slug'] = Variable<String>(slug);
    map['name_en'] = Variable<String>(nameEn);
    map['name_ar'] = Variable<String>(nameAr);
    map['description_en'] = Variable<String>(descriptionEn);
    map['description_ar'] = Variable<String>(descriptionAr);
    map['sort_order'] = Variable<int>(sortOrder);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  LearningPathsCompanion toCompanion(bool nullToAbsent) {
    return LearningPathsCompanion(
      id: Value(id),
      slug: Value(slug),
      nameEn: Value(nameEn),
      nameAr: Value(nameAr),
      descriptionEn: Value(descriptionEn),
      descriptionAr: Value(descriptionAr),
      sortOrder: Value(sortOrder),
      enabled: Value(enabled),
    );
  }

  factory LearningPathRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningPathRow(
      id: serializer.fromJson<String>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      nameAr: serializer.fromJson<String>(json['nameAr']),
      descriptionEn: serializer.fromJson<String>(json['descriptionEn']),
      descriptionAr: serializer.fromJson<String>(json['descriptionAr']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'slug': serializer.toJson<String>(slug),
      'nameEn': serializer.toJson<String>(nameEn),
      'nameAr': serializer.toJson<String>(nameAr),
      'descriptionEn': serializer.toJson<String>(descriptionEn),
      'descriptionAr': serializer.toJson<String>(descriptionAr),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  LearningPathRow copyWith({
    String? id,
    String? slug,
    String? nameEn,
    String? nameAr,
    String? descriptionEn,
    String? descriptionAr,
    int? sortOrder,
    bool? enabled,
  }) => LearningPathRow(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    nameEn: nameEn ?? this.nameEn,
    nameAr: nameAr ?? this.nameAr,
    descriptionEn: descriptionEn ?? this.descriptionEn,
    descriptionAr: descriptionAr ?? this.descriptionAr,
    sortOrder: sortOrder ?? this.sortOrder,
    enabled: enabled ?? this.enabled,
  );
  LearningPathRow copyWithCompanion(LearningPathsCompanion data) {
    return LearningPathRow(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      nameAr: data.nameAr.present ? data.nameAr.value : this.nameAr,
      descriptionEn: data.descriptionEn.present
          ? data.descriptionEn.value
          : this.descriptionEn,
      descriptionAr: data.descriptionAr.present
          ? data.descriptionAr.value
          : this.descriptionAr,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningPathRow(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAr: $nameAr, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('descriptionAr: $descriptionAr, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    slug,
    nameEn,
    nameAr,
    descriptionEn,
    descriptionAr,
    sortOrder,
    enabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningPathRow &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.nameEn == this.nameEn &&
          other.nameAr == this.nameAr &&
          other.descriptionEn == this.descriptionEn &&
          other.descriptionAr == this.descriptionAr &&
          other.sortOrder == this.sortOrder &&
          other.enabled == this.enabled);
}

class LearningPathsCompanion extends UpdateCompanion<LearningPathRow> {
  final Value<String> id;
  final Value<String> slug;
  final Value<String> nameEn;
  final Value<String> nameAr;
  final Value<String> descriptionEn;
  final Value<String> descriptionAr;
  final Value<int> sortOrder;
  final Value<bool> enabled;
  final Value<int> rowid;
  const LearningPathsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.nameAr = const Value.absent(),
    this.descriptionEn = const Value.absent(),
    this.descriptionAr = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearningPathsCompanion.insert({
    required String id,
    required String slug,
    required String nameEn,
    required String nameAr,
    required String descriptionEn,
    required String descriptionAr,
    this.sortOrder = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       slug = Value(slug),
       nameEn = Value(nameEn),
       nameAr = Value(nameAr),
       descriptionEn = Value(descriptionEn),
       descriptionAr = Value(descriptionAr);
  static Insertable<LearningPathRow> custom({
    Expression<String>? id,
    Expression<String>? slug,
    Expression<String>? nameEn,
    Expression<String>? nameAr,
    Expression<String>? descriptionEn,
    Expression<String>? descriptionAr,
    Expression<int>? sortOrder,
    Expression<bool>? enabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (nameEn != null) 'name_en': nameEn,
      if (nameAr != null) 'name_ar': nameAr,
      if (descriptionEn != null) 'description_en': descriptionEn,
      if (descriptionAr != null) 'description_ar': descriptionAr,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (enabled != null) 'enabled': enabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearningPathsCompanion copyWith({
    Value<String>? id,
    Value<String>? slug,
    Value<String>? nameEn,
    Value<String>? nameAr,
    Value<String>? descriptionEn,
    Value<String>? descriptionAr,
    Value<int>? sortOrder,
    Value<bool>? enabled,
    Value<int>? rowid,
  }) {
    return LearningPathsCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      sortOrder: sortOrder ?? this.sortOrder,
      enabled: enabled ?? this.enabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (nameAr.present) {
      map['name_ar'] = Variable<String>(nameAr.value);
    }
    if (descriptionEn.present) {
      map['description_en'] = Variable<String>(descriptionEn.value);
    }
    if (descriptionAr.present) {
      map['description_ar'] = Variable<String>(descriptionAr.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningPathsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('nameEn: $nameEn, ')
          ..write('nameAr: $nameAr, ')
          ..write('descriptionEn: $descriptionEn, ')
          ..write('descriptionAr: $descriptionAr, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('enabled: $enabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearningPathTopicsTable extends LearningPathTopics
    with TableInfo<$LearningPathTopicsTable, LearningPathTopicRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningPathTopicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _pathIdMeta = const VerificationMeta('pathId');
  @override
  late final GeneratedColumn<String> pathId = GeneratedColumn<String>(
    'path_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES learning_paths (id)',
    ),
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES topics (id)',
    ),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [pathId, topicId, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_path_topics';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningPathTopicRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('path_id')) {
      context.handle(
        _pathIdMeta,
        pathId.isAcceptableOrUnknown(data['path_id']!, _pathIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pathIdMeta);
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pathId, topicId};
  @override
  LearningPathTopicRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningPathTopicRow(
      pathId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path_id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $LearningPathTopicsTable createAlias(String alias) {
    return $LearningPathTopicsTable(attachedDatabase, alias);
  }
}

class LearningPathTopicRow extends DataClass
    implements Insertable<LearningPathTopicRow> {
  final String pathId;
  final String topicId;
  final int sortOrder;
  const LearningPathTopicRow({
    required this.pathId,
    required this.topicId,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['path_id'] = Variable<String>(pathId);
    map['topic_id'] = Variable<String>(topicId);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  LearningPathTopicsCompanion toCompanion(bool nullToAbsent) {
    return LearningPathTopicsCompanion(
      pathId: Value(pathId),
      topicId: Value(topicId),
      sortOrder: Value(sortOrder),
    );
  }

  factory LearningPathTopicRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningPathTopicRow(
      pathId: serializer.fromJson<String>(json['pathId']),
      topicId: serializer.fromJson<String>(json['topicId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pathId': serializer.toJson<String>(pathId),
      'topicId': serializer.toJson<String>(topicId),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  LearningPathTopicRow copyWith({
    String? pathId,
    String? topicId,
    int? sortOrder,
  }) => LearningPathTopicRow(
    pathId: pathId ?? this.pathId,
    topicId: topicId ?? this.topicId,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  LearningPathTopicRow copyWithCompanion(LearningPathTopicsCompanion data) {
    return LearningPathTopicRow(
      pathId: data.pathId.present ? data.pathId.value : this.pathId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningPathTopicRow(')
          ..write('pathId: $pathId, ')
          ..write('topicId: $topicId, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pathId, topicId, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningPathTopicRow &&
          other.pathId == this.pathId &&
          other.topicId == this.topicId &&
          other.sortOrder == this.sortOrder);
}

class LearningPathTopicsCompanion
    extends UpdateCompanion<LearningPathTopicRow> {
  final Value<String> pathId;
  final Value<String> topicId;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const LearningPathTopicsCompanion({
    this.pathId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearningPathTopicsCompanion.insert({
    required String pathId,
    required String topicId,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : pathId = Value(pathId),
       topicId = Value(topicId);
  static Insertable<LearningPathTopicRow> custom({
    Expression<String>? pathId,
    Expression<String>? topicId,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pathId != null) 'path_id': pathId,
      if (topicId != null) 'topic_id': topicId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearningPathTopicsCompanion copyWith({
    Value<String>? pathId,
    Value<String>? topicId,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return LearningPathTopicsCompanion(
      pathId: pathId ?? this.pathId,
      topicId: topicId ?? this.topicId,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pathId.present) {
      map['path_id'] = Variable<String>(pathId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningPathTopicsCompanion(')
          ..write('pathId: $pathId, ')
          ..write('topicId: $topicId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $WordsTable words = $WordsTable(this);
  late final $SentencePatternsTable sentencePatterns = $SentencePatternsTable(
    this,
  );
  late final $SentencesTable sentences = $SentencesTable(this);
  late final $WordCategoriesTable wordCategories = $WordCategoriesTable(this);
  late final $SentenceCategoriesTable sentenceCategories =
      $SentenceCategoriesTable(this);
  late final $PatternCategoriesTable patternCategories =
      $PatternCategoriesTable(this);
  late final $SentenceWordsTable sentenceWords = $SentenceWordsTable(this);
  late final $ReviewItemsTable reviewItems = $ReviewItemsTable(this);
  late final $ReviewHistoryTable reviewHistory = $ReviewHistoryTable(this);
  late final $PronunciationCacheTable pronunciationCache =
      $PronunciationCacheTable(this);
  late final $LearningSessionsTable learningSessions = $LearningSessionsTable(
    this,
  );
  late final $UserPreferencesTable userPreferences = $UserPreferencesTable(
    this,
  );
  late final $AppStatisticsTable appStatistics = $AppStatisticsTable(this);
  late final $VocabularyEntriesTable vocabularyEntries =
      $VocabularyEntriesTable(this);
  late final $VocabularyFormsTable vocabularyForms = $VocabularyFormsTable(
    this,
  );
  late final $UserVocabularyTable userVocabulary = $UserVocabularyTable(this);
  late final $BlogEntriesTable blogEntries = $BlogEntriesTable(this);
  late final $BlogVocabularyTable blogVocabulary = $BlogVocabularyTable(this);
  late final $VocabularyEntryRanksTable vocabularyEntryRanks =
      $VocabularyEntryRanksTable(this);
  late final $TopicGroupsTable topicGroups = $TopicGroupsTable(this);
  late final $TopicsTable topics = $TopicsTable(this);
  late final $VocabularyTopicsTable vocabularyTopics = $VocabularyTopicsTable(
    this,
  );
  late final $TopicSentencesTable topicSentences = $TopicSentencesTable(this);
  late final $TopicSentenceTopicsTable topicSentenceTopics =
      $TopicSentenceTopicsTable(this);
  late final $LearningPathsTable learningPaths = $LearningPathsTable(this);
  late final $LearningPathTopicsTable learningPathTopics =
      $LearningPathTopicsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categories,
    words,
    sentencePatterns,
    sentences,
    wordCategories,
    sentenceCategories,
    patternCategories,
    sentenceWords,
    reviewItems,
    reviewHistory,
    pronunciationCache,
    learningSessions,
    userPreferences,
    appStatistics,
    vocabularyEntries,
    vocabularyForms,
    userVocabulary,
    blogEntries,
    blogVocabulary,
    vocabularyEntryRanks,
    topicGroups,
    topics,
    vocabularyTopics,
    topicSentences,
    topicSentenceTopics,
    learningPaths,
    learningPathTopics,
  ];
}

typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String id,
  required String name,
  Value<String?> nameAr,
  Value<String> iconName,
  Value<int> sortOrder,
  Value<bool> isSystem,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> nameAr,
  Value<String> iconName,
  Value<int> sortOrder,
  Value<bool> isSystem,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, CategoryRow> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WordCategoriesTable, List<WordCategoryRow>>
  _wordCategoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wordCategories,
    aliasName: 'categories__id__word_categories__category_id',
  );

  $$WordCategoriesTableProcessedTableManager get wordCategoriesRefs {
    final manager = $$WordCategoriesTableTableManager(
      $_db,
      $_db.wordCategories,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordCategoriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SentenceCategoriesTable,
    List<SentenceCategoryRow>
  >
  _sentenceCategoriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sentenceCategories,
        aliasName: 'categories__id__sentence_categories__category_id',
      );

  $$SentenceCategoriesTableProcessedTableManager get sentenceCategoriesRefs {
    final manager = $$SentenceCategoriesTableTableManager(
      $_db,
      $_db.sentenceCategories,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sentenceCategoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PatternCategoriesTable, List<PatternCategoryRow>>
  _patternCategoriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.patternCategories,
        aliasName: 'categories__id__pattern_categories__category_id',
      );

  $$PatternCategoriesTableProcessedTableManager get patternCategoriesRefs {
    final manager = $$PatternCategoriesTableTableManager(
      $_db,
      $_db.patternCategories,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _patternCategoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wordCategoriesRefs(
    Expression<bool> Function($$WordCategoriesTableFilterComposer f) f,
  ) {
    final $$WordCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordCategories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.wordCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sentenceCategoriesRefs(
    Expression<bool> Function($$SentenceCategoriesTableFilterComposer f) f,
  ) {
    final $$SentenceCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sentenceCategories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentenceCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.sentenceCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> patternCategoriesRefs(
    Expression<bool> Function($$PatternCategoriesTableFilterComposer f) f,
  ) {
    final $$PatternCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.patternCategories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatternCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.patternCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> wordCategoriesRefs<T extends Object>(
    Expression<T> Function($$WordCategoriesTableAnnotationComposer a) f,
  ) {
    final $$WordCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordCategories,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.wordCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sentenceCategoriesRefs<T extends Object>(
    Expression<T> Function($$SentenceCategoriesTableAnnotationComposer a) f,
  ) {
    final $$SentenceCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sentenceCategories,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SentenceCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.sentenceCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> patternCategoriesRefs<T extends Object>(
    Expression<T> Function($$PatternCategoriesTableAnnotationComposer a) f,
  ) {
    final $$PatternCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.patternCategories,
          getReferencedColumn: (t) => t.categoryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PatternCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.patternCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          CategoryRow,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (CategoryRow, $$CategoriesTableReferences),
          CategoryRow,
          PrefetchHooks Function({
            bool wordCategoriesRefs,
            bool sentenceCategoriesRefs,
            bool patternCategoriesRefs,
          })
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> nameAr = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                nameAr: nameAr,
                iconName: iconName,
                sortOrder: sortOrder,
                isSystem: isSystem,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> nameAr = const Value.absent(),
                Value<String> iconName = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                nameAr: nameAr,
                iconName: iconName,
                sortOrder: sortOrder,
                isSystem: isSystem,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, CategoryRow>(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                wordCategoriesRefs = false,
                sentenceCategoriesRefs = false,
                patternCategoriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (wordCategoriesRefs) db.wordCategories,
                    if (sentenceCategoriesRefs) db.sentenceCategories,
                    if (patternCategoriesRefs) db.patternCategories,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (wordCategoriesRefs)
                        await $_getPrefetchedData<
                          CategoryRow,
                          $CategoriesTable,
                          WordCategoryRow
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._wordCategoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).wordCategoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sentenceCategoriesRefs)
                        await $_getPrefetchedData<
                          CategoryRow,
                          $CategoriesTable,
                          SentenceCategoryRow
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._sentenceCategoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).sentenceCategoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (patternCategoriesRefs)
                        await $_getPrefetchedData<
                          CategoryRow,
                          $CategoriesTable,
                          PatternCategoryRow
                        >(
                          currentTable: table,
                          referencedTable: $$CategoriesTableReferences
                              ._patternCategoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoriesTableReferences(
                                db,
                                table,
                                p0,
                              ).patternCategoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
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

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      CategoryRow,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (CategoryRow, $$CategoriesTableReferences),
      CategoryRow,
      PrefetchHooks Function({
        bool wordCategoriesRefs,
        bool sentenceCategoriesRefs,
        bool patternCategoriesRefs,
      })
    >;
typedef $$WordsTableCreateCompanionBuilder = WordsCompanion Function({
  required String id,
  required String word,
  required String arabicMeaning,
  required String cefrLevel,
  required String partOfSpeech,
  Value<String?> phonetic,
  Value<String?> notes,
  Value<String?> exampleSentence,
  Value<String?> exampleTranslation,
  Value<bool> isFavorite,
  Value<bool> inReviewSystem,
  Value<String> masteryStatus,
  Value<int> reviewCount,
  Value<DateTime?> lastReviewedAt,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$WordsTableUpdateCompanionBuilder = WordsCompanion Function({
  Value<String> id,
  Value<String> word,
  Value<String> arabicMeaning,
  Value<String> cefrLevel,
  Value<String> partOfSpeech,
  Value<String?> phonetic,
  Value<String?> notes,
  Value<String?> exampleSentence,
  Value<String?> exampleTranslation,
  Value<bool> isFavorite,
  Value<bool> inReviewSystem,
  Value<String> masteryStatus,
  Value<int> reviewCount,
  Value<DateTime?> lastReviewedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$WordsTableReferences
    extends BaseReferences<_$AppDatabase, $WordsTable, WordRow> {
  $$WordsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WordCategoriesTable, List<WordCategoryRow>>
  _wordCategoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wordCategories,
    aliasName: 'words__id__word_categories__word_id',
  );

  $$WordCategoriesTableProcessedTableManager get wordCategoriesRefs {
    final manager = $$WordCategoriesTableTableManager(
      $_db,
      $_db.wordCategories,
    ).filter((f) => f.wordId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_wordCategoriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SentenceWordsTable, List<SentenceWordRow>>
  _sentenceWordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sentenceWords,
    aliasName: 'words__id__sentence_words__word_id',
  );

  $$SentenceWordsTableProcessedTableManager get sentenceWordsRefs {
    final manager = $$SentenceWordsTableTableManager(
      $_db,
      $_db.sentenceWords,
    ).filter((f) => f.wordId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sentenceWordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WordsTableFilterComposer extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arabicMeaning => $composableBuilder(
    column: $table.arabicMeaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phonetic => $composableBuilder(
    column: $table.phonetic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exampleSentence => $composableBuilder(
    column: $table.exampleSentence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exampleTranslation => $composableBuilder(
    column: $table.exampleTranslation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get inReviewSystem => $composableBuilder(
    column: $table.inReviewSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> wordCategoriesRefs(
    Expression<bool> Function($$WordCategoriesTableFilterComposer f) f,
  ) {
    final $$WordCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordCategories,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.wordCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sentenceWordsRefs(
    Expression<bool> Function($$SentenceWordsTableFilterComposer f) f,
  ) {
    final $$SentenceWordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sentenceWords,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentenceWordsTableFilterComposer(
            $db: $db,
            $table: $db.sentenceWords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordsTableOrderingComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get word => $composableBuilder(
    column: $table.word,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arabicMeaning => $composableBuilder(
    column: $table.arabicMeaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phonetic => $composableBuilder(
    column: $table.phonetic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exampleSentence => $composableBuilder(
    column: $table.exampleSentence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exampleTranslation => $composableBuilder(
    column: $table.exampleTranslation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get inReviewSystem => $composableBuilder(
    column: $table.inReviewSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordsTable> {
  $$WordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get arabicMeaning => $composableBuilder(
    column: $table.arabicMeaning,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cefrLevel =>
      $composableBuilder(column: $table.cefrLevel, builder: (column) => column);

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phonetic =>
      $composableBuilder(column: $table.phonetic, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get exampleSentence => $composableBuilder(
    column: $table.exampleSentence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exampleTranslation => $composableBuilder(
    column: $table.exampleTranslation,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get inReviewSystem => $composableBuilder(
    column: $table.inReviewSystem,
    builder: (column) => column,
  );

  GeneratedColumn<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> wordCategoriesRefs<T extends Object>(
    Expression<T> Function($$WordCategoriesTableAnnotationComposer a) f,
  ) {
    final $$WordCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wordCategories,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.wordCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sentenceWordsRefs<T extends Object>(
    Expression<T> Function($$SentenceWordsTableAnnotationComposer a) f,
  ) {
    final $$SentenceWordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sentenceWords,
      getReferencedColumn: (t) => t.wordId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentenceWordsTableAnnotationComposer(
            $db: $db,
            $table: $db.sentenceWords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordsTable,
          WordRow,
          $$WordsTableFilterComposer,
          $$WordsTableOrderingComposer,
          $$WordsTableAnnotationComposer,
          $$WordsTableCreateCompanionBuilder,
          $$WordsTableUpdateCompanionBuilder,
          (WordRow, $$WordsTableReferences),
          WordRow,
          PrefetchHooks Function({
            bool wordCategoriesRefs,
            bool sentenceWordsRefs,
          })
        > {
  $$WordsTableTableManager(_$AppDatabase db, $WordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> word = const Value.absent(),
                Value<String> arabicMeaning = const Value.absent(),
                Value<String> cefrLevel = const Value.absent(),
                Value<String> partOfSpeech = const Value.absent(),
                Value<String?> phonetic = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> exampleSentence = const Value.absent(),
                Value<String?> exampleTranslation = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> inReviewSystem = const Value.absent(),
                Value<String> masteryStatus = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordsCompanion(
                id: id,
                word: word,
                arabicMeaning: arabicMeaning,
                cefrLevel: cefrLevel,
                partOfSpeech: partOfSpeech,
                phonetic: phonetic,
                notes: notes,
                exampleSentence: exampleSentence,
                exampleTranslation: exampleTranslation,
                isFavorite: isFavorite,
                inReviewSystem: inReviewSystem,
                masteryStatus: masteryStatus,
                reviewCount: reviewCount,
                lastReviewedAt: lastReviewedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String word,
                required String arabicMeaning,
                required String cefrLevel,
                required String partOfSpeech,
                Value<String?> phonetic = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> exampleSentence = const Value.absent(),
                Value<String?> exampleTranslation = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> inReviewSystem = const Value.absent(),
                Value<String> masteryStatus = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WordsCompanion.insert(
                id: id,
                word: word,
                arabicMeaning: arabicMeaning,
                cefrLevel: cefrLevel,
                partOfSpeech: partOfSpeech,
                phonetic: phonetic,
                notes: notes,
                exampleSentence: exampleSentence,
                exampleTranslation: exampleTranslation,
                isFavorite: isFavorite,
                inReviewSystem: inReviewSystem,
                masteryStatus: masteryStatus,
                reviewCount: reviewCount,
                lastReviewedAt: lastReviewedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WordsTable, WordRow>(table),
                  $$WordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({wordCategoriesRefs = false, sentenceWordsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (wordCategoriesRefs) db.wordCategories,
                    if (sentenceWordsRefs) db.sentenceWords,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (wordCategoriesRefs)
                        await $_getPrefetchedData<
                          WordRow,
                          $WordsTable,
                          WordCategoryRow
                        >(
                          currentTable: table,
                          referencedTable: $$WordsTableReferences
                              ._wordCategoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WordsTableReferences(
                                db,
                                table,
                                p0,
                              ).wordCategoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wordId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sentenceWordsRefs)
                        await $_getPrefetchedData<
                          WordRow,
                          $WordsTable,
                          SentenceWordRow
                        >(
                          currentTable: table,
                          referencedTable: $$WordsTableReferences
                              ._sentenceWordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WordsTableReferences(
                                db,
                                table,
                                p0,
                              ).sentenceWordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wordId == item.id,
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

typedef $$WordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordsTable,
      WordRow,
      $$WordsTableFilterComposer,
      $$WordsTableOrderingComposer,
      $$WordsTableAnnotationComposer,
      $$WordsTableCreateCompanionBuilder,
      $$WordsTableUpdateCompanionBuilder,
      (WordRow, $$WordsTableReferences),
      WordRow,
      PrefetchHooks Function({bool wordCategoriesRefs, bool sentenceWordsRefs})
    >;
typedef $$SentencePatternsTableCreateCompanionBuilder =
    SentencePatternsCompanion Function({
      required String id,
      required String pattern,
      required String arabicExplanation,
      required String cefrLevel,
      Value<String?> grammarNotes,
      Value<bool> isFavorite,
      Value<bool> inReviewSystem,
      Value<String> masteryStatus,
      Value<int> reviewCount,
      Value<DateTime?> lastReviewedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SentencePatternsTableUpdateCompanionBuilder =
    SentencePatternsCompanion Function({
      Value<String> id,
      Value<String> pattern,
      Value<String> arabicExplanation,
      Value<String> cefrLevel,
      Value<String?> grammarNotes,
      Value<bool> isFavorite,
      Value<bool> inReviewSystem,
      Value<String> masteryStatus,
      Value<int> reviewCount,
      Value<DateTime?> lastReviewedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$SentencePatternsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SentencePatternsTable,
          SentencePatternRow
        > {
  $$SentencePatternsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SentencesTable, List<SentenceRow>>
  _sentencesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sentences,
    aliasName: 'sentence_patterns__id__sentences__pattern_id',
  );

  $$SentencesTableProcessedTableManager get sentencesRefs {
    final manager = $$SentencesTableTableManager(
      $_db,
      $_db.sentences,
    ).filter((f) => f.patternId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sentencesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PatternCategoriesTable, List<PatternCategoryRow>>
  _patternCategoriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.patternCategories,
        aliasName: 'sentence_patterns__id__pattern_categories__pattern_id',
      );

  $$PatternCategoriesTableProcessedTableManager get patternCategoriesRefs {
    final manager = $$PatternCategoriesTableTableManager(
      $_db,
      $_db.patternCategories,
    ).filter((f) => f.patternId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _patternCategoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SentencePatternsTableFilterComposer
    extends Composer<_$AppDatabase, $SentencePatternsTable> {
  $$SentencePatternsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arabicExplanation => $composableBuilder(
    column: $table.arabicExplanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grammarNotes => $composableBuilder(
    column: $table.grammarNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get inReviewSystem => $composableBuilder(
    column: $table.inReviewSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sentencesRefs(
    Expression<bool> Function($$SentencesTableFilterComposer f) f,
  ) {
    final $$SentencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sentences,
      getReferencedColumn: (t) => t.patternId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencesTableFilterComposer(
            $db: $db,
            $table: $db.sentences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> patternCategoriesRefs(
    Expression<bool> Function($$PatternCategoriesTableFilterComposer f) f,
  ) {
    final $$PatternCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.patternCategories,
      getReferencedColumn: (t) => t.patternId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatternCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.patternCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SentencePatternsTableOrderingComposer
    extends Composer<_$AppDatabase, $SentencePatternsTable> {
  $$SentencePatternsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arabicExplanation => $composableBuilder(
    column: $table.arabicExplanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grammarNotes => $composableBuilder(
    column: $table.grammarNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get inReviewSystem => $composableBuilder(
    column: $table.inReviewSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SentencePatternsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SentencePatternsTable> {
  $$SentencePatternsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pattern =>
      $composableBuilder(column: $table.pattern, builder: (column) => column);

  GeneratedColumn<String> get arabicExplanation => $composableBuilder(
    column: $table.arabicExplanation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cefrLevel =>
      $composableBuilder(column: $table.cefrLevel, builder: (column) => column);

  GeneratedColumn<String> get grammarNotes => $composableBuilder(
    column: $table.grammarNotes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get inReviewSystem => $composableBuilder(
    column: $table.inReviewSystem,
    builder: (column) => column,
  );

  GeneratedColumn<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> sentencesRefs<T extends Object>(
    Expression<T> Function($$SentencesTableAnnotationComposer a) f,
  ) {
    final $$SentencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sentences,
      getReferencedColumn: (t) => t.patternId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencesTableAnnotationComposer(
            $db: $db,
            $table: $db.sentences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> patternCategoriesRefs<T extends Object>(
    Expression<T> Function($$PatternCategoriesTableAnnotationComposer a) f,
  ) {
    final $$PatternCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.patternCategories,
          getReferencedColumn: (t) => t.patternId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PatternCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.patternCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SentencePatternsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SentencePatternsTable,
          SentencePatternRow,
          $$SentencePatternsTableFilterComposer,
          $$SentencePatternsTableOrderingComposer,
          $$SentencePatternsTableAnnotationComposer,
          $$SentencePatternsTableCreateCompanionBuilder,
          $$SentencePatternsTableUpdateCompanionBuilder,
          (SentencePatternRow, $$SentencePatternsTableReferences),
          SentencePatternRow,
          PrefetchHooks Function({
            bool sentencesRefs,
            bool patternCategoriesRefs,
          })
        > {
  $$SentencePatternsTableTableManager(
    _$AppDatabase db,
    $SentencePatternsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SentencePatternsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SentencePatternsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SentencePatternsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> pattern = const Value.absent(),
                Value<String> arabicExplanation = const Value.absent(),
                Value<String> cefrLevel = const Value.absent(),
                Value<String?> grammarNotes = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> inReviewSystem = const Value.absent(),
                Value<String> masteryStatus = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SentencePatternsCompanion(
                id: id,
                pattern: pattern,
                arabicExplanation: arabicExplanation,
                cefrLevel: cefrLevel,
                grammarNotes: grammarNotes,
                isFavorite: isFavorite,
                inReviewSystem: inReviewSystem,
                masteryStatus: masteryStatus,
                reviewCount: reviewCount,
                lastReviewedAt: lastReviewedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pattern,
                required String arabicExplanation,
                required String cefrLevel,
                Value<String?> grammarNotes = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> inReviewSystem = const Value.absent(),
                Value<String> masteryStatus = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SentencePatternsCompanion.insert(
                id: id,
                pattern: pattern,
                arabicExplanation: arabicExplanation,
                cefrLevel: cefrLevel,
                grammarNotes: grammarNotes,
                isFavorite: isFavorite,
                inReviewSystem: inReviewSystem,
                masteryStatus: masteryStatus,
                reviewCount: reviewCount,
                lastReviewedAt: lastReviewedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SentencePatternsTable, SentencePatternRow>(
                    table,
                  ),
                  $$SentencePatternsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({sentencesRefs = false, patternCategoriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sentencesRefs) db.sentences,
                    if (patternCategoriesRefs) db.patternCategories,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sentencesRefs)
                        await $_getPrefetchedData<
                          SentencePatternRow,
                          $SentencePatternsTable,
                          SentenceRow
                        >(
                          currentTable: table,
                          referencedTable: $$SentencePatternsTableReferences
                              ._sentencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SentencePatternsTableReferences(
                                db,
                                table,
                                p0,
                              ).sentencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.patternId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (patternCategoriesRefs)
                        await $_getPrefetchedData<
                          SentencePatternRow,
                          $SentencePatternsTable,
                          PatternCategoryRow
                        >(
                          currentTable: table,
                          referencedTable: $$SentencePatternsTableReferences
                              ._patternCategoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SentencePatternsTableReferences(
                                db,
                                table,
                                p0,
                              ).patternCategoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.patternId == item.id,
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

typedef $$SentencePatternsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SentencePatternsTable,
      SentencePatternRow,
      $$SentencePatternsTableFilterComposer,
      $$SentencePatternsTableOrderingComposer,
      $$SentencePatternsTableAnnotationComposer,
      $$SentencePatternsTableCreateCompanionBuilder,
      $$SentencePatternsTableUpdateCompanionBuilder,
      (SentencePatternRow, $$SentencePatternsTableReferences),
      SentencePatternRow,
      PrefetchHooks Function({bool sentencesRefs, bool patternCategoriesRefs})
    >;
typedef $$SentencesTableCreateCompanionBuilder = SentencesCompanion Function({
  required String id,
  required String sentence,
  required String arabicTranslation,
  required String cefrLevel,
  Value<String?> notes,
  Value<String?> patternId,
  Value<bool> isFavorite,
  Value<bool> inReviewSystem,
  Value<bool> reminderEnabled,
  Value<String> masteryStatus,
  Value<int> reviewCount,
  Value<bool> hasPronunciationPractice,
  Value<DateTime?> lastReviewedAt,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$SentencesTableUpdateCompanionBuilder = SentencesCompanion Function({
  Value<String> id,
  Value<String> sentence,
  Value<String> arabicTranslation,
  Value<String> cefrLevel,
  Value<String?> notes,
  Value<String?> patternId,
  Value<bool> isFavorite,
  Value<bool> inReviewSystem,
  Value<bool> reminderEnabled,
  Value<String> masteryStatus,
  Value<int> reviewCount,
  Value<bool> hasPronunciationPractice,
  Value<DateTime?> lastReviewedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$SentencesTableReferences
    extends BaseReferences<_$AppDatabase, $SentencesTable, SentenceRow> {
  $$SentencesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SentencePatternsTable _patternIdTable(_$AppDatabase db) => db
      .sentencePatterns
      .createAlias('sentences__pattern_id__sentence_patterns__id');

  $$SentencePatternsTableProcessedTableManager? get patternId {
    final $_column = $_itemColumn<String>('pattern_id');
    if ($_column == null) return null;
    final manager = $$SentencePatternsTableTableManager(
      $_db,
      $_db.sentencePatterns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patternIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $SentenceCategoriesTable,
    List<SentenceCategoryRow>
  >
  _sentenceCategoriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.sentenceCategories,
        aliasName: 'sentences__id__sentence_categories__sentence_id',
      );

  $$SentenceCategoriesTableProcessedTableManager get sentenceCategoriesRefs {
    final manager = $$SentenceCategoriesTableTableManager(
      $_db,
      $_db.sentenceCategories,
    ).filter((f) => f.sentenceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sentenceCategoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SentenceWordsTable, List<SentenceWordRow>>
  _sentenceWordsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sentenceWords,
    aliasName: 'sentences__id__sentence_words__sentence_id',
  );

  $$SentenceWordsTableProcessedTableManager get sentenceWordsRefs {
    final manager = $$SentenceWordsTableTableManager(
      $_db,
      $_db.sentenceWords,
    ).filter((f) => f.sentenceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sentenceWordsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SentencesTableFilterComposer
    extends Composer<_$AppDatabase, $SentencesTable> {
  $$SentencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sentence => $composableBuilder(
    column: $table.sentence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arabicTranslation => $composableBuilder(
    column: $table.arabicTranslation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get inReviewSystem => $composableBuilder(
    column: $table.inReviewSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasPronunciationPractice => $composableBuilder(
    column: $table.hasPronunciationPractice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$SentencePatternsTableFilterComposer get patternId {
    final $$SentencePatternsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patternId,
      referencedTable: $db.sentencePatterns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencePatternsTableFilterComposer(
            $db: $db,
            $table: $db.sentencePatterns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sentenceCategoriesRefs(
    Expression<bool> Function($$SentenceCategoriesTableFilterComposer f) f,
  ) {
    final $$SentenceCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sentenceCategories,
      getReferencedColumn: (t) => t.sentenceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentenceCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.sentenceCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sentenceWordsRefs(
    Expression<bool> Function($$SentenceWordsTableFilterComposer f) f,
  ) {
    final $$SentenceWordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sentenceWords,
      getReferencedColumn: (t) => t.sentenceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentenceWordsTableFilterComposer(
            $db: $db,
            $table: $db.sentenceWords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SentencesTableOrderingComposer
    extends Composer<_$AppDatabase, $SentencesTable> {
  $$SentencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sentence => $composableBuilder(
    column: $table.sentence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arabicTranslation => $composableBuilder(
    column: $table.arabicTranslation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get inReviewSystem => $composableBuilder(
    column: $table.inReviewSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasPronunciationPractice => $composableBuilder(
    column: $table.hasPronunciationPractice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$SentencePatternsTableOrderingComposer get patternId {
    final $$SentencePatternsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patternId,
      referencedTable: $db.sentencePatterns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencePatternsTableOrderingComposer(
            $db: $db,
            $table: $db.sentencePatterns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SentencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SentencesTable> {
  $$SentencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sentence =>
      $composableBuilder(column: $table.sentence, builder: (column) => column);

  GeneratedColumn<String> get arabicTranslation => $composableBuilder(
    column: $table.arabicTranslation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cefrLevel =>
      $composableBuilder(column: $table.cefrLevel, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get inReviewSystem => $composableBuilder(
    column: $table.inReviewSystem,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminderEnabled => $composableBuilder(
    column: $table.reminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get masteryStatus => $composableBuilder(
    column: $table.masteryStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasPronunciationPractice => $composableBuilder(
    column: $table.hasPronunciationPractice,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SentencePatternsTableAnnotationComposer get patternId {
    final $$SentencePatternsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patternId,
      referencedTable: $db.sentencePatterns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencePatternsTableAnnotationComposer(
            $db: $db,
            $table: $db.sentencePatterns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sentenceCategoriesRefs<T extends Object>(
    Expression<T> Function($$SentenceCategoriesTableAnnotationComposer a) f,
  ) {
    final $$SentenceCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.sentenceCategories,
          getReferencedColumn: (t) => t.sentenceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SentenceCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.sentenceCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> sentenceWordsRefs<T extends Object>(
    Expression<T> Function($$SentenceWordsTableAnnotationComposer a) f,
  ) {
    final $$SentenceWordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sentenceWords,
      getReferencedColumn: (t) => t.sentenceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentenceWordsTableAnnotationComposer(
            $db: $db,
            $table: $db.sentenceWords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SentencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SentencesTable,
          SentenceRow,
          $$SentencesTableFilterComposer,
          $$SentencesTableOrderingComposer,
          $$SentencesTableAnnotationComposer,
          $$SentencesTableCreateCompanionBuilder,
          $$SentencesTableUpdateCompanionBuilder,
          (SentenceRow, $$SentencesTableReferences),
          SentenceRow,
          PrefetchHooks Function({
            bool patternId,
            bool sentenceCategoriesRefs,
            bool sentenceWordsRefs,
          })
        > {
  $$SentencesTableTableManager(_$AppDatabase db, $SentencesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SentencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SentencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SentencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sentence = const Value.absent(),
                Value<String> arabicTranslation = const Value.absent(),
                Value<String> cefrLevel = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> patternId = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> inReviewSystem = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<String> masteryStatus = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<bool> hasPronunciationPractice = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SentencesCompanion(
                id: id,
                sentence: sentence,
                arabicTranslation: arabicTranslation,
                cefrLevel: cefrLevel,
                notes: notes,
                patternId: patternId,
                isFavorite: isFavorite,
                inReviewSystem: inReviewSystem,
                reminderEnabled: reminderEnabled,
                masteryStatus: masteryStatus,
                reviewCount: reviewCount,
                hasPronunciationPractice: hasPronunciationPractice,
                lastReviewedAt: lastReviewedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sentence,
                required String arabicTranslation,
                required String cefrLevel,
                Value<String?> notes = const Value.absent(),
                Value<String?> patternId = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> inReviewSystem = const Value.absent(),
                Value<bool> reminderEnabled = const Value.absent(),
                Value<String> masteryStatus = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<bool> hasPronunciationPractice = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SentencesCompanion.insert(
                id: id,
                sentence: sentence,
                arabicTranslation: arabicTranslation,
                cefrLevel: cefrLevel,
                notes: notes,
                patternId: patternId,
                isFavorite: isFavorite,
                inReviewSystem: inReviewSystem,
                reminderEnabled: reminderEnabled,
                masteryStatus: masteryStatus,
                reviewCount: reviewCount,
                hasPronunciationPractice: hasPronunciationPractice,
                lastReviewedAt: lastReviewedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SentencesTable, SentenceRow>(table),
                  $$SentencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                patternId = false,
                sentenceCategoriesRefs = false,
                sentenceWordsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sentenceCategoriesRefs) db.sentenceCategories,
                    if (sentenceWordsRefs) db.sentenceWords,
                  ],
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
                        if (patternId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.patternId,
                            referencedTable: $$SentencesTableReferences
                                ._patternIdTable(db),
                            referencedColumn: $$SentencesTableReferences
                                ._patternIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sentenceCategoriesRefs)
                        await $_getPrefetchedData<
                          SentenceRow,
                          $SentencesTable,
                          SentenceCategoryRow
                        >(
                          currentTable: table,
                          referencedTable: $$SentencesTableReferences
                              ._sentenceCategoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SentencesTableReferences(
                                db,
                                table,
                                p0,
                              ).sentenceCategoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sentenceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sentenceWordsRefs)
                        await $_getPrefetchedData<
                          SentenceRow,
                          $SentencesTable,
                          SentenceWordRow
                        >(
                          currentTable: table,
                          referencedTable: $$SentencesTableReferences
                              ._sentenceWordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SentencesTableReferences(
                                db,
                                table,
                                p0,
                              ).sentenceWordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sentenceId == item.id,
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

typedef $$SentencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SentencesTable,
      SentenceRow,
      $$SentencesTableFilterComposer,
      $$SentencesTableOrderingComposer,
      $$SentencesTableAnnotationComposer,
      $$SentencesTableCreateCompanionBuilder,
      $$SentencesTableUpdateCompanionBuilder,
      (SentenceRow, $$SentencesTableReferences),
      SentenceRow,
      PrefetchHooks Function({
        bool patternId,
        bool sentenceCategoriesRefs,
        bool sentenceWordsRefs,
      })
    >;
typedef $$WordCategoriesTableCreateCompanionBuilder =
    WordCategoriesCompanion Function({
      required String wordId,
      required String categoryId,
      Value<int> rowid,
    });
typedef $$WordCategoriesTableUpdateCompanionBuilder =
    WordCategoriesCompanion Function({
      Value<String> wordId,
      Value<String> categoryId,
      Value<int> rowid,
    });

final class $$WordCategoriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $WordCategoriesTable, WordCategoryRow> {
  $$WordCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WordsTable _wordIdTable(_$AppDatabase db) =>
      db.words.createAlias('word_categories__word_id__words__id');

  $$WordsTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<String>('word_id')!;

    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.categories.createAlias('word_categories__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WordCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $WordCategoriesTable> {
  $$WordCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WordsTableFilterComposer get wordId {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WordCategoriesTable> {
  $$WordCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WordsTableOrderingComposer get wordId {
    final $$WordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableOrderingComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WordCategoriesTable> {
  $$WordCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$WordsTableAnnotationComposer get wordId {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WordCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WordCategoriesTable,
          WordCategoryRow,
          $$WordCategoriesTableFilterComposer,
          $$WordCategoriesTableOrderingComposer,
          $$WordCategoriesTableAnnotationComposer,
          $$WordCategoriesTableCreateCompanionBuilder,
          $$WordCategoriesTableUpdateCompanionBuilder,
          (WordCategoryRow, $$WordCategoriesTableReferences),
          WordCategoryRow,
          PrefetchHooks Function({bool wordId, bool categoryId})
        > {
  $$WordCategoriesTableTableManager(
    _$AppDatabase db,
    $WordCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WordCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WordCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WordCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> wordId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WordCategoriesCompanion(
                wordId: wordId,
                categoryId: categoryId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String wordId,
                required String categoryId,
                Value<int> rowid = const Value.absent(),
              }) => WordCategoriesCompanion.insert(
                wordId: wordId,
                categoryId: categoryId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WordCategoriesTable, WordCategoryRow>(table),
                  $$WordCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wordId = false, categoryId = false}) {
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
                    if (wordId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.wordId,
                        referencedTable: $$WordCategoriesTableReferences
                            ._wordIdTable(db),
                        referencedColumn: $$WordCategoriesTableReferences
                            ._wordIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$WordCategoriesTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$WordCategoriesTableReferences
                            ._categoryIdTable(db)
                            .id,
                      ) as T;
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

typedef $$WordCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WordCategoriesTable,
      WordCategoryRow,
      $$WordCategoriesTableFilterComposer,
      $$WordCategoriesTableOrderingComposer,
      $$WordCategoriesTableAnnotationComposer,
      $$WordCategoriesTableCreateCompanionBuilder,
      $$WordCategoriesTableUpdateCompanionBuilder,
      (WordCategoryRow, $$WordCategoriesTableReferences),
      WordCategoryRow,
      PrefetchHooks Function({bool wordId, bool categoryId})
    >;
typedef $$SentenceCategoriesTableCreateCompanionBuilder =
    SentenceCategoriesCompanion Function({
      required String sentenceId,
      required String categoryId,
      Value<int> rowid,
    });
typedef $$SentenceCategoriesTableUpdateCompanionBuilder =
    SentenceCategoriesCompanion Function({
      Value<String> sentenceId,
      Value<String> categoryId,
      Value<int> rowid,
    });

final class $$SentenceCategoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SentenceCategoriesTable,
          SentenceCategoryRow
        > {
  $$SentenceCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SentencesTable _sentenceIdTable(_$AppDatabase db) => db.sentences
      .createAlias('sentence_categories__sentence_id__sentences__id');

  $$SentencesTableProcessedTableManager get sentenceId {
    final $_column = $_itemColumn<String>('sentence_id')!;

    final manager = $$SentencesTableTableManager(
      $_db,
      $_db.sentences,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sentenceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) => db.categories
      .createAlias('sentence_categories__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SentenceCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $SentenceCategoriesTable> {
  $$SentenceCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SentencesTableFilterComposer get sentenceId {
    final $$SentencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sentenceId,
      referencedTable: $db.sentences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencesTableFilterComposer(
            $db: $db,
            $table: $db.sentences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SentenceCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SentenceCategoriesTable> {
  $$SentenceCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SentencesTableOrderingComposer get sentenceId {
    final $$SentencesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sentenceId,
      referencedTable: $db.sentences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencesTableOrderingComposer(
            $db: $db,
            $table: $db.sentences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SentenceCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SentenceCategoriesTable> {
  $$SentenceCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SentencesTableAnnotationComposer get sentenceId {
    final $$SentencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sentenceId,
      referencedTable: $db.sentences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencesTableAnnotationComposer(
            $db: $db,
            $table: $db.sentences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SentenceCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SentenceCategoriesTable,
          SentenceCategoryRow,
          $$SentenceCategoriesTableFilterComposer,
          $$SentenceCategoriesTableOrderingComposer,
          $$SentenceCategoriesTableAnnotationComposer,
          $$SentenceCategoriesTableCreateCompanionBuilder,
          $$SentenceCategoriesTableUpdateCompanionBuilder,
          (SentenceCategoryRow, $$SentenceCategoriesTableReferences),
          SentenceCategoryRow,
          PrefetchHooks Function({bool sentenceId, bool categoryId})
        > {
  $$SentenceCategoriesTableTableManager(
    _$AppDatabase db,
    $SentenceCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SentenceCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SentenceCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SentenceCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> sentenceId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SentenceCategoriesCompanion(
                sentenceId: sentenceId,
                categoryId: categoryId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sentenceId,
                required String categoryId,
                Value<int> rowid = const Value.absent(),
              }) => SentenceCategoriesCompanion.insert(
                sentenceId: sentenceId,
                categoryId: categoryId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SentenceCategoriesTable, SentenceCategoryRow>(
                    table,
                  ),
                  $$SentenceCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sentenceId = false, categoryId = false}) {
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
                    if (sentenceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sentenceId,
                        referencedTable: $$SentenceCategoriesTableReferences
                            ._sentenceIdTable(db),
                        referencedColumn: $$SentenceCategoriesTableReferences
                            ._sentenceIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$SentenceCategoriesTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$SentenceCategoriesTableReferences
                            ._categoryIdTable(db)
                            .id,
                      ) as T;
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

typedef $$SentenceCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SentenceCategoriesTable,
      SentenceCategoryRow,
      $$SentenceCategoriesTableFilterComposer,
      $$SentenceCategoriesTableOrderingComposer,
      $$SentenceCategoriesTableAnnotationComposer,
      $$SentenceCategoriesTableCreateCompanionBuilder,
      $$SentenceCategoriesTableUpdateCompanionBuilder,
      (SentenceCategoryRow, $$SentenceCategoriesTableReferences),
      SentenceCategoryRow,
      PrefetchHooks Function({bool sentenceId, bool categoryId})
    >;
typedef $$PatternCategoriesTableCreateCompanionBuilder =
    PatternCategoriesCompanion Function({
      required String patternId,
      required String categoryId,
      Value<int> rowid,
    });
typedef $$PatternCategoriesTableUpdateCompanionBuilder =
    PatternCategoriesCompanion Function({
      Value<String> patternId,
      Value<String> categoryId,
      Value<int> rowid,
    });

final class $$PatternCategoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PatternCategoriesTable,
          PatternCategoryRow
        > {
  $$PatternCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SentencePatternsTable _patternIdTable(_$AppDatabase db) => db
      .sentencePatterns
      .createAlias('pattern_categories__pattern_id__sentence_patterns__id');

  $$SentencePatternsTableProcessedTableManager get patternId {
    final $_column = $_itemColumn<String>('pattern_id')!;

    final manager = $$SentencePatternsTableTableManager(
      $_db,
      $_db.sentencePatterns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patternIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) => db.categories
      .createAlias('pattern_categories__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PatternCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $PatternCategoriesTable> {
  $$PatternCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SentencePatternsTableFilterComposer get patternId {
    final $$SentencePatternsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patternId,
      referencedTable: $db.sentencePatterns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencePatternsTableFilterComposer(
            $db: $db,
            $table: $db.sentencePatterns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PatternCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PatternCategoriesTable> {
  $$PatternCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SentencePatternsTableOrderingComposer get patternId {
    final $$SentencePatternsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patternId,
      referencedTable: $db.sentencePatterns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencePatternsTableOrderingComposer(
            $db: $db,
            $table: $db.sentencePatterns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PatternCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatternCategoriesTable> {
  $$PatternCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SentencePatternsTableAnnotationComposer get patternId {
    final $$SentencePatternsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patternId,
      referencedTable: $db.sentencePatterns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencePatternsTableAnnotationComposer(
            $db: $db,
            $table: $db.sentencePatterns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PatternCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PatternCategoriesTable,
          PatternCategoryRow,
          $$PatternCategoriesTableFilterComposer,
          $$PatternCategoriesTableOrderingComposer,
          $$PatternCategoriesTableAnnotationComposer,
          $$PatternCategoriesTableCreateCompanionBuilder,
          $$PatternCategoriesTableUpdateCompanionBuilder,
          (PatternCategoryRow, $$PatternCategoriesTableReferences),
          PatternCategoryRow,
          PrefetchHooks Function({bool patternId, bool categoryId})
        > {
  $$PatternCategoriesTableTableManager(
    _$AppDatabase db,
    $PatternCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatternCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatternCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatternCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> patternId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PatternCategoriesCompanion(
                patternId: patternId,
                categoryId: categoryId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String patternId,
                required String categoryId,
                Value<int> rowid = const Value.absent(),
              }) => PatternCategoriesCompanion.insert(
                patternId: patternId,
                categoryId: categoryId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PatternCategoriesTable, PatternCategoryRow>(
                    table,
                  ),
                  $$PatternCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({patternId = false, categoryId = false}) {
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
                    if (patternId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.patternId,
                        referencedTable: $$PatternCategoriesTableReferences
                            ._patternIdTable(db),
                        referencedColumn: $$PatternCategoriesTableReferences
                            ._patternIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$PatternCategoriesTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$PatternCategoriesTableReferences
                            ._categoryIdTable(db)
                            .id,
                      ) as T;
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

typedef $$PatternCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PatternCategoriesTable,
      PatternCategoryRow,
      $$PatternCategoriesTableFilterComposer,
      $$PatternCategoriesTableOrderingComposer,
      $$PatternCategoriesTableAnnotationComposer,
      $$PatternCategoriesTableCreateCompanionBuilder,
      $$PatternCategoriesTableUpdateCompanionBuilder,
      (PatternCategoryRow, $$PatternCategoriesTableReferences),
      PatternCategoryRow,
      PrefetchHooks Function({bool patternId, bool categoryId})
    >;
typedef $$SentenceWordsTableCreateCompanionBuilder =
    SentenceWordsCompanion Function({
      required String sentenceId,
      required String wordId,
      Value<int> rowid,
    });
typedef $$SentenceWordsTableUpdateCompanionBuilder =
    SentenceWordsCompanion Function({
      Value<String> sentenceId,
      Value<String> wordId,
      Value<int> rowid,
    });

final class $$SentenceWordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $SentenceWordsTable, SentenceWordRow> {
  $$SentenceWordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SentencesTable _sentenceIdTable(_$AppDatabase db) =>
      db.sentences.createAlias('sentence_words__sentence_id__sentences__id');

  $$SentencesTableProcessedTableManager get sentenceId {
    final $_column = $_itemColumn<String>('sentence_id')!;

    final manager = $$SentencesTableTableManager(
      $_db,
      $_db.sentences,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sentenceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $WordsTable _wordIdTable(_$AppDatabase db) =>
      db.words.createAlias('sentence_words__word_id__words__id');

  $$WordsTableProcessedTableManager get wordId {
    final $_column = $_itemColumn<String>('word_id')!;

    final manager = $$WordsTableTableManager(
      $_db,
      $_db.words,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wordIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SentenceWordsTableFilterComposer
    extends Composer<_$AppDatabase, $SentenceWordsTable> {
  $$SentenceWordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SentencesTableFilterComposer get sentenceId {
    final $$SentencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sentenceId,
      referencedTable: $db.sentences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencesTableFilterComposer(
            $db: $db,
            $table: $db.sentences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WordsTableFilterComposer get wordId {
    final $$WordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableFilterComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SentenceWordsTableOrderingComposer
    extends Composer<_$AppDatabase, $SentenceWordsTable> {
  $$SentenceWordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SentencesTableOrderingComposer get sentenceId {
    final $$SentencesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sentenceId,
      referencedTable: $db.sentences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencesTableOrderingComposer(
            $db: $db,
            $table: $db.sentences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WordsTableOrderingComposer get wordId {
    final $$WordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableOrderingComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SentenceWordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SentenceWordsTable> {
  $$SentenceWordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$SentencesTableAnnotationComposer get sentenceId {
    final $$SentencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sentenceId,
      referencedTable: $db.sentences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SentencesTableAnnotationComposer(
            $db: $db,
            $table: $db.sentences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$WordsTableAnnotationComposer get wordId {
    final $$WordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wordId,
      referencedTable: $db.words,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WordsTableAnnotationComposer(
            $db: $db,
            $table: $db.words,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SentenceWordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SentenceWordsTable,
          SentenceWordRow,
          $$SentenceWordsTableFilterComposer,
          $$SentenceWordsTableOrderingComposer,
          $$SentenceWordsTableAnnotationComposer,
          $$SentenceWordsTableCreateCompanionBuilder,
          $$SentenceWordsTableUpdateCompanionBuilder,
          (SentenceWordRow, $$SentenceWordsTableReferences),
          SentenceWordRow,
          PrefetchHooks Function({bool sentenceId, bool wordId})
        > {
  $$SentenceWordsTableTableManager(_$AppDatabase db, $SentenceWordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SentenceWordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SentenceWordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SentenceWordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sentenceId = const Value.absent(),
                Value<String> wordId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SentenceWordsCompanion(
                sentenceId: sentenceId,
                wordId: wordId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sentenceId,
                required String wordId,
                Value<int> rowid = const Value.absent(),
              }) => SentenceWordsCompanion.insert(
                sentenceId: sentenceId,
                wordId: wordId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SentenceWordsTable, SentenceWordRow>(table),
                  $$SentenceWordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sentenceId = false, wordId = false}) {
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
                    if (sentenceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sentenceId,
                        referencedTable: $$SentenceWordsTableReferences
                            ._sentenceIdTable(db),
                        referencedColumn: $$SentenceWordsTableReferences
                            ._sentenceIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (wordId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.wordId,
                        referencedTable: $$SentenceWordsTableReferences
                            ._wordIdTable(db),
                        referencedColumn: $$SentenceWordsTableReferences
                            ._wordIdTable(db)
                            .id,
                      ) as T;
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

typedef $$SentenceWordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SentenceWordsTable,
      SentenceWordRow,
      $$SentenceWordsTableFilterComposer,
      $$SentenceWordsTableOrderingComposer,
      $$SentenceWordsTableAnnotationComposer,
      $$SentenceWordsTableCreateCompanionBuilder,
      $$SentenceWordsTableUpdateCompanionBuilder,
      (SentenceWordRow, $$SentenceWordsTableReferences),
      SentenceWordRow,
      PrefetchHooks Function({bool sentenceId, bool wordId})
    >;
typedef $$ReviewItemsTableCreateCompanionBuilder =
    ReviewItemsCompanion Function({
      required String id,
      required String itemType,
      required String itemId,
      Value<double> easeFactor,
      Value<int> intervalDays,
      Value<int> repetitions,
      required DateTime nextReviewAt,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ReviewItemsTableUpdateCompanionBuilder =
    ReviewItemsCompanion Function({
      Value<String> id,
      Value<String> itemType,
      Value<String> itemId,
      Value<double> easeFactor,
      Value<int> intervalDays,
      Value<int> repetitions,
      Value<DateTime> nextReviewAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ReviewItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ReviewItemsTable, ReviewItemRow> {
  $$ReviewItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ReviewHistoryTable, List<ReviewHistoryRow>>
  _reviewHistoryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reviewHistory,
    aliasName: 'review_items__id__review_history__review_item_id',
  );

  $$ReviewHistoryTableProcessedTableManager get reviewHistoryRefs {
    final manager = $$ReviewHistoryTableTableManager(
      $_db,
      $_db.reviewHistory,
    ).filter((f) => f.reviewItemId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reviewHistoryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReviewItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewItemsTable> {
  $$ReviewItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> reviewHistoryRefs(
    Expression<bool> Function($$ReviewHistoryTableFilterComposer f) f,
  ) {
    final $$ReviewHistoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewHistory,
      getReferencedColumn: (t) => t.reviewItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewHistoryTableFilterComposer(
            $db: $db,
            $table: $db.reviewHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReviewItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewItemsTable> {
  $$ReviewItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReviewItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewItemsTable> {
  $$ReviewItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<double> get easeFactor => $composableBuilder(
    column: $table.easeFactor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalDays => $composableBuilder(
    column: $table.intervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<int> get repetitions => $composableBuilder(
    column: $table.repetitions,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> reviewHistoryRefs<T extends Object>(
    Expression<T> Function($$ReviewHistoryTableAnnotationComposer a) f,
  ) {
    final $$ReviewHistoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reviewHistory,
      getReferencedColumn: (t) => t.reviewItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewHistoryTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewHistory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReviewItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewItemsTable,
          ReviewItemRow,
          $$ReviewItemsTableFilterComposer,
          $$ReviewItemsTableOrderingComposer,
          $$ReviewItemsTableAnnotationComposer,
          $$ReviewItemsTableCreateCompanionBuilder,
          $$ReviewItemsTableUpdateCompanionBuilder,
          (ReviewItemRow, $$ReviewItemsTableReferences),
          ReviewItemRow,
          PrefetchHooks Function({bool reviewHistoryRefs})
        > {
  $$ReviewItemsTableTableManager(_$AppDatabase db, $ReviewItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<double> easeFactor = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                Value<DateTime> nextReviewAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewItemsCompanion(
                id: id,
                itemType: itemType,
                itemId: itemId,
                easeFactor: easeFactor,
                intervalDays: intervalDays,
                repetitions: repetitions,
                nextReviewAt: nextReviewAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String itemType,
                required String itemId,
                Value<double> easeFactor = const Value.absent(),
                Value<int> intervalDays = const Value.absent(),
                Value<int> repetitions = const Value.absent(),
                required DateTime nextReviewAt,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ReviewItemsCompanion.insert(
                id: id,
                itemType: itemType,
                itemId: itemId,
                easeFactor: easeFactor,
                intervalDays: intervalDays,
                repetitions: repetitions,
                nextReviewAt: nextReviewAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReviewItemsTable, ReviewItemRow>(table),
                  $$ReviewItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reviewHistoryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (reviewHistoryRefs) db.reviewHistory,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (reviewHistoryRefs)
                    await $_getPrefetchedData<
                      ReviewItemRow,
                      $ReviewItemsTable,
                      ReviewHistoryRow
                    >(
                      currentTable: table,
                      referencedTable: $$ReviewItemsTableReferences
                          ._reviewHistoryRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ReviewItemsTableReferences(
                            db,
                            table,
                            p0,
                          ).reviewHistoryRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.reviewItemId == item.id,
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

typedef $$ReviewItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewItemsTable,
      ReviewItemRow,
      $$ReviewItemsTableFilterComposer,
      $$ReviewItemsTableOrderingComposer,
      $$ReviewItemsTableAnnotationComposer,
      $$ReviewItemsTableCreateCompanionBuilder,
      $$ReviewItemsTableUpdateCompanionBuilder,
      (ReviewItemRow, $$ReviewItemsTableReferences),
      ReviewItemRow,
      PrefetchHooks Function({bool reviewHistoryRefs})
    >;
typedef $$ReviewHistoryTableCreateCompanionBuilder =
    ReviewHistoryCompanion Function({
      required String id,
      required String reviewItemId,
      required String itemType,
      required String itemId,
      required int rating,
      required int previousInterval,
      required int newInterval,
      required DateTime reviewedAt,
      Value<int> rowid,
    });
typedef $$ReviewHistoryTableUpdateCompanionBuilder =
    ReviewHistoryCompanion Function({
      Value<String> id,
      Value<String> reviewItemId,
      Value<String> itemType,
      Value<String> itemId,
      Value<int> rating,
      Value<int> previousInterval,
      Value<int> newInterval,
      Value<DateTime> reviewedAt,
      Value<int> rowid,
    });

final class $$ReviewHistoryTableReferences
    extends
        BaseReferences<_$AppDatabase, $ReviewHistoryTable, ReviewHistoryRow> {
  $$ReviewHistoryTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ReviewItemsTable _reviewItemIdTable(_$AppDatabase db) => db
      .reviewItems
      .createAlias('review_history__review_item_id__review_items__id');

  $$ReviewItemsTableProcessedTableManager get reviewItemId {
    final $_column = $_itemColumn<String>('review_item_id')!;

    final manager = $$ReviewItemsTableTableManager(
      $_db,
      $_db.reviewItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reviewItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReviewHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewHistoryTable> {
  $$ReviewHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get previousInterval => $composableBuilder(
    column: $table.previousInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get newInterval => $composableBuilder(
    column: $table.newInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ReviewItemsTableFilterComposer get reviewItemId {
    final $$ReviewItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reviewItemId,
      referencedTable: $db.reviewItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewItemsTableFilterComposer(
            $db: $db,
            $table: $db.reviewItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewHistoryTable> {
  $$ReviewHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get previousInterval => $composableBuilder(
    column: $table.previousInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get newInterval => $composableBuilder(
    column: $table.newInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReviewItemsTableOrderingComposer get reviewItemId {
    final $$ReviewItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reviewItemId,
      referencedTable: $db.reviewItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewItemsTableOrderingComposer(
            $db: $db,
            $table: $db.reviewItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewHistoryTable> {
  $$ReviewHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get previousInterval => $composableBuilder(
    column: $table.previousInterval,
    builder: (column) => column,
  );

  GeneratedColumn<int> get newInterval => $composableBuilder(
    column: $table.newInterval,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reviewedAt => $composableBuilder(
    column: $table.reviewedAt,
    builder: (column) => column,
  );

  $$ReviewItemsTableAnnotationComposer get reviewItemId {
    final $$ReviewItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reviewItemId,
      referencedTable: $db.reviewItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReviewItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.reviewItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReviewHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewHistoryTable,
          ReviewHistoryRow,
          $$ReviewHistoryTableFilterComposer,
          $$ReviewHistoryTableOrderingComposer,
          $$ReviewHistoryTableAnnotationComposer,
          $$ReviewHistoryTableCreateCompanionBuilder,
          $$ReviewHistoryTableUpdateCompanionBuilder,
          (ReviewHistoryRow, $$ReviewHistoryTableReferences),
          ReviewHistoryRow,
          PrefetchHooks Function({bool reviewItemId})
        > {
  $$ReviewHistoryTableTableManager(_$AppDatabase db, $ReviewHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> reviewItemId = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<int> previousInterval = const Value.absent(),
                Value<int> newInterval = const Value.absent(),
                Value<DateTime> reviewedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewHistoryCompanion(
                id: id,
                reviewItemId: reviewItemId,
                itemType: itemType,
                itemId: itemId,
                rating: rating,
                previousInterval: previousInterval,
                newInterval: newInterval,
                reviewedAt: reviewedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String reviewItemId,
                required String itemType,
                required String itemId,
                required int rating,
                required int previousInterval,
                required int newInterval,
                required DateTime reviewedAt,
                Value<int> rowid = const Value.absent(),
              }) => ReviewHistoryCompanion.insert(
                id: id,
                reviewItemId: reviewItemId,
                itemType: itemType,
                itemId: itemId,
                rating: rating,
                previousInterval: previousInterval,
                newInterval: newInterval,
                reviewedAt: reviewedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReviewHistoryTable, ReviewHistoryRow>(table),
                  $$ReviewHistoryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reviewItemId = false}) {
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
                    if (reviewItemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.reviewItemId,
                        referencedTable: $$ReviewHistoryTableReferences
                            ._reviewItemIdTable(db),
                        referencedColumn: $$ReviewHistoryTableReferences
                            ._reviewItemIdTable(db)
                            .id,
                      ) as T;
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

typedef $$ReviewHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewHistoryTable,
      ReviewHistoryRow,
      $$ReviewHistoryTableFilterComposer,
      $$ReviewHistoryTableOrderingComposer,
      $$ReviewHistoryTableAnnotationComposer,
      $$ReviewHistoryTableCreateCompanionBuilder,
      $$ReviewHistoryTableUpdateCompanionBuilder,
      (ReviewHistoryRow, $$ReviewHistoryTableReferences),
      ReviewHistoryRow,
      PrefetchHooks Function({bool reviewItemId})
    >;
typedef $$PronunciationCacheTableCreateCompanionBuilder =
    PronunciationCacheCompanion Function({
      required String id,
      required String contentHash,
      required String textContent,
      required String accent,
      required double speed,
      required String filePath,
      required String provider,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$PronunciationCacheTableUpdateCompanionBuilder =
    PronunciationCacheCompanion Function({
      Value<String> id,
      Value<String> contentHash,
      Value<String> textContent,
      Value<String> accent,
      Value<double> speed,
      Value<String> filePath,
      Value<String> provider,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$PronunciationCacheTableFilterComposer
    extends Composer<_$AppDatabase, $PronunciationCacheTable> {
  $$PronunciationCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accent => $composableBuilder(
    column: $table.accent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PronunciationCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $PronunciationCacheTable> {
  $$PronunciationCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accent => $composableBuilder(
    column: $table.accent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speed => $composableBuilder(
    column: $table.speed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PronunciationCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $PronunciationCacheTable> {
  $$PronunciationCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentHash => $composableBuilder(
    column: $table.contentHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get textContent => $composableBuilder(
    column: $table.textContent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accent =>
      $composableBuilder(column: $table.accent, builder: (column) => column);

  GeneratedColumn<double> get speed =>
      $composableBuilder(column: $table.speed, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PronunciationCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PronunciationCacheTable,
          PronunciationCacheRow,
          $$PronunciationCacheTableFilterComposer,
          $$PronunciationCacheTableOrderingComposer,
          $$PronunciationCacheTableAnnotationComposer,
          $$PronunciationCacheTableCreateCompanionBuilder,
          $$PronunciationCacheTableUpdateCompanionBuilder,
          (
            PronunciationCacheRow,
            BaseReferences<
              _$AppDatabase,
              $PronunciationCacheTable,
              PronunciationCacheRow
            >,
          ),
          PronunciationCacheRow,
          PrefetchHooks Function()
        > {
  $$PronunciationCacheTableTableManager(
    _$AppDatabase db,
    $PronunciationCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PronunciationCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PronunciationCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PronunciationCacheTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> contentHash = const Value.absent(),
                Value<String> textContent = const Value.absent(),
                Value<String> accent = const Value.absent(),
                Value<double> speed = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String> provider = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PronunciationCacheCompanion(
                id: id,
                contentHash: contentHash,
                textContent: textContent,
                accent: accent,
                speed: speed,
                filePath: filePath,
                provider: provider,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String contentHash,
                required String textContent,
                required String accent,
                required double speed,
                required String filePath,
                required String provider,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PronunciationCacheCompanion.insert(
                id: id,
                contentHash: contentHash,
                textContent: textContent,
                accent: accent,
                speed: speed,
                filePath: filePath,
                provider: provider,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PronunciationCacheTable, PronunciationCacheRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $PronunciationCacheTable,
                    PronunciationCacheRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PronunciationCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PronunciationCacheTable,
      PronunciationCacheRow,
      $$PronunciationCacheTableFilterComposer,
      $$PronunciationCacheTableOrderingComposer,
      $$PronunciationCacheTableAnnotationComposer,
      $$PronunciationCacheTableCreateCompanionBuilder,
      $$PronunciationCacheTableUpdateCompanionBuilder,
      (
        PronunciationCacheRow,
        BaseReferences<
          _$AppDatabase,
          $PronunciationCacheTable,
          PronunciationCacheRow
        >,
      ),
      PronunciationCacheRow,
      PrefetchHooks Function()
    >;
typedef $$LearningSessionsTableCreateCompanionBuilder =
    LearningSessionsCompanion Function({
      required String id,
      required String sessionType,
      Value<int> reviewedCount,
      Value<int> correctCount,
      Value<int> incorrectCount,
      Value<int> skippedCount,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<int> rowid,
    });
typedef $$LearningSessionsTableUpdateCompanionBuilder =
    LearningSessionsCompanion Function({
      Value<String> id,
      Value<String> sessionType,
      Value<int> reviewedCount,
      Value<int> correctCount,
      Value<int> incorrectCount,
      Value<int> skippedCount,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int> rowid,
    });

class $$LearningSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $LearningSessionsTable> {
  $$LearningSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewedCount => $composableBuilder(
    column: $table.reviewedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get incorrectCount => $composableBuilder(
    column: $table.incorrectCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get skippedCount => $composableBuilder(
    column: $table.skippedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LearningSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningSessionsTable> {
  $$LearningSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewedCount => $composableBuilder(
    column: $table.reviewedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get incorrectCount => $composableBuilder(
    column: $table.incorrectCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get skippedCount => $composableBuilder(
    column: $table.skippedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LearningSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningSessionsTable> {
  $$LearningSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionType => $composableBuilder(
    column: $table.sessionType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewedCount => $composableBuilder(
    column: $table.reviewedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get incorrectCount => $composableBuilder(
    column: $table.incorrectCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get skippedCount => $composableBuilder(
    column: $table.skippedCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);
}

class $$LearningSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningSessionsTable,
          LearningSessionRow,
          $$LearningSessionsTableFilterComposer,
          $$LearningSessionsTableOrderingComposer,
          $$LearningSessionsTableAnnotationComposer,
          $$LearningSessionsTableCreateCompanionBuilder,
          $$LearningSessionsTableUpdateCompanionBuilder,
          (
            LearningSessionRow,
            BaseReferences<
              _$AppDatabase,
              $LearningSessionsTable,
              LearningSessionRow
            >,
          ),
          LearningSessionRow,
          PrefetchHooks Function()
        > {
  $$LearningSessionsTableTableManager(
    _$AppDatabase db,
    $LearningSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionType = const Value.absent(),
                Value<int> reviewedCount = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> incorrectCount = const Value.absent(),
                Value<int> skippedCount = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningSessionsCompanion(
                id: id,
                sessionType: sessionType,
                reviewedCount: reviewedCount,
                correctCount: correctCount,
                incorrectCount: incorrectCount,
                skippedCount: skippedCount,
                startedAt: startedAt,
                endedAt: endedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionType,
                Value<int> reviewedCount = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> incorrectCount = const Value.absent(),
                Value<int> skippedCount = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningSessionsCompanion.insert(
                id: id,
                sessionType: sessionType,
                reviewedCount: reviewedCount,
                correctCount: correctCount,
                incorrectCount: incorrectCount,
                skippedCount: skippedCount,
                startedAt: startedAt,
                endedAt: endedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LearningSessionsTable, LearningSessionRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $LearningSessionsTable,
                    LearningSessionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LearningSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningSessionsTable,
      LearningSessionRow,
      $$LearningSessionsTableFilterComposer,
      $$LearningSessionsTableOrderingComposer,
      $$LearningSessionsTableAnnotationComposer,
      $$LearningSessionsTableCreateCompanionBuilder,
      $$LearningSessionsTableUpdateCompanionBuilder,
      (
        LearningSessionRow,
        BaseReferences<
          _$AppDatabase,
          $LearningSessionsTable,
          LearningSessionRow
        >,
      ),
      LearningSessionRow,
      PrefetchHooks Function()
    >;
typedef $$UserPreferencesTableCreateCompanionBuilder =
    UserPreferencesCompanion Function({
      required String key,
      required String value,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UserPreferencesTableUpdateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$UserPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreferenceRow,
          $$UserPreferencesTableFilterComposer,
          $$UserPreferencesTableOrderingComposer,
          $$UserPreferencesTableAnnotationComposer,
          $$UserPreferencesTableCreateCompanionBuilder,
          $$UserPreferencesTableUpdateCompanionBuilder,
          (
            UserPreferenceRow,
            BaseReferences<
              _$AppDatabase,
              $UserPreferencesTable,
              UserPreferenceRow
            >,
          ),
          UserPreferenceRow,
          PrefetchHooks Function()
        > {
  $$UserPreferencesTableTableManager(
    _$AppDatabase db,
    $UserPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPreferencesCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserPreferencesCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserPreferencesTable, UserPreferenceRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $UserPreferencesTable,
                    UserPreferenceRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPreferencesTable,
      UserPreferenceRow,
      $$UserPreferencesTableFilterComposer,
      $$UserPreferencesTableOrderingComposer,
      $$UserPreferencesTableAnnotationComposer,
      $$UserPreferencesTableCreateCompanionBuilder,
      $$UserPreferencesTableUpdateCompanionBuilder,
      (
        UserPreferenceRow,
        BaseReferences<_$AppDatabase, $UserPreferencesTable, UserPreferenceRow>,
      ),
      UserPreferenceRow,
      PrefetchHooks Function()
    >;
typedef $$AppStatisticsTableCreateCompanionBuilder =
    AppStatisticsCompanion Function({
      required String key,
      required String value,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AppStatisticsTableUpdateCompanionBuilder =
    AppStatisticsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppStatisticsTableFilterComposer
    extends Composer<_$AppDatabase, $AppStatisticsTable> {
  $$AppStatisticsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppStatisticsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppStatisticsTable> {
  $$AppStatisticsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppStatisticsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppStatisticsTable> {
  $$AppStatisticsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppStatisticsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppStatisticsTable,
          AppStatisticRow,
          $$AppStatisticsTableFilterComposer,
          $$AppStatisticsTableOrderingComposer,
          $$AppStatisticsTableAnnotationComposer,
          $$AppStatisticsTableCreateCompanionBuilder,
          $$AppStatisticsTableUpdateCompanionBuilder,
          (
            AppStatisticRow,
            BaseReferences<_$AppDatabase, $AppStatisticsTable, AppStatisticRow>,
          ),
          AppStatisticRow,
          PrefetchHooks Function()
        > {
  $$AppStatisticsTableTableManager(_$AppDatabase db, $AppStatisticsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppStatisticsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppStatisticsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppStatisticsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppStatisticsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AppStatisticsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppStatisticsTable, AppStatisticRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AppStatisticsTable,
                    AppStatisticRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppStatisticsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppStatisticsTable,
      AppStatisticRow,
      $$AppStatisticsTableFilterComposer,
      $$AppStatisticsTableOrderingComposer,
      $$AppStatisticsTableAnnotationComposer,
      $$AppStatisticsTableCreateCompanionBuilder,
      $$AppStatisticsTableUpdateCompanionBuilder,
      (
        AppStatisticRow,
        BaseReferences<_$AppDatabase, $AppStatisticsTable, AppStatisticRow>,
      ),
      AppStatisticRow,
      PrefetchHooks Function()
    >;
typedef $$VocabularyEntriesTableCreateCompanionBuilder =
    VocabularyEntriesCompanion Function({
      required String id,
      required String lemma,
      required String cefrLevel,
      required String partOfSpeech,
      required String definitionEn,
      required String arabicMeaning,
      required String exampleSentence,
      Value<String?> phonetic,
      Value<bool> academic,
      Value<bool> ieltsRelevant,
      Value<bool> toeflRelevant,
      Value<int> catalogVersion,
      Value<int> rowid,
    });
typedef $$VocabularyEntriesTableUpdateCompanionBuilder =
    VocabularyEntriesCompanion Function({
      Value<String> id,
      Value<String> lemma,
      Value<String> cefrLevel,
      Value<String> partOfSpeech,
      Value<String> definitionEn,
      Value<String> arabicMeaning,
      Value<String> exampleSentence,
      Value<String?> phonetic,
      Value<bool> academic,
      Value<bool> ieltsRelevant,
      Value<bool> toeflRelevant,
      Value<int> catalogVersion,
      Value<int> rowid,
    });

final class $$VocabularyEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $VocabularyEntriesTable,
          VocabularyEntryRow
        > {
  $$VocabularyEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$VocabularyFormsTable, List<VocabularyFormRow>>
  _vocabularyFormsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vocabularyForms,
    aliasName: 'vocabulary_entries__id__vocabulary_forms__entry_id',
  );

  $$VocabularyFormsTableProcessedTableManager get vocabularyFormsRefs {
    final manager = $$VocabularyFormsTableTableManager(
      $_db,
      $_db.vocabularyForms,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vocabularyFormsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserVocabularyTable, List<UserVocabularyRow>>
  _userVocabularyRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userVocabulary,
    aliasName: 'vocabulary_entries__id__user_vocabulary__entry_id',
  );

  $$UserVocabularyTableProcessedTableManager get userVocabularyRefs {
    final manager = $$UserVocabularyTableTableManager(
      $_db,
      $_db.userVocabulary,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userVocabularyRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BlogVocabularyTable, List<BlogVocabularyRow>>
  _blogVocabularyRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.blogVocabulary,
    aliasName: 'vocabulary_entries__id__blog_vocabulary__entry_id',
  );

  $$BlogVocabularyTableProcessedTableManager get blogVocabularyRefs {
    final manager = $$BlogVocabularyTableTableManager(
      $_db,
      $_db.blogVocabulary,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_blogVocabularyRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $VocabularyEntryRanksTable,
    List<VocabularyEntryRankRow>
  >
  _vocabularyEntryRanksRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.vocabularyEntryRanks,
        aliasName: 'vocabulary_entries__id__vocabulary_entry_ranks__entry_id',
      );

  $$VocabularyEntryRanksTableProcessedTableManager
  get vocabularyEntryRanksRefs {
    final manager = $$VocabularyEntryRanksTableTableManager(
      $_db,
      $_db.vocabularyEntryRanks,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vocabularyEntryRanksRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VocabularyTopicsTable, List<VocabularyTopicRow>>
  _vocabularyTopicsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vocabularyTopics,
    aliasName: 'vocabulary_entries__id__vocabulary_topics__entry_id',
  );

  $$VocabularyTopicsTableProcessedTableManager get vocabularyTopicsRefs {
    final manager = $$VocabularyTopicsTableTableManager(
      $_db,
      $_db.vocabularyTopics,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vocabularyTopicsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VocabularyEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $VocabularyEntriesTable> {
  $$VocabularyEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lemma => $composableBuilder(
    column: $table.lemma,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get definitionEn => $composableBuilder(
    column: $table.definitionEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arabicMeaning => $composableBuilder(
    column: $table.arabicMeaning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exampleSentence => $composableBuilder(
    column: $table.exampleSentence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phonetic => $composableBuilder(
    column: $table.phonetic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get academic => $composableBuilder(
    column: $table.academic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get ieltsRelevant => $composableBuilder(
    column: $table.ieltsRelevant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get toeflRelevant => $composableBuilder(
    column: $table.toeflRelevant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get catalogVersion => $composableBuilder(
    column: $table.catalogVersion,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> vocabularyFormsRefs(
    Expression<bool> Function($$VocabularyFormsTableFilterComposer f) f,
  ) {
    final $$VocabularyFormsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabularyForms,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyFormsTableFilterComposer(
            $db: $db,
            $table: $db.vocabularyForms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userVocabularyRefs(
    Expression<bool> Function($$UserVocabularyTableFilterComposer f) f,
  ) {
    final $$UserVocabularyTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userVocabulary,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserVocabularyTableFilterComposer(
            $db: $db,
            $table: $db.userVocabulary,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> blogVocabularyRefs(
    Expression<bool> Function($$BlogVocabularyTableFilterComposer f) f,
  ) {
    final $$BlogVocabularyTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.blogVocabulary,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlogVocabularyTableFilterComposer(
            $db: $db,
            $table: $db.blogVocabulary,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vocabularyEntryRanksRefs(
    Expression<bool> Function($$VocabularyEntryRanksTableFilterComposer f) f,
  ) {
    final $$VocabularyEntryRanksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabularyEntryRanks,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyEntryRanksTableFilterComposer(
            $db: $db,
            $table: $db.vocabularyEntryRanks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vocabularyTopicsRefs(
    Expression<bool> Function($$VocabularyTopicsTableFilterComposer f) f,
  ) {
    final $$VocabularyTopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabularyTopics,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyTopicsTableFilterComposer(
            $db: $db,
            $table: $db.vocabularyTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VocabularyEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabularyEntriesTable> {
  $$VocabularyEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lemma => $composableBuilder(
    column: $table.lemma,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get definitionEn => $composableBuilder(
    column: $table.definitionEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arabicMeaning => $composableBuilder(
    column: $table.arabicMeaning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exampleSentence => $composableBuilder(
    column: $table.exampleSentence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phonetic => $composableBuilder(
    column: $table.phonetic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get academic => $composableBuilder(
    column: $table.academic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get ieltsRelevant => $composableBuilder(
    column: $table.ieltsRelevant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get toeflRelevant => $composableBuilder(
    column: $table.toeflRelevant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get catalogVersion => $composableBuilder(
    column: $table.catalogVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VocabularyEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabularyEntriesTable> {
  $$VocabularyEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get lemma =>
      $composableBuilder(column: $table.lemma, builder: (column) => column);

  GeneratedColumn<String> get cefrLevel =>
      $composableBuilder(column: $table.cefrLevel, builder: (column) => column);

  GeneratedColumn<String> get partOfSpeech => $composableBuilder(
    column: $table.partOfSpeech,
    builder: (column) => column,
  );

  GeneratedColumn<String> get definitionEn => $composableBuilder(
    column: $table.definitionEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get arabicMeaning => $composableBuilder(
    column: $table.arabicMeaning,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exampleSentence => $composableBuilder(
    column: $table.exampleSentence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phonetic =>
      $composableBuilder(column: $table.phonetic, builder: (column) => column);

  GeneratedColumn<bool> get academic =>
      $composableBuilder(column: $table.academic, builder: (column) => column);

  GeneratedColumn<bool> get ieltsRelevant => $composableBuilder(
    column: $table.ieltsRelevant,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get toeflRelevant => $composableBuilder(
    column: $table.toeflRelevant,
    builder: (column) => column,
  );

  GeneratedColumn<int> get catalogVersion => $composableBuilder(
    column: $table.catalogVersion,
    builder: (column) => column,
  );

  Expression<T> vocabularyFormsRefs<T extends Object>(
    Expression<T> Function($$VocabularyFormsTableAnnotationComposer a) f,
  ) {
    final $$VocabularyFormsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabularyForms,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyFormsTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabularyForms,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> userVocabularyRefs<T extends Object>(
    Expression<T> Function($$UserVocabularyTableAnnotationComposer a) f,
  ) {
    final $$UserVocabularyTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userVocabulary,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserVocabularyTableAnnotationComposer(
            $db: $db,
            $table: $db.userVocabulary,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> blogVocabularyRefs<T extends Object>(
    Expression<T> Function($$BlogVocabularyTableAnnotationComposer a) f,
  ) {
    final $$BlogVocabularyTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.blogVocabulary,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlogVocabularyTableAnnotationComposer(
            $db: $db,
            $table: $db.blogVocabulary,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vocabularyEntryRanksRefs<T extends Object>(
    Expression<T> Function($$VocabularyEntryRanksTableAnnotationComposer a) f,
  ) {
    final $$VocabularyEntryRanksTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.vocabularyEntryRanks,
          getReferencedColumn: (t) => t.entryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VocabularyEntryRanksTableAnnotationComposer(
                $db: $db,
                $table: $db.vocabularyEntryRanks,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> vocabularyTopicsRefs<T extends Object>(
    Expression<T> Function($$VocabularyTopicsTableAnnotationComposer a) f,
  ) {
    final $$VocabularyTopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabularyTopics,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyTopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabularyTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VocabularyEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VocabularyEntriesTable,
          VocabularyEntryRow,
          $$VocabularyEntriesTableFilterComposer,
          $$VocabularyEntriesTableOrderingComposer,
          $$VocabularyEntriesTableAnnotationComposer,
          $$VocabularyEntriesTableCreateCompanionBuilder,
          $$VocabularyEntriesTableUpdateCompanionBuilder,
          (VocabularyEntryRow, $$VocabularyEntriesTableReferences),
          VocabularyEntryRow,
          PrefetchHooks Function({
            bool vocabularyFormsRefs,
            bool userVocabularyRefs,
            bool blogVocabularyRefs,
            bool vocabularyEntryRanksRefs,
            bool vocabularyTopicsRefs,
          })
        > {
  $$VocabularyEntriesTableTableManager(
    _$AppDatabase db,
    $VocabularyEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabularyEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabularyEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabularyEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> lemma = const Value.absent(),
                Value<String> cefrLevel = const Value.absent(),
                Value<String> partOfSpeech = const Value.absent(),
                Value<String> definitionEn = const Value.absent(),
                Value<String> arabicMeaning = const Value.absent(),
                Value<String> exampleSentence = const Value.absent(),
                Value<String?> phonetic = const Value.absent(),
                Value<bool> academic = const Value.absent(),
                Value<bool> ieltsRelevant = const Value.absent(),
                Value<bool> toeflRelevant = const Value.absent(),
                Value<int> catalogVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabularyEntriesCompanion(
                id: id,
                lemma: lemma,
                cefrLevel: cefrLevel,
                partOfSpeech: partOfSpeech,
                definitionEn: definitionEn,
                arabicMeaning: arabicMeaning,
                exampleSentence: exampleSentence,
                phonetic: phonetic,
                academic: academic,
                ieltsRelevant: ieltsRelevant,
                toeflRelevant: toeflRelevant,
                catalogVersion: catalogVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String lemma,
                required String cefrLevel,
                required String partOfSpeech,
                required String definitionEn,
                required String arabicMeaning,
                required String exampleSentence,
                Value<String?> phonetic = const Value.absent(),
                Value<bool> academic = const Value.absent(),
                Value<bool> ieltsRelevant = const Value.absent(),
                Value<bool> toeflRelevant = const Value.absent(),
                Value<int> catalogVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabularyEntriesCompanion.insert(
                id: id,
                lemma: lemma,
                cefrLevel: cefrLevel,
                partOfSpeech: partOfSpeech,
                definitionEn: definitionEn,
                arabicMeaning: arabicMeaning,
                exampleSentence: exampleSentence,
                phonetic: phonetic,
                academic: academic,
                ieltsRelevant: ieltsRelevant,
                toeflRelevant: toeflRelevant,
                catalogVersion: catalogVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VocabularyEntriesTable, VocabularyEntryRow>(
                    table,
                  ),
                  $$VocabularyEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                vocabularyFormsRefs = false,
                userVocabularyRefs = false,
                blogVocabularyRefs = false,
                vocabularyEntryRanksRefs = false,
                vocabularyTopicsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (vocabularyFormsRefs) db.vocabularyForms,
                    if (userVocabularyRefs) db.userVocabulary,
                    if (blogVocabularyRefs) db.blogVocabulary,
                    if (vocabularyEntryRanksRefs) db.vocabularyEntryRanks,
                    if (vocabularyTopicsRefs) db.vocabularyTopics,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (vocabularyFormsRefs)
                        await $_getPrefetchedData<
                          VocabularyEntryRow,
                          $VocabularyEntriesTable,
                          VocabularyFormRow
                        >(
                          currentTable: table,
                          referencedTable: $$VocabularyEntriesTableReferences
                              ._vocabularyFormsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VocabularyEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).vocabularyFormsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userVocabularyRefs)
                        await $_getPrefetchedData<
                          VocabularyEntryRow,
                          $VocabularyEntriesTable,
                          UserVocabularyRow
                        >(
                          currentTable: table,
                          referencedTable: $$VocabularyEntriesTableReferences
                              ._userVocabularyRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VocabularyEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).userVocabularyRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (blogVocabularyRefs)
                        await $_getPrefetchedData<
                          VocabularyEntryRow,
                          $VocabularyEntriesTable,
                          BlogVocabularyRow
                        >(
                          currentTable: table,
                          referencedTable: $$VocabularyEntriesTableReferences
                              ._blogVocabularyRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VocabularyEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).blogVocabularyRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vocabularyEntryRanksRefs)
                        await $_getPrefetchedData<
                          VocabularyEntryRow,
                          $VocabularyEntriesTable,
                          VocabularyEntryRankRow
                        >(
                          currentTable: table,
                          referencedTable: $$VocabularyEntriesTableReferences
                              ._vocabularyEntryRanksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VocabularyEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).vocabularyEntryRanksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vocabularyTopicsRefs)
                        await $_getPrefetchedData<
                          VocabularyEntryRow,
                          $VocabularyEntriesTable,
                          VocabularyTopicRow
                        >(
                          currentTable: table,
                          referencedTable: $$VocabularyEntriesTableReferences
                              ._vocabularyTopicsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VocabularyEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).vocabularyTopicsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
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

typedef $$VocabularyEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VocabularyEntriesTable,
      VocabularyEntryRow,
      $$VocabularyEntriesTableFilterComposer,
      $$VocabularyEntriesTableOrderingComposer,
      $$VocabularyEntriesTableAnnotationComposer,
      $$VocabularyEntriesTableCreateCompanionBuilder,
      $$VocabularyEntriesTableUpdateCompanionBuilder,
      (VocabularyEntryRow, $$VocabularyEntriesTableReferences),
      VocabularyEntryRow,
      PrefetchHooks Function({
        bool vocabularyFormsRefs,
        bool userVocabularyRefs,
        bool blogVocabularyRefs,
        bool vocabularyEntryRanksRefs,
        bool vocabularyTopicsRefs,
      })
    >;
typedef $$VocabularyFormsTableCreateCompanionBuilder =
    VocabularyFormsCompanion Function({
      required String surface,
      required String entryId,
      Value<int> rowid,
    });
typedef $$VocabularyFormsTableUpdateCompanionBuilder =
    VocabularyFormsCompanion Function({
      Value<String> surface,
      Value<String> entryId,
      Value<int> rowid,
    });

final class $$VocabularyFormsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $VocabularyFormsTable,
          VocabularyFormRow
        > {
  $$VocabularyFormsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VocabularyEntriesTable _entryIdTable(_$AppDatabase db) => db
      .vocabularyEntries
      .createAlias('vocabulary_forms__entry_id__vocabulary_entries__id');

  $$VocabularyEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager = $$VocabularyEntriesTableTableManager(
      $_db,
      $_db.vocabularyEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VocabularyFormsTableFilterComposer
    extends Composer<_$AppDatabase, $VocabularyFormsTable> {
  $$VocabularyFormsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get surface => $composableBuilder(
    column: $table.surface,
    builder: (column) => ColumnFilters(column),
  );

  $$VocabularyEntriesTableFilterComposer get entryId {
    final $$VocabularyEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.vocabularyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyEntriesTableFilterComposer(
            $db: $db,
            $table: $db.vocabularyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabularyFormsTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabularyFormsTable> {
  $$VocabularyFormsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get surface => $composableBuilder(
    column: $table.surface,
    builder: (column) => ColumnOrderings(column),
  );

  $$VocabularyEntriesTableOrderingComposer get entryId {
    final $$VocabularyEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.vocabularyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.vocabularyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabularyFormsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabularyFormsTable> {
  $$VocabularyFormsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get surface =>
      $composableBuilder(column: $table.surface, builder: (column) => column);

  $$VocabularyEntriesTableAnnotationComposer get entryId {
    final $$VocabularyEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.entryId,
          referencedTable: $db.vocabularyEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VocabularyEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.vocabularyEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$VocabularyFormsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VocabularyFormsTable,
          VocabularyFormRow,
          $$VocabularyFormsTableFilterComposer,
          $$VocabularyFormsTableOrderingComposer,
          $$VocabularyFormsTableAnnotationComposer,
          $$VocabularyFormsTableCreateCompanionBuilder,
          $$VocabularyFormsTableUpdateCompanionBuilder,
          (VocabularyFormRow, $$VocabularyFormsTableReferences),
          VocabularyFormRow,
          PrefetchHooks Function({bool entryId})
        > {
  $$VocabularyFormsTableTableManager(
    _$AppDatabase db,
    $VocabularyFormsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabularyFormsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabularyFormsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabularyFormsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> surface = const Value.absent(),
                Value<String> entryId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabularyFormsCompanion(
                surface: surface,
                entryId: entryId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String surface,
                required String entryId,
                Value<int> rowid = const Value.absent(),
              }) => VocabularyFormsCompanion.insert(
                surface: surface,
                entryId: entryId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VocabularyFormsTable, VocabularyFormRow>(table),
                  $$VocabularyFormsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false}) {
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
                    if (entryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.entryId,
                        referencedTable: $$VocabularyFormsTableReferences
                            ._entryIdTable(db),
                        referencedColumn: $$VocabularyFormsTableReferences
                            ._entryIdTable(db)
                            .id,
                      ) as T;
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

typedef $$VocabularyFormsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VocabularyFormsTable,
      VocabularyFormRow,
      $$VocabularyFormsTableFilterComposer,
      $$VocabularyFormsTableOrderingComposer,
      $$VocabularyFormsTableAnnotationComposer,
      $$VocabularyFormsTableCreateCompanionBuilder,
      $$VocabularyFormsTableUpdateCompanionBuilder,
      (VocabularyFormRow, $$VocabularyFormsTableReferences),
      VocabularyFormRow,
      PrefetchHooks Function({bool entryId})
    >;
typedef $$UserVocabularyTableCreateCompanionBuilder =
    UserVocabularyCompanion Function({
      required String entryId,
      Value<String> status,
      required DateTime firstDiscoveredAt,
      required String discoveredIn,
      Value<String?> sourceId,
      Value<int> usageCount,
      required DateTime lastUsedAt,
      Value<int> rowid,
    });
typedef $$UserVocabularyTableUpdateCompanionBuilder =
    UserVocabularyCompanion Function({
      Value<String> entryId,
      Value<String> status,
      Value<DateTime> firstDiscoveredAt,
      Value<String> discoveredIn,
      Value<String?> sourceId,
      Value<int> usageCount,
      Value<DateTime> lastUsedAt,
      Value<int> rowid,
    });

final class $$UserVocabularyTableReferences
    extends
        BaseReferences<_$AppDatabase, $UserVocabularyTable, UserVocabularyRow> {
  $$UserVocabularyTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VocabularyEntriesTable _entryIdTable(_$AppDatabase db) => db
      .vocabularyEntries
      .createAlias('user_vocabulary__entry_id__vocabulary_entries__id');

  $$VocabularyEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager = $$VocabularyEntriesTableTableManager(
      $_db,
      $_db.vocabularyEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserVocabularyTableFilterComposer
    extends Composer<_$AppDatabase, $UserVocabularyTable> {
  $$UserVocabularyTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firstDiscoveredAt => $composableBuilder(
    column: $table.firstDiscoveredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get discoveredIn => $composableBuilder(
    column: $table.discoveredIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VocabularyEntriesTableFilterComposer get entryId {
    final $$VocabularyEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.vocabularyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyEntriesTableFilterComposer(
            $db: $db,
            $table: $db.vocabularyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserVocabularyTableOrderingComposer
    extends Composer<_$AppDatabase, $UserVocabularyTable> {
  $$UserVocabularyTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firstDiscoveredAt => $composableBuilder(
    column: $table.firstDiscoveredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get discoveredIn => $composableBuilder(
    column: $table.discoveredIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VocabularyEntriesTableOrderingComposer get entryId {
    final $$VocabularyEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.vocabularyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.vocabularyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserVocabularyTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserVocabularyTable> {
  $$UserVocabularyTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get firstDiscoveredAt => $composableBuilder(
    column: $table.firstDiscoveredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get discoveredIn => $composableBuilder(
    column: $table.discoveredIn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => column,
  );

  $$VocabularyEntriesTableAnnotationComposer get entryId {
    final $$VocabularyEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.entryId,
          referencedTable: $db.vocabularyEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VocabularyEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.vocabularyEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$UserVocabularyTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserVocabularyTable,
          UserVocabularyRow,
          $$UserVocabularyTableFilterComposer,
          $$UserVocabularyTableOrderingComposer,
          $$UserVocabularyTableAnnotationComposer,
          $$UserVocabularyTableCreateCompanionBuilder,
          $$UserVocabularyTableUpdateCompanionBuilder,
          (UserVocabularyRow, $$UserVocabularyTableReferences),
          UserVocabularyRow,
          PrefetchHooks Function({bool entryId})
        > {
  $$UserVocabularyTableTableManager(
    _$AppDatabase db,
    $UserVocabularyTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserVocabularyTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserVocabularyTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserVocabularyTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> entryId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> firstDiscoveredAt = const Value.absent(),
                Value<String> discoveredIn = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<DateTime> lastUsedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserVocabularyCompanion(
                entryId: entryId,
                status: status,
                firstDiscoveredAt: firstDiscoveredAt,
                discoveredIn: discoveredIn,
                sourceId: sourceId,
                usageCount: usageCount,
                lastUsedAt: lastUsedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String entryId,
                Value<String> status = const Value.absent(),
                required DateTime firstDiscoveredAt,
                required String discoveredIn,
                Value<String?> sourceId = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                required DateTime lastUsedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserVocabularyCompanion.insert(
                entryId: entryId,
                status: status,
                firstDiscoveredAt: firstDiscoveredAt,
                discoveredIn: discoveredIn,
                sourceId: sourceId,
                usageCount: usageCount,
                lastUsedAt: lastUsedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserVocabularyTable, UserVocabularyRow>(table),
                  $$UserVocabularyTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false}) {
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
                    if (entryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.entryId,
                        referencedTable: $$UserVocabularyTableReferences
                            ._entryIdTable(db),
                        referencedColumn: $$UserVocabularyTableReferences
                            ._entryIdTable(db)
                            .id,
                      ) as T;
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

typedef $$UserVocabularyTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserVocabularyTable,
      UserVocabularyRow,
      $$UserVocabularyTableFilterComposer,
      $$UserVocabularyTableOrderingComposer,
      $$UserVocabularyTableAnnotationComposer,
      $$UserVocabularyTableCreateCompanionBuilder,
      $$UserVocabularyTableUpdateCompanionBuilder,
      (UserVocabularyRow, $$UserVocabularyTableReferences),
      UserVocabularyRow,
      PrefetchHooks Function({bool entryId})
    >;
typedef $$BlogEntriesTableCreateCompanionBuilder =
    BlogEntriesCompanion Function({
      required String id,
      required String title,
      required String content,
      Value<int> wordCount,
      Value<int> uniqueClassified,
      Value<int> newDiscoveries,
      Value<String> cefrDistributionJson,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BlogEntriesTableUpdateCompanionBuilder =
    BlogEntriesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> content,
      Value<int> wordCount,
      Value<int> uniqueClassified,
      Value<int> newDiscoveries,
      Value<String> cefrDistributionJson,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$BlogEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $BlogEntriesTable, BlogEntryRow> {
  $$BlogEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BlogVocabularyTable, List<BlogVocabularyRow>>
  _blogVocabularyRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.blogVocabulary,
    aliasName: 'blog_entries__id__blog_vocabulary__blog_id',
  );

  $$BlogVocabularyTableProcessedTableManager get blogVocabularyRefs {
    final manager = $$BlogVocabularyTableTableManager(
      $_db,
      $_db.blogVocabulary,
    ).filter((f) => f.blogId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_blogVocabularyRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BlogEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $BlogEntriesTable> {
  $$BlogEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get uniqueClassified => $composableBuilder(
    column: $table.uniqueClassified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get newDiscoveries => $composableBuilder(
    column: $table.newDiscoveries,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cefrDistributionJson => $composableBuilder(
    column: $table.cefrDistributionJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> blogVocabularyRefs(
    Expression<bool> Function($$BlogVocabularyTableFilterComposer f) f,
  ) {
    final $$BlogVocabularyTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.blogVocabulary,
      getReferencedColumn: (t) => t.blogId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlogVocabularyTableFilterComposer(
            $db: $db,
            $table: $db.blogVocabulary,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BlogEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $BlogEntriesTable> {
  $$BlogEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wordCount => $composableBuilder(
    column: $table.wordCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get uniqueClassified => $composableBuilder(
    column: $table.uniqueClassified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get newDiscoveries => $composableBuilder(
    column: $table.newDiscoveries,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cefrDistributionJson => $composableBuilder(
    column: $table.cefrDistributionJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BlogEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BlogEntriesTable> {
  $$BlogEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get wordCount =>
      $composableBuilder(column: $table.wordCount, builder: (column) => column);

  GeneratedColumn<int> get uniqueClassified => $composableBuilder(
    column: $table.uniqueClassified,
    builder: (column) => column,
  );

  GeneratedColumn<int> get newDiscoveries => $composableBuilder(
    column: $table.newDiscoveries,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cefrDistributionJson => $composableBuilder(
    column: $table.cefrDistributionJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> blogVocabularyRefs<T extends Object>(
    Expression<T> Function($$BlogVocabularyTableAnnotationComposer a) f,
  ) {
    final $$BlogVocabularyTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.blogVocabulary,
      getReferencedColumn: (t) => t.blogId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlogVocabularyTableAnnotationComposer(
            $db: $db,
            $table: $db.blogVocabulary,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BlogEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BlogEntriesTable,
          BlogEntryRow,
          $$BlogEntriesTableFilterComposer,
          $$BlogEntriesTableOrderingComposer,
          $$BlogEntriesTableAnnotationComposer,
          $$BlogEntriesTableCreateCompanionBuilder,
          $$BlogEntriesTableUpdateCompanionBuilder,
          (BlogEntryRow, $$BlogEntriesTableReferences),
          BlogEntryRow,
          PrefetchHooks Function({bool blogVocabularyRefs})
        > {
  $$BlogEntriesTableTableManager(_$AppDatabase db, $BlogEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlogEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlogEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlogEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> wordCount = const Value.absent(),
                Value<int> uniqueClassified = const Value.absent(),
                Value<int> newDiscoveries = const Value.absent(),
                Value<String> cefrDistributionJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BlogEntriesCompanion(
                id: id,
                title: title,
                content: content,
                wordCount: wordCount,
                uniqueClassified: uniqueClassified,
                newDiscoveries: newDiscoveries,
                cefrDistributionJson: cefrDistributionJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String content,
                Value<int> wordCount = const Value.absent(),
                Value<int> uniqueClassified = const Value.absent(),
                Value<int> newDiscoveries = const Value.absent(),
                Value<String> cefrDistributionJson = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BlogEntriesCompanion.insert(
                id: id,
                title: title,
                content: content,
                wordCount: wordCount,
                uniqueClassified: uniqueClassified,
                newDiscoveries: newDiscoveries,
                cefrDistributionJson: cefrDistributionJson,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BlogEntriesTable, BlogEntryRow>(table),
                  $$BlogEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({blogVocabularyRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (blogVocabularyRefs) db.blogVocabulary,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (blogVocabularyRefs)
                    await $_getPrefetchedData<
                      BlogEntryRow,
                      $BlogEntriesTable,
                      BlogVocabularyRow
                    >(
                      currentTable: table,
                      referencedTable: $$BlogEntriesTableReferences
                          ._blogVocabularyRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BlogEntriesTableReferences(
                            db,
                            table,
                            p0,
                          ).blogVocabularyRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.blogId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BlogEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BlogEntriesTable,
      BlogEntryRow,
      $$BlogEntriesTableFilterComposer,
      $$BlogEntriesTableOrderingComposer,
      $$BlogEntriesTableAnnotationComposer,
      $$BlogEntriesTableCreateCompanionBuilder,
      $$BlogEntriesTableUpdateCompanionBuilder,
      (BlogEntryRow, $$BlogEntriesTableReferences),
      BlogEntryRow,
      PrefetchHooks Function({bool blogVocabularyRefs})
    >;
typedef $$BlogVocabularyTableCreateCompanionBuilder =
    BlogVocabularyCompanion Function({
      required String blogId,
      required String entryId,
      Value<int> occurrences,
      Value<int> rowid,
    });
typedef $$BlogVocabularyTableUpdateCompanionBuilder =
    BlogVocabularyCompanion Function({
      Value<String> blogId,
      Value<String> entryId,
      Value<int> occurrences,
      Value<int> rowid,
    });

final class $$BlogVocabularyTableReferences
    extends
        BaseReferences<_$AppDatabase, $BlogVocabularyTable, BlogVocabularyRow> {
  $$BlogVocabularyTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BlogEntriesTable _blogIdTable(_$AppDatabase db) =>
      db.blogEntries.createAlias('blog_vocabulary__blog_id__blog_entries__id');

  $$BlogEntriesTableProcessedTableManager get blogId {
    final $_column = $_itemColumn<String>('blog_id')!;

    final manager = $$BlogEntriesTableTableManager(
      $_db,
      $_db.blogEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_blogIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $VocabularyEntriesTable _entryIdTable(_$AppDatabase db) => db
      .vocabularyEntries
      .createAlias('blog_vocabulary__entry_id__vocabulary_entries__id');

  $$VocabularyEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager = $$VocabularyEntriesTableTableManager(
      $_db,
      $_db.vocabularyEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BlogVocabularyTableFilterComposer
    extends Composer<_$AppDatabase, $BlogVocabularyTable> {
  $$BlogVocabularyTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get occurrences => $composableBuilder(
    column: $table.occurrences,
    builder: (column) => ColumnFilters(column),
  );

  $$BlogEntriesTableFilterComposer get blogId {
    final $$BlogEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blogId,
      referencedTable: $db.blogEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlogEntriesTableFilterComposer(
            $db: $db,
            $table: $db.blogEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VocabularyEntriesTableFilterComposer get entryId {
    final $$VocabularyEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.vocabularyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyEntriesTableFilterComposer(
            $db: $db,
            $table: $db.vocabularyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BlogVocabularyTableOrderingComposer
    extends Composer<_$AppDatabase, $BlogVocabularyTable> {
  $$BlogVocabularyTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get occurrences => $composableBuilder(
    column: $table.occurrences,
    builder: (column) => ColumnOrderings(column),
  );

  $$BlogEntriesTableOrderingComposer get blogId {
    final $$BlogEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blogId,
      referencedTable: $db.blogEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlogEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.blogEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VocabularyEntriesTableOrderingComposer get entryId {
    final $$VocabularyEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.vocabularyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.vocabularyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BlogVocabularyTableAnnotationComposer
    extends Composer<_$AppDatabase, $BlogVocabularyTable> {
  $$BlogVocabularyTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get occurrences => $composableBuilder(
    column: $table.occurrences,
    builder: (column) => column,
  );

  $$BlogEntriesTableAnnotationComposer get blogId {
    final $$BlogEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.blogId,
      referencedTable: $db.blogEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BlogEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.blogEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$VocabularyEntriesTableAnnotationComposer get entryId {
    final $$VocabularyEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.entryId,
          referencedTable: $db.vocabularyEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VocabularyEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.vocabularyEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$BlogVocabularyTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BlogVocabularyTable,
          BlogVocabularyRow,
          $$BlogVocabularyTableFilterComposer,
          $$BlogVocabularyTableOrderingComposer,
          $$BlogVocabularyTableAnnotationComposer,
          $$BlogVocabularyTableCreateCompanionBuilder,
          $$BlogVocabularyTableUpdateCompanionBuilder,
          (BlogVocabularyRow, $$BlogVocabularyTableReferences),
          BlogVocabularyRow,
          PrefetchHooks Function({bool blogId, bool entryId})
        > {
  $$BlogVocabularyTableTableManager(
    _$AppDatabase db,
    $BlogVocabularyTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlogVocabularyTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlogVocabularyTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlogVocabularyTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> blogId = const Value.absent(),
                Value<String> entryId = const Value.absent(),
                Value<int> occurrences = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BlogVocabularyCompanion(
                blogId: blogId,
                entryId: entryId,
                occurrences: occurrences,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String blogId,
                required String entryId,
                Value<int> occurrences = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BlogVocabularyCompanion.insert(
                blogId: blogId,
                entryId: entryId,
                occurrences: occurrences,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BlogVocabularyTable, BlogVocabularyRow>(table),
                  $$BlogVocabularyTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({blogId = false, entryId = false}) {
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
                    if (blogId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.blogId,
                        referencedTable: $$BlogVocabularyTableReferences
                            ._blogIdTable(db),
                        referencedColumn: $$BlogVocabularyTableReferences
                            ._blogIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (entryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.entryId,
                        referencedTable: $$BlogVocabularyTableReferences
                            ._entryIdTable(db),
                        referencedColumn: $$BlogVocabularyTableReferences
                            ._entryIdTable(db)
                            .id,
                      ) as T;
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

typedef $$BlogVocabularyTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BlogVocabularyTable,
      BlogVocabularyRow,
      $$BlogVocabularyTableFilterComposer,
      $$BlogVocabularyTableOrderingComposer,
      $$BlogVocabularyTableAnnotationComposer,
      $$BlogVocabularyTableCreateCompanionBuilder,
      $$BlogVocabularyTableUpdateCompanionBuilder,
      (BlogVocabularyRow, $$BlogVocabularyTableReferences),
      BlogVocabularyRow,
      PrefetchHooks Function({bool blogId, bool entryId})
    >;
typedef $$VocabularyEntryRanksTableCreateCompanionBuilder =
    VocabularyEntryRanksCompanion Function({
      required String entryId,
      Value<int?> frequencyRank,
      Value<int?> generalImportance,
      Value<int?> spokenRelevance,
      Value<int?> newsRelevance,
      Value<int?> academicRank,
      Value<int> rowid,
    });
typedef $$VocabularyEntryRanksTableUpdateCompanionBuilder =
    VocabularyEntryRanksCompanion Function({
      Value<String> entryId,
      Value<int?> frequencyRank,
      Value<int?> generalImportance,
      Value<int?> spokenRelevance,
      Value<int?> newsRelevance,
      Value<int?> academicRank,
      Value<int> rowid,
    });

final class $$VocabularyEntryRanksTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $VocabularyEntryRanksTable,
          VocabularyEntryRankRow
        > {
  $$VocabularyEntryRanksTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VocabularyEntriesTable _entryIdTable(_$AppDatabase db) => db
      .vocabularyEntries
      .createAlias('vocabulary_entry_ranks__entry_id__vocabulary_entries__id');

  $$VocabularyEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager = $$VocabularyEntriesTableTableManager(
      $_db,
      $_db.vocabularyEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VocabularyEntryRanksTableFilterComposer
    extends Composer<_$AppDatabase, $VocabularyEntryRanksTable> {
  $$VocabularyEntryRanksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get frequencyRank => $composableBuilder(
    column: $table.frequencyRank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get generalImportance => $composableBuilder(
    column: $table.generalImportance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get spokenRelevance => $composableBuilder(
    column: $table.spokenRelevance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get newsRelevance => $composableBuilder(
    column: $table.newsRelevance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get academicRank => $composableBuilder(
    column: $table.academicRank,
    builder: (column) => ColumnFilters(column),
  );

  $$VocabularyEntriesTableFilterComposer get entryId {
    final $$VocabularyEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.vocabularyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyEntriesTableFilterComposer(
            $db: $db,
            $table: $db.vocabularyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabularyEntryRanksTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabularyEntryRanksTable> {
  $$VocabularyEntryRanksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get frequencyRank => $composableBuilder(
    column: $table.frequencyRank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get generalImportance => $composableBuilder(
    column: $table.generalImportance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get spokenRelevance => $composableBuilder(
    column: $table.spokenRelevance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get newsRelevance => $composableBuilder(
    column: $table.newsRelevance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get academicRank => $composableBuilder(
    column: $table.academicRank,
    builder: (column) => ColumnOrderings(column),
  );

  $$VocabularyEntriesTableOrderingComposer get entryId {
    final $$VocabularyEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.vocabularyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.vocabularyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabularyEntryRanksTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabularyEntryRanksTable> {
  $$VocabularyEntryRanksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get frequencyRank => $composableBuilder(
    column: $table.frequencyRank,
    builder: (column) => column,
  );

  GeneratedColumn<int> get generalImportance => $composableBuilder(
    column: $table.generalImportance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get spokenRelevance => $composableBuilder(
    column: $table.spokenRelevance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get newsRelevance => $composableBuilder(
    column: $table.newsRelevance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get academicRank => $composableBuilder(
    column: $table.academicRank,
    builder: (column) => column,
  );

  $$VocabularyEntriesTableAnnotationComposer get entryId {
    final $$VocabularyEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.entryId,
          referencedTable: $db.vocabularyEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VocabularyEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.vocabularyEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$VocabularyEntryRanksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VocabularyEntryRanksTable,
          VocabularyEntryRankRow,
          $$VocabularyEntryRanksTableFilterComposer,
          $$VocabularyEntryRanksTableOrderingComposer,
          $$VocabularyEntryRanksTableAnnotationComposer,
          $$VocabularyEntryRanksTableCreateCompanionBuilder,
          $$VocabularyEntryRanksTableUpdateCompanionBuilder,
          (VocabularyEntryRankRow, $$VocabularyEntryRanksTableReferences),
          VocabularyEntryRankRow,
          PrefetchHooks Function({bool entryId})
        > {
  $$VocabularyEntryRanksTableTableManager(
    _$AppDatabase db,
    $VocabularyEntryRanksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabularyEntryRanksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabularyEntryRanksTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$VocabularyEntryRanksTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> entryId = const Value.absent(),
                Value<int?> frequencyRank = const Value.absent(),
                Value<int?> generalImportance = const Value.absent(),
                Value<int?> spokenRelevance = const Value.absent(),
                Value<int?> newsRelevance = const Value.absent(),
                Value<int?> academicRank = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabularyEntryRanksCompanion(
                entryId: entryId,
                frequencyRank: frequencyRank,
                generalImportance: generalImportance,
                spokenRelevance: spokenRelevance,
                newsRelevance: newsRelevance,
                academicRank: academicRank,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String entryId,
                Value<int?> frequencyRank = const Value.absent(),
                Value<int?> generalImportance = const Value.absent(),
                Value<int?> spokenRelevance = const Value.absent(),
                Value<int?> newsRelevance = const Value.absent(),
                Value<int?> academicRank = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabularyEntryRanksCompanion.insert(
                entryId: entryId,
                frequencyRank: frequencyRank,
                generalImportance: generalImportance,
                spokenRelevance: spokenRelevance,
                newsRelevance: newsRelevance,
                academicRank: academicRank,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $VocabularyEntryRanksTable,
                    VocabularyEntryRankRow
                  >(table),
                  $$VocabularyEntryRanksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false}) {
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
                    if (entryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.entryId,
                        referencedTable: $$VocabularyEntryRanksTableReferences
                            ._entryIdTable(db),
                        referencedColumn: $$VocabularyEntryRanksTableReferences
                            ._entryIdTable(db)
                            .id,
                      ) as T;
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

typedef $$VocabularyEntryRanksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VocabularyEntryRanksTable,
      VocabularyEntryRankRow,
      $$VocabularyEntryRanksTableFilterComposer,
      $$VocabularyEntryRanksTableOrderingComposer,
      $$VocabularyEntryRanksTableAnnotationComposer,
      $$VocabularyEntryRanksTableCreateCompanionBuilder,
      $$VocabularyEntryRanksTableUpdateCompanionBuilder,
      (VocabularyEntryRankRow, $$VocabularyEntryRanksTableReferences),
      VocabularyEntryRankRow,
      PrefetchHooks Function({bool entryId})
    >;
typedef $$TopicGroupsTableCreateCompanionBuilder =
    TopicGroupsCompanion Function({
      required String id,
      required String nameEn,
      required String nameAr,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$TopicGroupsTableUpdateCompanionBuilder =
    TopicGroupsCompanion Function({
      Value<String> id,
      Value<String> nameEn,
      Value<String> nameAr,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$TopicGroupsTableReferences
    extends BaseReferences<_$AppDatabase, $TopicGroupsTable, TopicGroupRow> {
  $$TopicGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TopicsTable, List<TopicRow>> _topicsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.topics,
    aliasName: 'topic_groups__id__topics__group_id',
  );

  $$TopicsTableProcessedTableManager get topicsRefs {
    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_topicsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TopicGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $TopicGroupsTable> {
  $$TopicGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> topicsRefs(
    Expression<bool> Function($$TopicsTableFilterComposer f) f,
  ) {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $TopicGroupsTable> {
  $$TopicGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TopicGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopicGroupsTable> {
  $$TopicGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> topicsRefs<T extends Object>(
    Expression<T> Function($$TopicsTableAnnotationComposer a) f,
  ) {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TopicGroupsTable,
          TopicGroupRow,
          $$TopicGroupsTableFilterComposer,
          $$TopicGroupsTableOrderingComposer,
          $$TopicGroupsTableAnnotationComposer,
          $$TopicGroupsTableCreateCompanionBuilder,
          $$TopicGroupsTableUpdateCompanionBuilder,
          (TopicGroupRow, $$TopicGroupsTableReferences),
          TopicGroupRow,
          PrefetchHooks Function({bool topicsRefs})
        > {
  $$TopicGroupsTableTableManager(_$AppDatabase db, $TopicGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameAr = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicGroupsCompanion(
                id: id,
                nameEn: nameEn,
                nameAr: nameAr,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nameEn,
                required String nameAr,
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicGroupsCompanion.insert(
                id: id,
                nameEn: nameEn,
                nameAr: nameAr,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TopicGroupsTable, TopicGroupRow>(table),
                  $$TopicGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({topicsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (topicsRefs) db.topics],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (topicsRefs)
                    await $_getPrefetchedData<
                      TopicGroupRow,
                      $TopicGroupsTable,
                      TopicRow
                    >(
                      currentTable: table,
                      referencedTable: $$TopicGroupsTableReferences
                          ._topicsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TopicGroupsTableReferences(
                            db,
                            table,
                            p0,
                          ).topicsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TopicGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TopicGroupsTable,
      TopicGroupRow,
      $$TopicGroupsTableFilterComposer,
      $$TopicGroupsTableOrderingComposer,
      $$TopicGroupsTableAnnotationComposer,
      $$TopicGroupsTableCreateCompanionBuilder,
      $$TopicGroupsTableUpdateCompanionBuilder,
      (TopicGroupRow, $$TopicGroupsTableReferences),
      TopicGroupRow,
      PrefetchHooks Function({bool topicsRefs})
    >;
typedef $$TopicsTableCreateCompanionBuilder = TopicsCompanion Function({
  required String id,
  required String slug,
  required String groupId,
  required String nameEn,
  required String nameAr,
  required String descriptionEn,
  required String descriptionAr,
  required String iconKey,
  Value<int> sortOrder,
  Value<bool> enabled,
  Value<int> rowid,
});
typedef $$TopicsTableUpdateCompanionBuilder = TopicsCompanion Function({
  Value<String> id,
  Value<String> slug,
  Value<String> groupId,
  Value<String> nameEn,
  Value<String> nameAr,
  Value<String> descriptionEn,
  Value<String> descriptionAr,
  Value<String> iconKey,
  Value<int> sortOrder,
  Value<bool> enabled,
  Value<int> rowid,
});

final class $$TopicsTableReferences
    extends BaseReferences<_$AppDatabase, $TopicsTable, TopicRow> {
  $$TopicsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TopicGroupsTable _groupIdTable(_$AppDatabase db) =>
      db.topicGroups.createAlias('topics__group_id__topic_groups__id');

  $$TopicGroupsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<String>('group_id')!;

    final manager = $$TopicGroupsTableTableManager(
      $_db,
      $_db.topicGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$VocabularyTopicsTable, List<VocabularyTopicRow>>
  _vocabularyTopicsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vocabularyTopics,
    aliasName: 'topics__id__vocabulary_topics__topic_id',
  );

  $$VocabularyTopicsTableProcessedTableManager get vocabularyTopicsRefs {
    final manager = $$VocabularyTopicsTableTableManager(
      $_db,
      $_db.vocabularyTopics,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vocabularyTopicsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TopicSentenceTopicsTable,
    List<TopicSentenceTopicRow>
  >
  _topicSentenceTopicsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.topicSentenceTopics,
        aliasName: 'topics__id__topic_sentence_topics__topic_id',
      );

  $$TopicSentenceTopicsTableProcessedTableManager get topicSentenceTopicsRefs {
    final manager = $$TopicSentenceTopicsTableTableManager(
      $_db,
      $_db.topicSentenceTopics,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _topicSentenceTopicsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LearningPathTopicsTable,
    List<LearningPathTopicRow>
  >
  _learningPathTopicsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.learningPathTopics,
        aliasName: 'topics__id__learning_path_topics__topic_id',
      );

  $$LearningPathTopicsTableProcessedTableManager get learningPathTopicsRefs {
    final manager = $$LearningPathTopicsTableTableManager(
      $_db,
      $_db.learningPathTopics,
    ).filter((f) => f.topicId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _learningPathTopicsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TopicsTableFilterComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionAr => $composableBuilder(
    column: $table.descriptionAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  $$TopicGroupsTableFilterComposer get groupId {
    final $$TopicGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.topicGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicGroupsTableFilterComposer(
            $db: $db,
            $table: $db.topicGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> vocabularyTopicsRefs(
    Expression<bool> Function($$VocabularyTopicsTableFilterComposer f) f,
  ) {
    final $$VocabularyTopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabularyTopics,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyTopicsTableFilterComposer(
            $db: $db,
            $table: $db.vocabularyTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> topicSentenceTopicsRefs(
    Expression<bool> Function($$TopicSentenceTopicsTableFilterComposer f) f,
  ) {
    final $$TopicSentenceTopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topicSentenceTopics,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicSentenceTopicsTableFilterComposer(
            $db: $db,
            $table: $db.topicSentenceTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> learningPathTopicsRefs(
    Expression<bool> Function($$LearningPathTopicsTableFilterComposer f) f,
  ) {
    final $$LearningPathTopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningPathTopics,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningPathTopicsTableFilterComposer(
            $db: $db,
            $table: $db.learningPathTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionAr => $composableBuilder(
    column: $table.descriptionAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconKey => $composableBuilder(
    column: $table.iconKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  $$TopicGroupsTableOrderingComposer get groupId {
    final $$TopicGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.topicGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.topicGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopicsTable> {
  $$TopicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionAr => $composableBuilder(
    column: $table.descriptionAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconKey =>
      $composableBuilder(column: $table.iconKey, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  $$TopicGroupsTableAnnotationComposer get groupId {
    final $$TopicGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.topicGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.topicGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> vocabularyTopicsRefs<T extends Object>(
    Expression<T> Function($$VocabularyTopicsTableAnnotationComposer a) f,
  ) {
    final $$VocabularyTopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vocabularyTopics,
      getReferencedColumn: (t) => t.topicId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyTopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.vocabularyTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> topicSentenceTopicsRefs<T extends Object>(
    Expression<T> Function($$TopicSentenceTopicsTableAnnotationComposer a) f,
  ) {
    final $$TopicSentenceTopicsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.topicSentenceTopics,
          getReferencedColumn: (t) => t.topicId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TopicSentenceTopicsTableAnnotationComposer(
                $db: $db,
                $table: $db.topicSentenceTopics,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> learningPathTopicsRefs<T extends Object>(
    Expression<T> Function($$LearningPathTopicsTableAnnotationComposer a) f,
  ) {
    final $$LearningPathTopicsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.learningPathTopics,
          getReferencedColumn: (t) => t.topicId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearningPathTopicsTableAnnotationComposer(
                $db: $db,
                $table: $db.learningPathTopics,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TopicsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TopicsTable,
          TopicRow,
          $$TopicsTableFilterComposer,
          $$TopicsTableOrderingComposer,
          $$TopicsTableAnnotationComposer,
          $$TopicsTableCreateCompanionBuilder,
          $$TopicsTableUpdateCompanionBuilder,
          (TopicRow, $$TopicsTableReferences),
          TopicRow,
          PrefetchHooks Function({
            bool groupId,
            bool vocabularyTopicsRefs,
            bool topicSentenceTopicsRefs,
            bool learningPathTopicsRefs,
          })
        > {
  $$TopicsTableTableManager(_$AppDatabase db, $TopicsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> groupId = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameAr = const Value.absent(),
                Value<String> descriptionEn = const Value.absent(),
                Value<String> descriptionAr = const Value.absent(),
                Value<String> iconKey = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicsCompanion(
                id: id,
                slug: slug,
                groupId: groupId,
                nameEn: nameEn,
                nameAr: nameAr,
                descriptionEn: descriptionEn,
                descriptionAr: descriptionAr,
                iconKey: iconKey,
                sortOrder: sortOrder,
                enabled: enabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String slug,
                required String groupId,
                required String nameEn,
                required String nameAr,
                required String descriptionEn,
                required String descriptionAr,
                required String iconKey,
                Value<int> sortOrder = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicsCompanion.insert(
                id: id,
                slug: slug,
                groupId: groupId,
                nameEn: nameEn,
                nameAr: nameAr,
                descriptionEn: descriptionEn,
                descriptionAr: descriptionAr,
                iconKey: iconKey,
                sortOrder: sortOrder,
                enabled: enabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TopicsTable, TopicRow>(table),
                  $$TopicsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                groupId = false,
                vocabularyTopicsRefs = false,
                topicSentenceTopicsRefs = false,
                learningPathTopicsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (vocabularyTopicsRefs) db.vocabularyTopics,
                    if (topicSentenceTopicsRefs) db.topicSentenceTopics,
                    if (learningPathTopicsRefs) db.learningPathTopics,
                  ],
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
                        if (groupId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.groupId,
                            referencedTable: $$TopicsTableReferences
                                ._groupIdTable(db),
                            referencedColumn: $$TopicsTableReferences
                                ._groupIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (vocabularyTopicsRefs)
                        await $_getPrefetchedData<
                          TopicRow,
                          $TopicsTable,
                          VocabularyTopicRow
                        >(
                          currentTable: table,
                          referencedTable: $$TopicsTableReferences
                              ._vocabularyTopicsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).vocabularyTopicsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.topicId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (topicSentenceTopicsRefs)
                        await $_getPrefetchedData<
                          TopicRow,
                          $TopicsTable,
                          TopicSentenceTopicRow
                        >(
                          currentTable: table,
                          referencedTable: $$TopicsTableReferences
                              ._topicSentenceTopicsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).topicSentenceTopicsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.topicId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (learningPathTopicsRefs)
                        await $_getPrefetchedData<
                          TopicRow,
                          $TopicsTable,
                          LearningPathTopicRow
                        >(
                          currentTable: table,
                          referencedTable: $$TopicsTableReferences
                              ._learningPathTopicsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TopicsTableReferences(
                                db,
                                table,
                                p0,
                              ).learningPathTopicsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.topicId == item.id,
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

typedef $$TopicsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TopicsTable,
      TopicRow,
      $$TopicsTableFilterComposer,
      $$TopicsTableOrderingComposer,
      $$TopicsTableAnnotationComposer,
      $$TopicsTableCreateCompanionBuilder,
      $$TopicsTableUpdateCompanionBuilder,
      (TopicRow, $$TopicsTableReferences),
      TopicRow,
      PrefetchHooks Function({
        bool groupId,
        bool vocabularyTopicsRefs,
        bool topicSentenceTopicsRefs,
        bool learningPathTopicsRefs,
      })
    >;
typedef $$VocabularyTopicsTableCreateCompanionBuilder =
    VocabularyTopicsCompanion Function({
      required String entryId,
      required String topicId,
      required String relevance,
      required int weight,
      Value<int> rowid,
    });
typedef $$VocabularyTopicsTableUpdateCompanionBuilder =
    VocabularyTopicsCompanion Function({
      Value<String> entryId,
      Value<String> topicId,
      Value<String> relevance,
      Value<int> weight,
      Value<int> rowid,
    });

final class $$VocabularyTopicsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $VocabularyTopicsTable,
          VocabularyTopicRow
        > {
  $$VocabularyTopicsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VocabularyEntriesTable _entryIdTable(_$AppDatabase db) => db
      .vocabularyEntries
      .createAlias('vocabulary_topics__entry_id__vocabulary_entries__id');

  $$VocabularyEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager = $$VocabularyEntriesTableTableManager(
      $_db,
      $_db.vocabularyEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TopicsTable _topicIdTable(_$AppDatabase db) =>
      db.topics.createAlias('vocabulary_topics__topic_id__topics__id');

  $$TopicsTableProcessedTableManager get topicId {
    final $_column = $_itemColumn<String>('topic_id')!;

    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VocabularyTopicsTableFilterComposer
    extends Composer<_$AppDatabase, $VocabularyTopicsTable> {
  $$VocabularyTopicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get relevance => $composableBuilder(
    column: $table.relevance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  $$VocabularyEntriesTableFilterComposer get entryId {
    final $$VocabularyEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.vocabularyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyEntriesTableFilterComposer(
            $db: $db,
            $table: $db.vocabularyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabularyTopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabularyTopicsTable> {
  $$VocabularyTopicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get relevance => $composableBuilder(
    column: $table.relevance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  $$VocabularyEntriesTableOrderingComposer get entryId {
    final $$VocabularyEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.vocabularyEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VocabularyEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.vocabularyEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabularyTopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabularyTopicsTable> {
  $$VocabularyTopicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get relevance =>
      $composableBuilder(column: $table.relevance, builder: (column) => column);

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  $$VocabularyEntriesTableAnnotationComposer get entryId {
    final $$VocabularyEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.entryId,
          referencedTable: $db.vocabularyEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VocabularyEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.vocabularyEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VocabularyTopicsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VocabularyTopicsTable,
          VocabularyTopicRow,
          $$VocabularyTopicsTableFilterComposer,
          $$VocabularyTopicsTableOrderingComposer,
          $$VocabularyTopicsTableAnnotationComposer,
          $$VocabularyTopicsTableCreateCompanionBuilder,
          $$VocabularyTopicsTableUpdateCompanionBuilder,
          (VocabularyTopicRow, $$VocabularyTopicsTableReferences),
          VocabularyTopicRow,
          PrefetchHooks Function({bool entryId, bool topicId})
        > {
  $$VocabularyTopicsTableTableManager(
    _$AppDatabase db,
    $VocabularyTopicsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabularyTopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabularyTopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabularyTopicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> entryId = const Value.absent(),
                Value<String> topicId = const Value.absent(),
                Value<String> relevance = const Value.absent(),
                Value<int> weight = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VocabularyTopicsCompanion(
                entryId: entryId,
                topicId: topicId,
                relevance: relevance,
                weight: weight,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String entryId,
                required String topicId,
                required String relevance,
                required int weight,
                Value<int> rowid = const Value.absent(),
              }) => VocabularyTopicsCompanion.insert(
                entryId: entryId,
                topicId: topicId,
                relevance: relevance,
                weight: weight,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$VocabularyTopicsTable, VocabularyTopicRow>(
                    table,
                  ),
                  $$VocabularyTopicsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false, topicId = false}) {
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
                    if (entryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.entryId,
                        referencedTable: $$VocabularyTopicsTableReferences
                            ._entryIdTable(db),
                        referencedColumn: $$VocabularyTopicsTableReferences
                            ._entryIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (topicId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.topicId,
                        referencedTable: $$VocabularyTopicsTableReferences
                            ._topicIdTable(db),
                        referencedColumn: $$VocabularyTopicsTableReferences
                            ._topicIdTable(db)
                            .id,
                      ) as T;
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

typedef $$VocabularyTopicsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VocabularyTopicsTable,
      VocabularyTopicRow,
      $$VocabularyTopicsTableFilterComposer,
      $$VocabularyTopicsTableOrderingComposer,
      $$VocabularyTopicsTableAnnotationComposer,
      $$VocabularyTopicsTableCreateCompanionBuilder,
      $$VocabularyTopicsTableUpdateCompanionBuilder,
      (VocabularyTopicRow, $$VocabularyTopicsTableReferences),
      VocabularyTopicRow,
      PrefetchHooks Function({bool entryId, bool topicId})
    >;
typedef $$TopicSentencesTableCreateCompanionBuilder =
    TopicSentencesCompanion Function({
      required String id,
      required String sentenceEn,
      required String sentenceAr,
      required String cefrLevel,
      Value<int> sortOrder,
      Value<bool> enabled,
      Value<int> rowid,
    });
typedef $$TopicSentencesTableUpdateCompanionBuilder =
    TopicSentencesCompanion Function({
      Value<String> id,
      Value<String> sentenceEn,
      Value<String> sentenceAr,
      Value<String> cefrLevel,
      Value<int> sortOrder,
      Value<bool> enabled,
      Value<int> rowid,
    });

final class $$TopicSentencesTableReferences
    extends
        BaseReferences<_$AppDatabase, $TopicSentencesTable, TopicSentenceRow> {
  $$TopicSentencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $TopicSentenceTopicsTable,
    List<TopicSentenceTopicRow>
  >
  _topicSentenceTopicsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.topicSentenceTopics,
        aliasName: 'topic_sentences__id__topic_sentence_topics__sentence_id',
      );

  $$TopicSentenceTopicsTableProcessedTableManager get topicSentenceTopicsRefs {
    final manager = $$TopicSentenceTopicsTableTableManager(
      $_db,
      $_db.topicSentenceTopics,
    ).filter((f) => f.sentenceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _topicSentenceTopicsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TopicSentencesTableFilterComposer
    extends Composer<_$AppDatabase, $TopicSentencesTable> {
  $$TopicSentencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sentenceEn => $composableBuilder(
    column: $table.sentenceEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sentenceAr => $composableBuilder(
    column: $table.sentenceAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> topicSentenceTopicsRefs(
    Expression<bool> Function($$TopicSentenceTopicsTableFilterComposer f) f,
  ) {
    final $$TopicSentenceTopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.topicSentenceTopics,
      getReferencedColumn: (t) => t.sentenceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicSentenceTopicsTableFilterComposer(
            $db: $db,
            $table: $db.topicSentenceTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TopicSentencesTableOrderingComposer
    extends Composer<_$AppDatabase, $TopicSentencesTable> {
  $$TopicSentencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sentenceEn => $composableBuilder(
    column: $table.sentenceEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sentenceAr => $composableBuilder(
    column: $table.sentenceAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cefrLevel => $composableBuilder(
    column: $table.cefrLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TopicSentencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopicSentencesTable> {
  $$TopicSentencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sentenceEn => $composableBuilder(
    column: $table.sentenceEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sentenceAr => $composableBuilder(
    column: $table.sentenceAr,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cefrLevel =>
      $composableBuilder(column: $table.cefrLevel, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  Expression<T> topicSentenceTopicsRefs<T extends Object>(
    Expression<T> Function($$TopicSentenceTopicsTableAnnotationComposer a) f,
  ) {
    final $$TopicSentenceTopicsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.topicSentenceTopics,
          getReferencedColumn: (t) => t.sentenceId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TopicSentenceTopicsTableAnnotationComposer(
                $db: $db,
                $table: $db.topicSentenceTopics,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TopicSentencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TopicSentencesTable,
          TopicSentenceRow,
          $$TopicSentencesTableFilterComposer,
          $$TopicSentencesTableOrderingComposer,
          $$TopicSentencesTableAnnotationComposer,
          $$TopicSentencesTableCreateCompanionBuilder,
          $$TopicSentencesTableUpdateCompanionBuilder,
          (TopicSentenceRow, $$TopicSentencesTableReferences),
          TopicSentenceRow,
          PrefetchHooks Function({bool topicSentenceTopicsRefs})
        > {
  $$TopicSentencesTableTableManager(
    _$AppDatabase db,
    $TopicSentencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicSentencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicSentencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TopicSentencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sentenceEn = const Value.absent(),
                Value<String> sentenceAr = const Value.absent(),
                Value<String> cefrLevel = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicSentencesCompanion(
                id: id,
                sentenceEn: sentenceEn,
                sentenceAr: sentenceAr,
                cefrLevel: cefrLevel,
                sortOrder: sortOrder,
                enabled: enabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sentenceEn,
                required String sentenceAr,
                required String cefrLevel,
                Value<int> sortOrder = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicSentencesCompanion.insert(
                id: id,
                sentenceEn: sentenceEn,
                sentenceAr: sentenceAr,
                cefrLevel: cefrLevel,
                sortOrder: sortOrder,
                enabled: enabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TopicSentencesTable, TopicSentenceRow>(table),
                  $$TopicSentencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({topicSentenceTopicsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (topicSentenceTopicsRefs) db.topicSentenceTopics,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (topicSentenceTopicsRefs)
                    await $_getPrefetchedData<
                      TopicSentenceRow,
                      $TopicSentencesTable,
                      TopicSentenceTopicRow
                    >(
                      currentTable: table,
                      referencedTable: $$TopicSentencesTableReferences
                          ._topicSentenceTopicsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TopicSentencesTableReferences(
                            db,
                            table,
                            p0,
                          ).topicSentenceTopicsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sentenceId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TopicSentencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TopicSentencesTable,
      TopicSentenceRow,
      $$TopicSentencesTableFilterComposer,
      $$TopicSentencesTableOrderingComposer,
      $$TopicSentencesTableAnnotationComposer,
      $$TopicSentencesTableCreateCompanionBuilder,
      $$TopicSentencesTableUpdateCompanionBuilder,
      (TopicSentenceRow, $$TopicSentencesTableReferences),
      TopicSentenceRow,
      PrefetchHooks Function({bool topicSentenceTopicsRefs})
    >;
typedef $$TopicSentenceTopicsTableCreateCompanionBuilder =
    TopicSentenceTopicsCompanion Function({
      required String sentenceId,
      required String topicId,
      Value<int> rowid,
    });
typedef $$TopicSentenceTopicsTableUpdateCompanionBuilder =
    TopicSentenceTopicsCompanion Function({
      Value<String> sentenceId,
      Value<String> topicId,
      Value<int> rowid,
    });

final class $$TopicSentenceTopicsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TopicSentenceTopicsTable,
          TopicSentenceTopicRow
        > {
  $$TopicSentenceTopicsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TopicSentencesTable _sentenceIdTable(_$AppDatabase db) => db
      .topicSentences
      .createAlias('topic_sentence_topics__sentence_id__topic_sentences__id');

  $$TopicSentencesTableProcessedTableManager get sentenceId {
    final $_column = $_itemColumn<String>('sentence_id')!;

    final manager = $$TopicSentencesTableTableManager(
      $_db,
      $_db.topicSentences,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sentenceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TopicsTable _topicIdTable(_$AppDatabase db) =>
      db.topics.createAlias('topic_sentence_topics__topic_id__topics__id');

  $$TopicsTableProcessedTableManager get topicId {
    final $_column = $_itemColumn<String>('topic_id')!;

    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TopicSentenceTopicsTableFilterComposer
    extends Composer<_$AppDatabase, $TopicSentenceTopicsTable> {
  $$TopicSentenceTopicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TopicSentencesTableFilterComposer get sentenceId {
    final $$TopicSentencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sentenceId,
      referencedTable: $db.topicSentences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicSentencesTableFilterComposer(
            $db: $db,
            $table: $db.topicSentences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicSentenceTopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $TopicSentenceTopicsTable> {
  $$TopicSentenceTopicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TopicSentencesTableOrderingComposer get sentenceId {
    final $$TopicSentencesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sentenceId,
      referencedTable: $db.topicSentences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicSentencesTableOrderingComposer(
            $db: $db,
            $table: $db.topicSentences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicSentenceTopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TopicSentenceTopicsTable> {
  $$TopicSentenceTopicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TopicSentencesTableAnnotationComposer get sentenceId {
    final $$TopicSentencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sentenceId,
      referencedTable: $db.topicSentences,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicSentencesTableAnnotationComposer(
            $db: $db,
            $table: $db.topicSentences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TopicSentenceTopicsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TopicSentenceTopicsTable,
          TopicSentenceTopicRow,
          $$TopicSentenceTopicsTableFilterComposer,
          $$TopicSentenceTopicsTableOrderingComposer,
          $$TopicSentenceTopicsTableAnnotationComposer,
          $$TopicSentenceTopicsTableCreateCompanionBuilder,
          $$TopicSentenceTopicsTableUpdateCompanionBuilder,
          (TopicSentenceTopicRow, $$TopicSentenceTopicsTableReferences),
          TopicSentenceTopicRow,
          PrefetchHooks Function({bool sentenceId, bool topicId})
        > {
  $$TopicSentenceTopicsTableTableManager(
    _$AppDatabase db,
    $TopicSentenceTopicsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TopicSentenceTopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TopicSentenceTopicsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TopicSentenceTopicsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> sentenceId = const Value.absent(),
                Value<String> topicId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TopicSentenceTopicsCompanion(
                sentenceId: sentenceId,
                topicId: topicId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sentenceId,
                required String topicId,
                Value<int> rowid = const Value.absent(),
              }) => TopicSentenceTopicsCompanion.insert(
                sentenceId: sentenceId,
                topicId: topicId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TopicSentenceTopicsTable, TopicSentenceTopicRow>(
                    table,
                  ),
                  $$TopicSentenceTopicsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sentenceId = false, topicId = false}) {
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
                    if (sentenceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.sentenceId,
                        referencedTable: $$TopicSentenceTopicsTableReferences
                            ._sentenceIdTable(db),
                        referencedColumn: $$TopicSentenceTopicsTableReferences
                            ._sentenceIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (topicId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.topicId,
                        referencedTable: $$TopicSentenceTopicsTableReferences
                            ._topicIdTable(db),
                        referencedColumn: $$TopicSentenceTopicsTableReferences
                            ._topicIdTable(db)
                            .id,
                      ) as T;
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

typedef $$TopicSentenceTopicsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TopicSentenceTopicsTable,
      TopicSentenceTopicRow,
      $$TopicSentenceTopicsTableFilterComposer,
      $$TopicSentenceTopicsTableOrderingComposer,
      $$TopicSentenceTopicsTableAnnotationComposer,
      $$TopicSentenceTopicsTableCreateCompanionBuilder,
      $$TopicSentenceTopicsTableUpdateCompanionBuilder,
      (TopicSentenceTopicRow, $$TopicSentenceTopicsTableReferences),
      TopicSentenceTopicRow,
      PrefetchHooks Function({bool sentenceId, bool topicId})
    >;
typedef $$LearningPathsTableCreateCompanionBuilder =
    LearningPathsCompanion Function({
      required String id,
      required String slug,
      required String nameEn,
      required String nameAr,
      required String descriptionEn,
      required String descriptionAr,
      Value<int> sortOrder,
      Value<bool> enabled,
      Value<int> rowid,
    });
typedef $$LearningPathsTableUpdateCompanionBuilder =
    LearningPathsCompanion Function({
      Value<String> id,
      Value<String> slug,
      Value<String> nameEn,
      Value<String> nameAr,
      Value<String> descriptionEn,
      Value<String> descriptionAr,
      Value<int> sortOrder,
      Value<bool> enabled,
      Value<int> rowid,
    });

final class $$LearningPathsTableReferences
    extends
        BaseReferences<_$AppDatabase, $LearningPathsTable, LearningPathRow> {
  $$LearningPathsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $LearningPathTopicsTable,
    List<LearningPathTopicRow>
  >
  _learningPathTopicsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.learningPathTopics,
        aliasName: 'learning_paths__id__learning_path_topics__path_id',
      );

  $$LearningPathTopicsTableProcessedTableManager get learningPathTopicsRefs {
    final manager = $$LearningPathTopicsTableTableManager(
      $_db,
      $_db.learningPathTopics,
    ).filter((f) => f.pathId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _learningPathTopicsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LearningPathsTableFilterComposer
    extends Composer<_$AppDatabase, $LearningPathsTable> {
  $$LearningPathsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionAr => $composableBuilder(
    column: $table.descriptionAr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> learningPathTopicsRefs(
    Expression<bool> Function($$LearningPathTopicsTableFilterComposer f) f,
  ) {
    final $$LearningPathTopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningPathTopics,
      getReferencedColumn: (t) => t.pathId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningPathTopicsTableFilterComposer(
            $db: $db,
            $table: $db.learningPathTopics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LearningPathsTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningPathsTable> {
  $$LearningPathsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameEn => $composableBuilder(
    column: $table.nameEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameAr => $composableBuilder(
    column: $table.nameAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionAr => $composableBuilder(
    column: $table.descriptionAr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LearningPathsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningPathsTable> {
  $$LearningPathsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get nameAr =>
      $composableBuilder(column: $table.nameAr, builder: (column) => column);

  GeneratedColumn<String> get descriptionEn => $composableBuilder(
    column: $table.descriptionEn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionAr => $composableBuilder(
    column: $table.descriptionAr,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  Expression<T> learningPathTopicsRefs<T extends Object>(
    Expression<T> Function($$LearningPathTopicsTableAnnotationComposer a) f,
  ) {
    final $$LearningPathTopicsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.learningPathTopics,
          getReferencedColumn: (t) => t.pathId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearningPathTopicsTableAnnotationComposer(
                $db: $db,
                $table: $db.learningPathTopics,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LearningPathsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningPathsTable,
          LearningPathRow,
          $$LearningPathsTableFilterComposer,
          $$LearningPathsTableOrderingComposer,
          $$LearningPathsTableAnnotationComposer,
          $$LearningPathsTableCreateCompanionBuilder,
          $$LearningPathsTableUpdateCompanionBuilder,
          (LearningPathRow, $$LearningPathsTableReferences),
          LearningPathRow,
          PrefetchHooks Function({bool learningPathTopicsRefs})
        > {
  $$LearningPathsTableTableManager(_$AppDatabase db, $LearningPathsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningPathsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningPathsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningPathsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> nameEn = const Value.absent(),
                Value<String> nameAr = const Value.absent(),
                Value<String> descriptionEn = const Value.absent(),
                Value<String> descriptionAr = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningPathsCompanion(
                id: id,
                slug: slug,
                nameEn: nameEn,
                nameAr: nameAr,
                descriptionEn: descriptionEn,
                descriptionAr: descriptionAr,
                sortOrder: sortOrder,
                enabled: enabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String slug,
                required String nameEn,
                required String nameAr,
                required String descriptionEn,
                required String descriptionAr,
                Value<int> sortOrder = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningPathsCompanion.insert(
                id: id,
                slug: slug,
                nameEn: nameEn,
                nameAr: nameAr,
                descriptionEn: descriptionEn,
                descriptionAr: descriptionAr,
                sortOrder: sortOrder,
                enabled: enabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LearningPathsTable, LearningPathRow>(table),
                  $$LearningPathsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({learningPathTopicsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (learningPathTopicsRefs) db.learningPathTopics,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (learningPathTopicsRefs)
                    await $_getPrefetchedData<
                      LearningPathRow,
                      $LearningPathsTable,
                      LearningPathTopicRow
                    >(
                      currentTable: table,
                      referencedTable: $$LearningPathsTableReferences
                          ._learningPathTopicsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$LearningPathsTableReferences(
                            db,
                            table,
                            p0,
                          ).learningPathTopicsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.pathId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$LearningPathsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningPathsTable,
      LearningPathRow,
      $$LearningPathsTableFilterComposer,
      $$LearningPathsTableOrderingComposer,
      $$LearningPathsTableAnnotationComposer,
      $$LearningPathsTableCreateCompanionBuilder,
      $$LearningPathsTableUpdateCompanionBuilder,
      (LearningPathRow, $$LearningPathsTableReferences),
      LearningPathRow,
      PrefetchHooks Function({bool learningPathTopicsRefs})
    >;
typedef $$LearningPathTopicsTableCreateCompanionBuilder =
    LearningPathTopicsCompanion Function({
      required String pathId,
      required String topicId,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$LearningPathTopicsTableUpdateCompanionBuilder =
    LearningPathTopicsCompanion Function({
      Value<String> pathId,
      Value<String> topicId,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$LearningPathTopicsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LearningPathTopicsTable,
          LearningPathTopicRow
        > {
  $$LearningPathTopicsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LearningPathsTable _pathIdTable(_$AppDatabase db) => db.learningPaths
      .createAlias('learning_path_topics__path_id__learning_paths__id');

  $$LearningPathsTableProcessedTableManager get pathId {
    final $_column = $_itemColumn<String>('path_id')!;

    final manager = $$LearningPathsTableTableManager(
      $_db,
      $_db.learningPaths,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pathIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TopicsTable _topicIdTable(_$AppDatabase db) =>
      db.topics.createAlias('learning_path_topics__topic_id__topics__id');

  $$TopicsTableProcessedTableManager get topicId {
    final $_column = $_itemColumn<String>('topic_id')!;

    final manager = $$TopicsTableTableManager(
      $_db,
      $_db.topics,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_topicIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LearningPathTopicsTableFilterComposer
    extends Composer<_$AppDatabase, $LearningPathTopicsTable> {
  $$LearningPathTopicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$LearningPathsTableFilterComposer get pathId {
    final $$LearningPathsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pathId,
      referencedTable: $db.learningPaths,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningPathsTableFilterComposer(
            $db: $db,
            $table: $db.learningPaths,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableFilterComposer get topicId {
    final $$TopicsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableFilterComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningPathTopicsTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningPathTopicsTable> {
  $$LearningPathTopicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$LearningPathsTableOrderingComposer get pathId {
    final $$LearningPathsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pathId,
      referencedTable: $db.learningPaths,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningPathsTableOrderingComposer(
            $db: $db,
            $table: $db.learningPaths,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableOrderingComposer get topicId {
    final $$TopicsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableOrderingComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningPathTopicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningPathTopicsTable> {
  $$LearningPathTopicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$LearningPathsTableAnnotationComposer get pathId {
    final $$LearningPathsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pathId,
      referencedTable: $db.learningPaths,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningPathsTableAnnotationComposer(
            $db: $db,
            $table: $db.learningPaths,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TopicsTableAnnotationComposer get topicId {
    final $$TopicsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.topicId,
      referencedTable: $db.topics,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TopicsTableAnnotationComposer(
            $db: $db,
            $table: $db.topics,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningPathTopicsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningPathTopicsTable,
          LearningPathTopicRow,
          $$LearningPathTopicsTableFilterComposer,
          $$LearningPathTopicsTableOrderingComposer,
          $$LearningPathTopicsTableAnnotationComposer,
          $$LearningPathTopicsTableCreateCompanionBuilder,
          $$LearningPathTopicsTableUpdateCompanionBuilder,
          (LearningPathTopicRow, $$LearningPathTopicsTableReferences),
          LearningPathTopicRow,
          PrefetchHooks Function({bool pathId, bool topicId})
        > {
  $$LearningPathTopicsTableTableManager(
    _$AppDatabase db,
    $LearningPathTopicsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningPathTopicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningPathTopicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningPathTopicsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> pathId = const Value.absent(),
                Value<String> topicId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningPathTopicsCompanion(
                pathId: pathId,
                topicId: topicId,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String pathId,
                required String topicId,
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningPathTopicsCompanion.insert(
                pathId: pathId,
                topicId: topicId,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LearningPathTopicsTable, LearningPathTopicRow>(
                    table,
                  ),
                  $$LearningPathTopicsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pathId = false, topicId = false}) {
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
                    if (pathId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pathId,
                        referencedTable: $$LearningPathTopicsTableReferences
                            ._pathIdTable(db),
                        referencedColumn: $$LearningPathTopicsTableReferences
                            ._pathIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (topicId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.topicId,
                        referencedTable: $$LearningPathTopicsTableReferences
                            ._topicIdTable(db),
                        referencedColumn: $$LearningPathTopicsTableReferences
                            ._topicIdTable(db)
                            .id,
                      ) as T;
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

typedef $$LearningPathTopicsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningPathTopicsTable,
      LearningPathTopicRow,
      $$LearningPathTopicsTableFilterComposer,
      $$LearningPathTopicsTableOrderingComposer,
      $$LearningPathTopicsTableAnnotationComposer,
      $$LearningPathTopicsTableCreateCompanionBuilder,
      $$LearningPathTopicsTableUpdateCompanionBuilder,
      (LearningPathTopicRow, $$LearningPathTopicsTableReferences),
      LearningPathTopicRow,
      PrefetchHooks Function({bool pathId, bool topicId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$WordsTableTableManager get words =>
      $$WordsTableTableManager(_db, _db.words);
  $$SentencePatternsTableTableManager get sentencePatterns =>
      $$SentencePatternsTableTableManager(_db, _db.sentencePatterns);
  $$SentencesTableTableManager get sentences =>
      $$SentencesTableTableManager(_db, _db.sentences);
  $$WordCategoriesTableTableManager get wordCategories =>
      $$WordCategoriesTableTableManager(_db, _db.wordCategories);
  $$SentenceCategoriesTableTableManager get sentenceCategories =>
      $$SentenceCategoriesTableTableManager(_db, _db.sentenceCategories);
  $$PatternCategoriesTableTableManager get patternCategories =>
      $$PatternCategoriesTableTableManager(_db, _db.patternCategories);
  $$SentenceWordsTableTableManager get sentenceWords =>
      $$SentenceWordsTableTableManager(_db, _db.sentenceWords);
  $$ReviewItemsTableTableManager get reviewItems =>
      $$ReviewItemsTableTableManager(_db, _db.reviewItems);
  $$ReviewHistoryTableTableManager get reviewHistory =>
      $$ReviewHistoryTableTableManager(_db, _db.reviewHistory);
  $$PronunciationCacheTableTableManager get pronunciationCache =>
      $$PronunciationCacheTableTableManager(_db, _db.pronunciationCache);
  $$LearningSessionsTableTableManager get learningSessions =>
      $$LearningSessionsTableTableManager(_db, _db.learningSessions);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
  $$AppStatisticsTableTableManager get appStatistics =>
      $$AppStatisticsTableTableManager(_db, _db.appStatistics);
  $$VocabularyEntriesTableTableManager get vocabularyEntries =>
      $$VocabularyEntriesTableTableManager(_db, _db.vocabularyEntries);
  $$VocabularyFormsTableTableManager get vocabularyForms =>
      $$VocabularyFormsTableTableManager(_db, _db.vocabularyForms);
  $$UserVocabularyTableTableManager get userVocabulary =>
      $$UserVocabularyTableTableManager(_db, _db.userVocabulary);
  $$BlogEntriesTableTableManager get blogEntries =>
      $$BlogEntriesTableTableManager(_db, _db.blogEntries);
  $$BlogVocabularyTableTableManager get blogVocabulary =>
      $$BlogVocabularyTableTableManager(_db, _db.blogVocabulary);
  $$VocabularyEntryRanksTableTableManager get vocabularyEntryRanks =>
      $$VocabularyEntryRanksTableTableManager(_db, _db.vocabularyEntryRanks);
  $$TopicGroupsTableTableManager get topicGroups =>
      $$TopicGroupsTableTableManager(_db, _db.topicGroups);
  $$TopicsTableTableManager get topics =>
      $$TopicsTableTableManager(_db, _db.topics);
  $$VocabularyTopicsTableTableManager get vocabularyTopics =>
      $$VocabularyTopicsTableTableManager(_db, _db.vocabularyTopics);
  $$TopicSentencesTableTableManager get topicSentences =>
      $$TopicSentencesTableTableManager(_db, _db.topicSentences);
  $$TopicSentenceTopicsTableTableManager get topicSentenceTopics =>
      $$TopicSentenceTopicsTableTableManager(_db, _db.topicSentenceTopics);
  $$LearningPathsTableTableManager get learningPaths =>
      $$LearningPathsTableTableManager(_db, _db.learningPaths);
  $$LearningPathTopicsTableTableManager get learningPathTopics =>
      $$LearningPathTopicsTableTableManager(_db, _db.learningPathTopics);
}
