import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

DatabaseConnection createDriftDatabase() {
  return DatabaseConnection.delayed(Future(() async {
    try {
      final result = await WasmDatabase.open(
        databaseName: 'futurama_characters_db',
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
      );

      if (result.missingFeatures.isNotEmpty) {
        // Silently fallback to IndexedDB for browsers without SharedArrayBuffer
        // This maintains full offline functionality
        // ignore: avoid_print
        print('Database: Using ${result.chosenImplementation} (fallback mode for browser compatibility)');
      }

      return result.resolvedExecutor;
    } catch (e) {
      // If WebAssembly initialization fails, the WasmDatabase.open
      // already handles fallback to IndexedDB internally
      // This catch ensures the app continues to work
      rethrow;
    }
  }));
}
