import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getCharacters();
  Future<CharacterModel> getCharacterById(int id);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  CharacterRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<List<CharacterModel>> getCharacters() async {
    final List<CharacterModel> allCharacters = [];
    int currentPage = 1;
    int totalPages = 1;

    // Fetch all pages
    while (currentPage <= totalPages) {
      final response = await client.get(
        Uri.parse('$baseUrl/characters?page=$currentPage'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Get pagination info
        totalPages = jsonResponse['pages'] as int;

        // Parse characters from 'items' array
        final List<dynamic> items = jsonResponse['items'] as List;
        final characters = items
            .map((json) => CharacterModel.fromJson(json as Map<String, dynamic>))
            .toList();

        allCharacters.addAll(characters);
        currentPage++;
      } else {
        throw Exception('Failed to load characters from page $currentPage');
      }
    }

    return allCharacters;
  }

  @override
  Future<CharacterModel> getCharacterById(int id) async {
    final response = await client.get(
      Uri.parse('$baseUrl/characters/$id'),
    );

    if (response.statusCode == 200) {
      return CharacterModel.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to load character');
    }
  }
}
