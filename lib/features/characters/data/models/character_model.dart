import '../../domain/entities/character.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.name,
    super.gender,
    super.species,
    super.status,
    super.homePlanet,
    super.occupation,
    super.sayings,
    super.imageUrl,
    super.localImagePath,
    super.isFavorite,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int? ?? 0,
      name: (json['name'] as String?) ?? '',
      gender: json['gender'] as String?,
      species: json['species'] as String?,
      status: json['status'] as String?,
      homePlanet: json['homePlanet'] as String?,
      occupation: json['occupation'] as String?,
      sayings: json['sayings'] != null
          ? List<String>.from(json['sayings'] as List)
          : null,
      imageUrl: json['image'] as String?,
      localImagePath: json['localImagePath'] as String?,
      isFavorite: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'species': species,
      'homePlanet': homePlanet,
      'occupation': occupation,
      'sayings': sayings,
      'images': {'main': imageUrl},
      'localImagePath': localImagePath,
    };
  }

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      gender: gender,
      species: species,
      status: status,
      homePlanet: homePlanet,
      occupation: occupation,
      sayings: sayings,
      imageUrl: imageUrl,
      localImagePath: localImagePath,
      isFavorite: isFavorite,
    );
  }

  @override
  CharacterModel copyWith({
    int? id,
    String? name,
    String? gender,
    String? species,
    String? status,
    String? homePlanet,
    String? occupation,
    List<String>? sayings,
    String? imageUrl,
    String? localImagePath,
    bool? isFavorite,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      species: species ?? this.species,
      status: status ?? this.status,
      homePlanet: homePlanet ?? this.homePlanet,
      occupation: occupation ?? this.occupation,
      sayings: sayings ?? this.sayings,
      imageUrl: imageUrl ?? this.imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // Create a copy with updated local image path
  CharacterModel copyWithLocalPath(String? localPath) {
    return CharacterModel(
      id: id,
      name: name,
      gender: gender,
      species: species,
      status: status,
      homePlanet: homePlanet,
      occupation: occupation,
      sayings: sayings,
      imageUrl: imageUrl,
      localImagePath: localPath,
      isFavorite: isFavorite,
    );
  }
}
