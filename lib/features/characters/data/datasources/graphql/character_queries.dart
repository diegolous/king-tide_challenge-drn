class CharacterQueries {
  // Query to fetch all characters with pagination support
  // Uses the Relay connection pattern with 'edges' field
  static const String getAllCharacters = r'''
    query GetCharacters($offset: Int, $limit: Int) {
      characters(offset: $offset, limit: $limit) {
        total
        limit
        edges {
          id
          name
          status
          species
          gender
          image
        }
      }
    }
  ''';

  // Query to fetch a single character by ID
  static const String getCharacterById = r'''
    query GetCharacterById($characterId: Int!) {
      character(characterId: $characterId) {
        id
        name
        status
        species
        gender
        image
      }
    }
  ''';
}
