// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CharactersCacheTable extends CharactersCache
    with TableInfo<$CharactersCacheTable, CharactersCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharactersCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speciesMeta = const VerificationMeta(
    'species',
  );
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
    'species',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localImagePathMeta = const VerificationMeta(
    'localImagePath',
  );
  @override
  late final GeneratedColumn<String> localImagePath = GeneratedColumn<String>(
    'local_image_path',
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
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    status,
    species,
    gender,
    imageUrl,
    localImagePath,
    isFavorite,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'characters_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharactersCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('species')) {
      context.handle(
        _speciesMeta,
        species.isAcceptableOrUnknown(data['species']!, _speciesMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('local_image_path')) {
      context.handle(
        _localImagePathMeta,
        localImagePath.isAcceptableOrUnknown(
          data['local_image_path']!,
          _localImagePathMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CharactersCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharactersCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      ),
      species: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      localImagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_image_path'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CharactersCacheTable createAlias(String alias) {
    return $CharactersCacheTable(attachedDatabase, alias);
  }
}

class CharactersCacheData extends DataClass
    implements Insertable<CharactersCacheData> {
  final int id;
  final String name;
  final String? status;
  final String? species;
  final String? gender;
  final String? imageUrl;
  final String? localImagePath;
  final bool isFavorite;
  final DateTime cachedAt;
  const CharactersCacheData({
    required this.id,
    required this.name,
    this.status,
    this.species,
    this.gender,
    this.imageUrl,
    this.localImagePath,
    required this.isFavorite,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || species != null) {
      map['species'] = Variable<String>(species);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || localImagePath != null) {
      map['local_image_path'] = Variable<String>(localImagePath);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CharactersCacheCompanion toCompanion(bool nullToAbsent) {
    return CharactersCacheCompanion(
      id: Value(id),
      name: Value(name),
      status: status == null && nullToAbsent
          ? const Value.absent()
          : Value(status),
      species: species == null && nullToAbsent
          ? const Value.absent()
          : Value(species),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      localImagePath: localImagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(localImagePath),
      isFavorite: Value(isFavorite),
      cachedAt: Value(cachedAt),
    );
  }

  factory CharactersCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharactersCacheData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      status: serializer.fromJson<String?>(json['status']),
      species: serializer.fromJson<String?>(json['species']),
      gender: serializer.fromJson<String?>(json['gender']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      localImagePath: serializer.fromJson<String?>(json['localImagePath']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'status': serializer.toJson<String?>(status),
      'species': serializer.toJson<String?>(species),
      'gender': serializer.toJson<String?>(gender),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'localImagePath': serializer.toJson<String?>(localImagePath),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CharactersCacheData copyWith({
    int? id,
    String? name,
    Value<String?> status = const Value.absent(),
    Value<String?> species = const Value.absent(),
    Value<String?> gender = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> localImagePath = const Value.absent(),
    bool? isFavorite,
    DateTime? cachedAt,
  }) => CharactersCacheData(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status.present ? status.value : this.status,
    species: species.present ? species.value : this.species,
    gender: gender.present ? gender.value : this.gender,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    localImagePath: localImagePath.present
        ? localImagePath.value
        : this.localImagePath,
    isFavorite: isFavorite ?? this.isFavorite,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  CharactersCacheData copyWithCompanion(CharactersCacheCompanion data) {
    return CharactersCacheData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      status: data.status.present ? data.status.value : this.status,
      species: data.species.present ? data.species.value : this.species,
      gender: data.gender.present ? data.gender.value : this.gender,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      localImagePath: data.localImagePath.present
          ? data.localImagePath.value
          : this.localImagePath,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharactersCacheData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('species: $species, ')
          ..write('gender: $gender, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    status,
    species,
    gender,
    imageUrl,
    localImagePath,
    isFavorite,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharactersCacheData &&
          other.id == this.id &&
          other.name == this.name &&
          other.status == this.status &&
          other.species == this.species &&
          other.gender == this.gender &&
          other.imageUrl == this.imageUrl &&
          other.localImagePath == this.localImagePath &&
          other.isFavorite == this.isFavorite &&
          other.cachedAt == this.cachedAt);
}

class CharactersCacheCompanion extends UpdateCompanion<CharactersCacheData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> status;
  final Value<String?> species;
  final Value<String?> gender;
  final Value<String?> imageUrl;
  final Value<String?> localImagePath;
  final Value<bool> isFavorite;
  final Value<DateTime> cachedAt;
  const CharactersCacheCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.species = const Value.absent(),
    this.gender = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.cachedAt = const Value.absent(),
  });
  CharactersCacheCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.status = const Value.absent(),
    this.species = const Value.absent(),
    this.gender = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.localImagePath = const Value.absent(),
    this.isFavorite = const Value.absent(),
    required DateTime cachedAt,
  }) : name = Value(name),
       cachedAt = Value(cachedAt);
  static Insertable<CharactersCacheData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? status,
    Expression<String>? species,
    Expression<String>? gender,
    Expression<String>? imageUrl,
    Expression<String>? localImagePath,
    Expression<bool>? isFavorite,
    Expression<DateTime>? cachedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (species != null) 'species': species,
      if (gender != null) 'gender': gender,
      if (imageUrl != null) 'image_url': imageUrl,
      if (localImagePath != null) 'local_image_path': localImagePath,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (cachedAt != null) 'cached_at': cachedAt,
    });
  }

  CharactersCacheCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? status,
    Value<String?>? species,
    Value<String?>? gender,
    Value<String?>? imageUrl,
    Value<String?>? localImagePath,
    Value<bool>? isFavorite,
    Value<DateTime>? cachedAt,
  }) {
    return CharactersCacheCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      gender: gender ?? this.gender,
      imageUrl: imageUrl ?? this.imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
      isFavorite: isFavorite ?? this.isFavorite,
      cachedAt: cachedAt ?? this.cachedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (localImagePath.present) {
      map['local_image_path'] = Variable<String>(localImagePath.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharactersCacheCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('species: $species, ')
          ..write('gender: $gender, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('localImagePath: $localImagePath, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CharactersCacheTable charactersCache = $CharactersCacheTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [charactersCache];
}

typedef $$CharactersCacheTableCreateCompanionBuilder =
    CharactersCacheCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> status,
      Value<String?> species,
      Value<String?> gender,
      Value<String?> imageUrl,
      Value<String?> localImagePath,
      Value<bool> isFavorite,
      required DateTime cachedAt,
    });
typedef $$CharactersCacheTableUpdateCompanionBuilder =
    CharactersCacheCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> status,
      Value<String?> species,
      Value<String?> gender,
      Value<String?> imageUrl,
      Value<String?> localImagePath,
      Value<bool> isFavorite,
      Value<DateTime> cachedAt,
    });

