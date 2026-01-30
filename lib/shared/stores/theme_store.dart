import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../core/services/preferences_service.dart';

part 'theme_store.g.dart';

// ignore: library_private_types_in_public_api
class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  final PreferencesService _preferencesService;

  _ThemeStore(this._preferencesService) {
    _loadSavedTheme();
  }

  @observable
  bool isDarkMode = false;

  @computed
  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  @action
  void _loadSavedTheme() {
    isDarkMode = _preferencesService.isDarkMode();
  }

  @action
  Future<void> toggleTheme() async {
    isDarkMode = !isDarkMode;
    await _preferencesService.setDarkMode(isDarkMode);
  }
}
