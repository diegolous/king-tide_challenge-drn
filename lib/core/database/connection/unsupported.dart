import 'package:drift/drift.dart';

DatabaseConnection createDriftDatabase() {
  throw UnsupportedError(
    'No suitable database implementation was found on this platform.',
  );
}
