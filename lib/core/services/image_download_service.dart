import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';

class ImageDownloadService {
  /// Download an image from a URL and save it locally
  /// Returns the local file path if successful, null otherwise
  Future<String?> downloadAndSaveImage(String imageUrl, int characterId) async {
    try {
      // Skip if URL is null or empty
      if (imageUrl.isEmpty) {
        return null;
      }

      // Get the application documents directory
      final directory = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${directory.path}/character_images');

      // Create directory if it doesn't exist
      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }

      // Extract file extension from URL
      final uri = Uri.parse(imageUrl);
      final extension = path.extension(uri.path);

      // Create file name using character ID
      final fileName = 'character_$characterId$extension';
      final filePath = '${imagesDir.path}/$fileName';

      // Check if file already exists
      final file = File(filePath);
      if (await file.exists()) {
        return filePath;
      }

      // Download the image
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Save the image
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Download multiple images concurrently
  Future<Map<int, String?>> downloadMultipleImages(
    Map<int, String> imageUrlMap,
  ) async {
    final results = <int, String?>{};

    // Download images in batches to avoid overwhelming the system
    const batchSize = 5;
    final entries = imageUrlMap.entries.toList();

    for (var i = 0; i < entries.length; i += batchSize) {
      final batch = entries.skip(i).take(batchSize);
      final futures = batch.map((entry) async {
        final localPath = await downloadAndSaveImage(entry.value, entry.key);
        return MapEntry(entry.key, localPath);
      });

      final batchResults = await Future.wait(futures);
      for (final entry in batchResults) {
        results[entry.key] = entry.value;
      }

      debugPrint('📊 Downloaded batch ${(i ~/ batchSize) + 1} (${results.length}/${imageUrlMap.length})');
    }

    return results;
  }

  /// Delete a locally stored image
  Future<bool> deleteLocalImage(String localPath) async {
    try {
      final file = File(localPath);
      if (await file.exists()) {
        await file.delete();
        debugPrint('🗑️ Deleted local image: $localPath');
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('❌ Error deleting local image: $e');
      return false;
    }
  }

  /// Clear all downloaded character images
  Future<void> clearAllImages() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${directory.path}/character_images');

      if (await imagesDir.exists()) {
        await imagesDir.delete(recursive: true);
        debugPrint('🗑️ Cleared all character images');
      }
    } catch (e) {
      debugPrint('❌ Error clearing images: $e');
    }
  }
}
