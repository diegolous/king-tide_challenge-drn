import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/character_graphql_datasource.dart';
import '../datasources/character_local_datasource.dart';
import '../models/character_model.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterGraphQLDataSource remoteDataSource;
  final CharacterLocalDataSource localDataSource;

  CharacterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Character>>> getCharacters() async {
    try {
      // Try to get from remote
      final characters = await remoteDataSource.getCharacters();

      // Cache characters in database
      await localDataSource.cacheCharacters(characters);

      // Load from database to get favorite states
      final cachedCharacters = await localDataSource.getCachedCharacters();

      return Right(cachedCharacters);
    } on ServerException {
      // If remote fails, try to get from cache
      try {
        final cachedCharacters = await localDataSource.getCachedCharacters();
        if (cachedCharacters.isNotEmpty) {
          return Right(cachedCharacters);
        }
        return const Left(ServerFailure('Failed to fetch characters from server'));
      } catch (e) {
        return const Left(CacheFailure('Failed to load cached characters'));
      }
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Character>> getCharacterById(int id) async {
    try {
      final character = await remoteDataSource.getCharacterById(id);
      return Right(character);
    } on ServerException {
      return const Left(ServerFailure('Failed to fetch character from server'));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(int characterId, bool isFavorite) async {
    try {
      await localDataSource.toggleFavorite(characterId, isFavorite);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to toggle favorite: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateCharacter(Character character) async {
    try {
      if (character is CharacterModel) {
        await localDataSource.updateCharacter(character);
        return const Right(null);
      }
      return const Left(CacheFailure('Character must be CharacterModel'));
    } catch (e) {
      return Left(CacheFailure('Failed to update character: ${e.toString()}'));
    }
  }
}
