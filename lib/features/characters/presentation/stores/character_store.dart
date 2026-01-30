import 'package:mobx/mobx.dart';
import '../../../../core/services/background_image_download_manager.dart';
import '../../../../core/services/home_widget_service.dart';
import '../../data/models/character_model.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../../domain/usecases/get_character_list.dart';

part 'character_store.g.dart';

enum SortOption {
  nameAsc,
  nameDesc,
}

// ignore: library_private_types_in_public_api
class CharacterStore = _CharacterStore with _$CharacterStore;

abstract class _CharacterStore with Store {
  final GetCharacterList getCharacterList;
  final CharacterRepository repository;
  final BackgroundImageDownloadManager? backgroundImageDownloadManager;

  _CharacterStore(
    this.getCharacterList,
    this.repository, {
    // ignore: unused_element_parameter
    this.backgroundImageDownloadManager,
  });

  @observable
  ObservableList<Character> characters = ObservableList<Character>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @observable
  String searchQuery = '';

  @observable
  ObservableList<String> selectedSpecies = ObservableList<String>();

  @observable
  ObservableList<String> selectedGenders = ObservableList<String>();

  @observable
  ObservableList<String> selectedStatuses = ObservableList<String>();

  @observable
  SortOption sortOption = SortOption.nameAsc;

  @computed
  List<Character> get filteredCharacters {
    var result = characters.toList();

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      result = result
          .where((character) =>
              character.name.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Apply species filter (multiple selection)
    if (selectedSpecies.isNotEmpty) {
      result = result
          .where((character) =>
              character.species != null &&
              selectedSpecies.any((s) =>
                  s.toLowerCase() == character.species!.toLowerCase()))
          .toList();
    }

    // Apply gender filter (multiple selection)
    if (selectedGenders.isNotEmpty) {
      result = result
          .where((character) =>
              character.gender != null &&
              selectedGenders.any((g) =>
                  g.toLowerCase() == character.gender!.toLowerCase()))
          .toList();
    }

    // Apply status filter (multiple selection)
    if (selectedStatuses.isNotEmpty) {
      result = result
          .where((character) =>
              character.status != null &&
              selectedStatuses.any((s) =>
                  s.toLowerCase() == character.status!.toLowerCase()))
          .toList();
    }

    // Apply sorting
    switch (sortOption) {
      case SortOption.nameAsc:
        result.sort((a, b) {
          final aName = a.name.replaceAll('"', '').replaceAll("'", '').trim();
          final bName = b.name.replaceAll('"', '').replaceAll("'", '').trim();
          return aName.compareTo(bName);
        });
        break;
      case SortOption.nameDesc:
        result.sort((a, b) {
          final aName = a.name.replaceAll('"', '').replaceAll("'", '').trim();
          final bName = b.name.replaceAll('"', '').replaceAll("'", '').trim();
          return bName.compareTo(aName);
        });
        break;
    }

    return result;
  }

  @computed
  bool get hasActiveFilters {
    return selectedSpecies.isNotEmpty ||
        selectedGenders.isNotEmpty ||
        selectedStatuses.isNotEmpty;
  }

  @computed
  List<Character> get favoriteCharacters {
    return characters.where((character) => character.isFavorite).toList();
  }

  @action
  void setSearchQuery(String query) {
    searchQuery = query;
  }

  @action
  void toggleSpeciesFilter(String species) {
    if (selectedSpecies.contains(species)) {
      selectedSpecies.remove(species);
    } else {
      selectedSpecies.add(species);
    }
  }

  @action
  void toggleGenderFilter(String gender) {
    if (selectedGenders.contains(gender)) {
      selectedGenders.remove(gender);
    } else {
      selectedGenders.add(gender);
    }
  }

  @action
  void toggleStatusFilter(String status) {
    if (selectedStatuses.contains(status)) {
      selectedStatuses.remove(status);
    } else {
      selectedStatuses.add(status);
    }
  }

  @action
  void setSortOption(SortOption option) {
    sortOption = option;
  }

  @action
  void toggleSort() {
    sortOption = sortOption == SortOption.nameAsc
        ? SortOption.nameDesc
        : SortOption.nameAsc;
  }

  @action
  void clearFilters() {
    selectedSpecies.clear();
    selectedGenders.clear();
    selectedStatuses.clear();
  }

  @computed
  List<String> get availableSpecies {
    return characters
        .map((c) => c.species)
        .where((s) => s != null)
        .cast<String>()
        .toSet()
        .toList()
      ..sort();
  }

  @computed
  List<String> get availableGenders {
    return characters
        .map((c) => c.gender)
        .where((g) => g != null)
        .cast<String>()
        .toSet()
        .toList()
      ..sort();
  }

  @computed
  List<String> get availableStatuses {
    return characters
        .map((c) => c.status)
        .where((s) => s != null)
        .cast<String>()
        .toSet()
        .toList()
      ..sort();
  }

  @action
  Future<void> loadCharacters() async {
    isLoading = true;
    errorMessage = null;

    final result = await getCharacterList();

    result.fold(
      (failure) {
        errorMessage = failure.toString();
        isLoading = false;
      },
      (characterList) {
        characters = ObservableList.of(characterList);
        isLoading = false;

        HomeWidgetService.updateFavoritesCount(favoriteCharacters.length);

        // Start progressive image downloads in background
        if (backgroundImageDownloadManager != null && characterList.isNotEmpty) {
          _startProgressiveImageDownloads(characterList);
        }
      },
    );
  }

  void _startProgressiveImageDownloads(List<Character> characterList) {
    // Convert to CharacterModel list
    final characterModels = characterList
        .whereType<CharacterModel>()
        .toList();

    if (characterModels.isEmpty) {
      return;
    }

    // Start background downloads
    backgroundImageDownloadManager!.downloadImagesProgressively(characterModels);
  }

  @action
  void updateCharacterWithLocalImage(CharacterModel updatedCharacter) {
    final index = characters.indexWhere((c) => c.id == updatedCharacter.id);
    if (index != -1) {
      characters[index] = updatedCharacter;
    }
  }

  @action
  Future<void> toggleFavorite(Character character) async {
    final newFavoriteState = !character.isFavorite;

    // Optimistically update UI
    final index = characters.indexWhere((c) => c.id == character.id);
    if (index != -1) {
      final updatedCharacter = character.copyWith(
        isFavorite: newFavoriteState,
      );
      // Use replaceRange to trigger MobX reactivity
      characters.replaceRange(index, index + 1, [updatedCharacter]);
      HomeWidgetService.updateFavoritesCount(favoriteCharacters.length);
    }

    // Persist to database
    final result = await repository.toggleFavorite(character.id, newFavoriteState);

    result.fold(
      (failure) {
        // Revert on failure
        if (index != -1) {
          final revertedCharacter = character.copyWith(
            isFavorite: character.isFavorite,
          );
          characters.replaceRange(index, index + 1, [revertedCharacter]);
          HomeWidgetService.updateFavoritesCount(favoriteCharacters.length);
        }
      },
      (_) {
        // Successfully toggled
      },
    );
  }
}
