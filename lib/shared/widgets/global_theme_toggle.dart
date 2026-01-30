import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../core/di/injection_container.dart';
import '../stores/theme_store.dart';

/// Global theme toggle button that appears on all screens
class GlobalThemeToggle extends StatelessWidget {
  final Widget child;

  static const double _fabRightPadding = 26;
  static const double _fabBottomPadding = 86;
  const GlobalThemeToggle({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final themeStore = sl<ThemeStore>();

    return Stack(
      children: [
        // The main content (screen)
        child,

        // Global FAB positioned at bottom right
        Positioned(
          right: _fabRightPadding,
          bottom: _fabBottomPadding + MediaQuery.of(context).padding.bottom,
          child: Observer(
            builder: (context) {
              return FloatingActionButton(
                onPressed: () => themeStore.toggleTheme(),
                backgroundColor: AppColors.primary,
                child: Icon(
                  themeStore.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  color: AppColors.white,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
