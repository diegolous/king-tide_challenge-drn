import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/character.dart';
import '../repositories/character_repository.dart';

class GetCharacterList {
  final CharacterRepository repository;

  GetCharacterList(this.repository);

  Future<Either<Failure, List<Character>>> call() async {
    return await repository.getCharacters();
  }
}
