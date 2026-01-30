import 'package:characters_king_tide/features/characters/data/models/character_model.dart';
import 'image_download_service.dart';

/// Manages background downloading of character images
class BackgroundImageDownloadManager {
  final ImageDownloadService _imageDownloadService;
  final void Function(CharacterModel) onCharacterUpdated;

  BackgroundImageDownloadManager({
    ImageDownloadService? imageDownloadService,
    required this.onCharacterUpdated,
  }) : _imageDownloadService = imageDownloadService ?? ImageDownloadService();

  /// Download images for characters progressively in the background
  Future<void> downloadImagesProgressively(
    List<CharacterModel> characters,
  ) async {
    for (final character in characters) {
      try {
        // Skip if character already has local image path
        if (character.localImagePath != null && character.localImagePath!.isNotEmpty) {
          continue;
        }

        // Skip if no image URL
        if (character.imageUrl == null || character.imageUrl!.isEmpty) {
          continue;
        }

        // Download the image
        final localPath = await _imageDownloadService.downloadAndSaveImage(
          character.imageUrl!,
          character.id,
        );

        if (localPath != null) {
          // Create updated character with local path
          final updatedCharacter = character.copyWithLocalPath(localPath);

          // Notify the store to update this character
          onCharacterUpdated(updatedCharacter);
        }
      } catch (e) {
        // Silently handle errors
      }
    }
  }
}
