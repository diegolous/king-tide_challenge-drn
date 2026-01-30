import 'package:drift/drift.dart';
import 'connection/connection.dart' as impl;

part 'app_database.g.dart';

// Characters table for Futurama characters
class CharactersCache extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get status => text().nullable()();
  TextColumn get species => text().nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get localImagePath => text().nullable()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get cachedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [CharactersCache])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
    },
  );
}
