class Character {
  final int id;
  final String name;
  final String? gender;
  final String? species;
  final String? status;
  final String? homePlanet;
  final String? occupation;
  final List<String>? sayings;
  final String? imageUrl;
  final String? localImagePath;
  final bool isFavorite;

  const Character({
    required this.id,
    required this.name,
    this.gender,
    this.species,
    this.status,
    this.homePlanet,
    this.occupation,
    this.sayings,
    this.imageUrl,
    this.localImagePath,
    this.isFavorite = false,
  });

  Character copyWith({
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
    return Character(
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Character &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
