import 'package:graphql_flutter/graphql_flutter.dart' hide ServerException;
import '../../../../core/config/graphql_config.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/services/image_download_service.dart';
import '../models/character_model.dart';
import 'graphql/character_queries.dart';

abstract class CharacterGraphQLDataSource {
  Future<List<CharacterModel>> getCharacters();
  Future<CharacterModel> getCharacterById(int id);
}

class CharacterGraphQLDataSourceImpl implements CharacterGraphQLDataSource {
  final GraphQLClient client;
  final ImageDownloadService imageDownloadService;

  CharacterGraphQLDataSourceImpl({
    GraphQLClient? client,
    ImageDownloadService? imageDownloadService,
  })  : client = client ?? GraphQLConfig.client,
        imageDownloadService = imageDownloadService ?? ImageDownloadService();

  @override
  Future<List<CharacterModel>> getCharacters() async {
    try {
      final List<CharacterModel> allCharacters = [];
      int offset = 0;
      const int limit = 50; // API max limit is 50
      int total = 0;

      // First request to get total count
      final firstOptions = QueryOptions(
        document: gql(CharacterQueries.getAllCharacters),
        variables: {'offset': offset, 'limit': limit},
        fetchPolicy: FetchPolicy.networkOnly,
      );

      final firstResult = await client.query(firstOptions);

      if (firstResult.hasException) {
        final errorMessage = firstResult.exception?.graphqlErrors.isNotEmpty == true
            ? firstResult.exception!.graphqlErrors.first.message
            : 'GraphQL query failed: ${firstResult.exception?.linkException?.toString() ?? "Unknown error"}';
        throw ServerException(errorMessage);
      }

      final firstData = firstResult.data;
      if (firstData == null) {
        throw ServerException('No data returned from GraphQL');
      }

      final firstCharactersData = firstData['characters'] as Map<String, dynamic>?;
      if (firstCharactersData == null) {
        throw ServerException('No characters data in response');
      }

      total = firstCharactersData['total'] as int;

      // Parse first batch
      final firstEdges = firstCharactersData['edges'] as List<dynamic>?;
      if (firstEdges != null) {
        allCharacters.addAll(
          firstEdges.map((json) => CharacterModel.fromJson(json as Map<String, dynamic>))
        );
      }

      // Fetch remaining pages
      offset += limit;
      while (offset < total) {
        final options = QueryOptions(
          document: gql(CharacterQueries.getAllCharacters),
          variables: {'offset': offset, 'limit': limit},
          fetchPolicy: FetchPolicy.networkOnly,
        );

        final result = await client.query(options);

        if (result.hasException) {
          // Continue with what we have instead of failing completely
          break;
        }

        final data = result.data;
        if (data == null) break;

        final charactersData = data['characters'] as Map<String, dynamic>?;
        if (charactersData == null) break;

        final edges = charactersData['edges'] as List<dynamic>?;
        if (edges == null || edges.isEmpty) break;

        allCharacters.addAll(
          edges.map((json) => CharacterModel.fromJson(json as Map<String, dynamic>))
        );

        offset += limit;
      }

      // Return characters immediately without blocking on image downloads
      return allCharacters;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to fetch characters: ${e.toString()}');
    }
  }

  @override
  Future<CharacterModel> getCharacterById(int id) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql(CharacterQueries.getCharacterById),
        variables: <String, dynamic>{
          'characterId': id,
        },
        fetchPolicy: FetchPolicy.networkOnly,
      );

      final QueryResult result = await client.query(options);

      if (result.hasException) {
        final errorMessage = result.exception?.graphqlErrors.isNotEmpty == true
            ? result.exception!.graphqlErrors.first.message
            : 'GraphQL query failed';
        throw ServerException(errorMessage);
      }

      final data = result.data;
      if (data == null) {
        throw ServerException('No data returned from GraphQL');
      }

      final characterData = data['character'] as Map<String, dynamic>?;
      if (characterData == null) {
        throw ServerException('Character not found');
      }

      return CharacterModel.fromJson(characterData);
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to fetch character: ${e.toString()}');
    }
  }
}
