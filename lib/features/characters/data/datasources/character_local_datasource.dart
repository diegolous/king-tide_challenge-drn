import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../models/character_model.dart';

abstract class CharacterLocalDataSource {
  /// Get all cached characters from database
  Future<List<CharacterModel>> getCachedCharacters();

  /// Cache characters in database
  Future<void> cacheCharacters(List<CharacterModel> characters);

  /// Update a single character in database
  Future<void> updateCharacter(CharacterModel character);

  /// Toggle favorite status for a character
  Future<void> toggleFavorite(int characterId, bool isFavorite);

  /// Get favorite status for characters
  Future<Map<int, bool>> getFavoriteStatuses();

  /// Clear all cached characters
  Future<void> clearCache();
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final AppDatabase database;

  CharacterLocalDataSourceImpl({required this.database});

  @override
  Future<List<CharacterModel>> getCachedCharacters() async {
    final cachedData = await database.select(database.charactersCache).get();

    return cachedData.map((row) => CharacterModel(
      id: row.id,
      name: row.name,
      status: row.status,
      species: row.species,
      gender: row.gender,
      imageUrl: row.imageUrl,
      localImagePath: row.localImagePath,
      isFavorite: row.isFavorite,
    )).toList();
  }

  @override
  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    // Get existing favorite statuses before clearing
    final favoriteStatuses = await getFavoriteStatuses();

    // Delete existing cache
    await database.delete(database.charactersCache).go();

    // Insert new characters preserving favorite status
    for (final character in characters) {
      final isFavorite = favoriteStatuses[character.id] ?? character.isFavorite;

      await database.into(database.charactersCache).insert(
        CharactersCacheCompanion.insert(
          id: Value(character.id),
          name: character.name,
          status: Value(character.status),
          species: Value(character.species),
          gender: Value(character.gender),
          imageUrl: Value(character.imageUrl),
          localImagePath: Value(character.localImagePath),
          isFavorite: Value(isFavorite),
          cachedAt: DateTime.now(),
        ),
      );
    }
  }

  @override
  Future<void> updateCharacter(CharacterModel character) async {
    await (database.update(database.charactersCache)
          ..where((tbl) => tbl.id.equals(character.id)))
        .write(
      CharactersCacheCompanion(
        name: Value(character.name),
        status: Value(character.status),
        species: Value(character.species),
        gender: Value(character.gender),
        imageUrl: Value(character.imageUrl),
        localImagePath: Value(character.localImagePath),
        isFavorite: Value(character.isFavorite),
      ),
    );
  }

  @override
  Future<void> toggleFavorite(int characterId, bool isFavorite) async {
    await (database.update(database.charactersCache)
          ..where((tbl) => tbl.id.equals(characterId)))
        .write(
      CharactersCacheCompanion(
        isFavorite: Value(isFavorite),
      ),
    );
  }

  @override
  Future<Map<int, bool>> getFavoriteStatuses() async {
    final cachedData = await database.select(database.charactersCache).get();
    return {
      for (final row in cachedData) row.id: row.isFavorite,
    };
  }

  @override
  Future<void> clearCache() async {
    await database.delete(database.charactersCache).go();
  }
}