class $$CharactersCacheTableFilterComposer
    extends Composer<_$AppDatabase, $CharactersCacheTable> {
  $$CharactersCacheTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CharactersCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $CharactersCacheTable> {
  $$CharactersCacheTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CharactersCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharactersCacheTable> {
  $$CharactersCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get species =>
      $composableBuilder(column: $table.species, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get localImagePath => $composableBuilder(
    column: $table.localImagePath,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CharactersCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharactersCacheTable,
          CharactersCacheData,
          $$CharactersCacheTableFilterComposer,
          $$CharactersCacheTableOrderingComposer,
          $$CharactersCacheTableAnnotationComposer,
          $$CharactersCacheTableCreateCompanionBuilder,
          $$CharactersCacheTableUpdateCompanionBuilder,
          (
            CharactersCacheData,
            BaseReferences<
              _$AppDatabase,
              $CharactersCacheTable,
              CharactersCacheData
            >,
          ),
          CharactersCacheData,
          PrefetchHooks Function()
        > {
  $$CharactersCacheTableTableManager(
    _$AppDatabase db,
    $CharactersCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharactersCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CharactersCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CharactersCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> status = const Value.absent(),
                Value<String?> species = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
              }) => CharactersCacheCompanion(
                id: id,
                name: name,
                status: status,
                species: species,
                gender: gender,
                imageUrl: imageUrl,
                localImagePath: localImagePath,
                isFavorite: isFavorite,
                cachedAt: cachedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> status = const Value.absent(),
                Value<String?> species = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> localImagePath = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                required DateTime cachedAt,
              }) => CharactersCacheCompanion.insert(
                id: id,
                name: name,
                status: status,
                species: species,
                gender: gender,
                imageUrl: imageUrl,
                localImagePath: localImagePath,
                isFavorite: isFavorite,
                cachedAt: cachedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CharactersCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharactersCacheTable,
      CharactersCacheData,
      $$CharactersCacheTableFilterComposer,
      $$CharactersCacheTableOrderingComposer,
      $$CharactersCacheTableAnnotationComposer,
      $$CharactersCacheTableCreateCompanionBuilder,
      $$CharactersCacheTableUpdateCompanionBuilder,
      (
        CharactersCacheData,
        BaseReferences<
          _$AppDatabase,
          $CharactersCacheTable,
          CharactersCacheData
        >,
      ),
      CharactersCacheData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CharactersCacheTableTableManager get charactersCache =>
      $$CharactersCacheTableTableManager(_db, _db.charactersCache);
}
