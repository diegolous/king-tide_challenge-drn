import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart' hide ServerException;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/series_remote_datasource.dart';
import '../../data/repositories/series_repository_impl.dart';
import '../../domain/repositories/series_repository.dart';
import '../../domain/usecases/get_series_info.dart';
import '../../features/characters/data/datasources/character_graphql_datasource.dart';
import '../../features/characters/data/datasources/character_local_datasource.dart';
import '../../features/characters/data/repositories/character_repository_impl.dart';
import '../../features/characters/domain/repositories/character_repository.dart';
import '../../features/characters/domain/usecases/get_character_list.dart';
import '../../features/characters/presentation/stores/character_store.dart';
import '../../shared/stores/theme_store.dart';
import '../config/graphql_config.dart';
import '../database/app_database.dart';
import '../network/network_info.dart';
import '../services/background_image_download_manager.dart';
import '../services/image_download_service.dart';
import '../services/preferences_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Services
  sl.registerLazySingleton(() => PreferencesService(sl()));
  sl.registerLazySingleton<ImageDownloadService>(() => ImageDownloadService());

  // Database
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // External
  sl.registerLazySingleton<GraphQLClient>(() => GraphQLConfig.client);
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => http.Client());

  // Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<CharacterGraphQLDataSource>(
    () => CharacterGraphQLDataSourceImpl(
      client: sl(),
      imageDownloadService: sl(),
    ),
  );

  sl.registerLazySingleton<CharacterLocalDataSource>(
    () => CharacterLocalDataSourceImpl(
      database: sl(),
    ),
  );

  sl.registerLazySingleton<SeriesRemoteDataSource>(
    () => SeriesRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<SeriesRepository>(
    () => SeriesRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCharacterList(sl()));
  sl.registerLazySingleton(() => GetSeriesInfo(sl()));

  // MobX Stores
  // Create CharacterStore with BackgroundImageDownloadManager
  late CharacterStore characterStore;
  characterStore = CharacterStore(
    sl(), // GetCharacterList
    sl(), // CharacterRepository
    backgroundImageDownloadManager: BackgroundImageDownloadManager(
      imageDownloadService: sl(),
      onCharacterUpdated: (updatedCharacter) {
        characterStore.updateCharacterWithLocalImage(updatedCharacter);
      },
    ),
  );
  sl.registerLazySingleton(() => characterStore);
  sl.registerLazySingleton(() => ThemeStore(sl()));
}
