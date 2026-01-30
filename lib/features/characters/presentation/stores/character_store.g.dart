// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CharacterStore on _CharacterStore, Store {
  Computed<List<Character>>? _$filteredCharactersComputed;

  @override
  List<Character> get filteredCharacters =>
      (_$filteredCharactersComputed ??= Computed<List<Character>>(
        () => super.filteredCharacters,
        name: '_CharacterStore.filteredCharacters',
      )).value;
  Computed<bool>? _$hasActiveFiltersComputed;

  @override
  bool get hasActiveFilters => (_$hasActiveFiltersComputed ??= Computed<bool>(
    () => super.hasActiveFilters,
    name: '_CharacterStore.hasActiveFilters',
  )).value;
  Computed<List<Character>>? _$favoriteCharactersComputed;

  @override
  List<Character> get favoriteCharacters =>
      (_$favoriteCharactersComputed ??= Computed<List<Character>>(
        () => super.favoriteCharacters,
        name: '_CharacterStore.favoriteCharacters',
      )).value;
  Computed<List<String>>? _$availableSpeciesComputed;

  @override
  List<String> get availableSpecies =>
      (_$availableSpeciesComputed ??= Computed<List<String>>(
        () => super.availableSpecies,
        name: '_CharacterStore.availableSpecies',
      )).value;
  Computed<List<String>>? _$availableGendersComputed;

  @override
  List<String> get availableGenders =>
      (_$availableGendersComputed ??= Computed<List<String>>(
        () => super.availableGenders,
        name: '_CharacterStore.availableGenders',
      )).value;
  Computed<List<String>>? _$availableStatusesComputed;

  @override
  List<String> get availableStatuses =>
      (_$availableStatusesComputed ??= Computed<List<String>>(
        () => super.availableStatuses,
        name: '_CharacterStore.availableStatuses',
      )).value;

  late final _$charactersAtom = Atom(
    name: '_CharacterStore.characters',
    context: context,
  );

  @override
  ObservableList<Character> get characters {
    _$charactersAtom.reportRead();
    return super.characters;
  }

  @override
  set characters(ObservableList<Character> value) {
    _$charactersAtom.reportWrite(value, super.characters, () {
      super.characters = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_CharacterStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_CharacterStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$searchQueryAtom = Atom(
    name: '_CharacterStore.searchQuery',
    context: context,
  );

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$selectedSpeciesAtom = Atom(
    name: '_CharacterStore.selectedSpecies',
    context: context,
  );

  @override
  ObservableList<String> get selectedSpecies {
    _$selectedSpeciesAtom.reportRead();
    return super.selectedSpecies;
  }

  @override
  set selectedSpecies(ObservableList<String> value) {
    _$selectedSpeciesAtom.reportWrite(value, super.selectedSpecies, () {
      super.selectedSpecies = value;
    });
  }

  late final _$selectedGendersAtom = Atom(
    name: '_CharacterStore.selectedGenders',
    context: context,
  );

  @override
  ObservableList<String> get selectedGenders {
    _$selectedGendersAtom.reportRead();
    return super.selectedGenders;
  }

  @override
  set selectedGenders(ObservableList<String> value) {
    _$selectedGendersAtom.reportWrite(value, super.selectedGenders, () {
      super.selectedGenders = value;
    });
  }

  late final _$selectedStatusesAtom = Atom(
    name: '_CharacterStore.selectedStatuses',
    context: context,
  );

  @override
  ObservableList<String> get selectedStatuses {
    _$selectedStatusesAtom.reportRead();
    return super.selectedStatuses;
  }

  @override
  set selectedStatuses(ObservableList<String> value) {
    _$selectedStatusesAtom.reportWrite(value, super.selectedStatuses, () {
      super.selectedStatuses = value;
    });
  }

  late final _$sortOptionAtom = Atom(
    name: '_CharacterStore.sortOption',
    context: context,
  );

  @override
  SortOption get sortOption {
    _$sortOptionAtom.reportRead();
    return super.sortOption;
  }

  @override
  set sortOption(SortOption value) {
    _$sortOptionAtom.reportWrite(value, super.sortOption, () {
      super.sortOption = value;
    });
  }

  late final _$loadCharactersAsyncAction = AsyncAction(
    '_CharacterStore.loadCharacters',
    context: context,
  );

  @override
  Future<void> loadCharacters() {
    return _$loadCharactersAsyncAction.run(() => super.loadCharacters());
  }

  late final _$toggleFavoriteAsyncAction = AsyncAction(
    '_CharacterStore.toggleFavorite',
    context: context,
  );

  @override
  Future<void> toggleFavorite(Character character) {
    return _$toggleFavoriteAsyncAction.run(
      () => super.toggleFavorite(character),
    );
  }

  late final _$_CharacterStoreActionController = ActionController(
    name: '_CharacterStore',
    context: context,
  );

  @override
  void setSearchQuery(String query) {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
      name: '_CharacterStore.setSearchQuery',
    );
    try {
      return super.setSearchQuery(query);
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleSpeciesFilter(String species) {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
      name: '_CharacterStore.toggleSpeciesFilter',
    );
    try {
      return super.toggleSpeciesFilter(species);
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleGenderFilter(String gender) {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
      name: '_CharacterStore.toggleGenderFilter',
    );
    try {
      return super.toggleGenderFilter(gender);
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleStatusFilter(String status) {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
      name: '_CharacterStore.toggleStatusFilter',
    );
    try {
      return super.toggleStatusFilter(status);
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSortOption(SortOption option) {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
      name: '_CharacterStore.setSortOption',
    );
    try {
      return super.setSortOption(option);
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleSort() {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
      name: '_CharacterStore.toggleSort',
    );
    try {
      return super.toggleSort();
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFilters() {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
      name: '_CharacterStore.clearFilters',
    );
    try {
      return super.clearFilters();
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCharacterWithLocalImage(CharacterModel updatedCharacter) {
    final _$actionInfo = _$_CharacterStoreActionController.startAction(
      name: '_CharacterStore.updateCharacterWithLocalImage',
    );
    try {
      return super.updateCharacterWithLocalImage(updatedCharacter);
    } finally {
      _$_CharacterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
characters: ${characters},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
searchQuery: ${searchQuery},
selectedSpecies: ${selectedSpecies},
selectedGenders: ${selectedGenders},
selectedStatuses: ${selectedStatuses},
sortOption: ${sortOption},
filteredCharacters: ${filteredCharacters},
hasActiveFilters: ${hasActiveFilters},
favoriteCharacters: ${favoriteCharacters},
availableSpecies: ${availableSpecies},
availableGenders: ${availableGenders},
availableStatuses: ${availableStatuses}
    ''';
  }
}
