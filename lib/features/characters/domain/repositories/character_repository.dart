import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/character.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getCharacters();
  Future<Either<Failure, Character>> getCharacterById(int id);
  Future<Either<Failure, void>> toggleFavorite(int characterId, bool isFavorite);
  Future<Either<Failure, void>> updateCharacter(Character character);
}
