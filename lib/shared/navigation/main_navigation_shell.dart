import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import '../../features/characters/presentation/screens/screens.dart';
import '../widgets/animated_bottom_bar.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  // List of navigators for each tab to maintain separate navigation stacks
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // List of root pages for each tab
  final List<Widget> _rootPages = const [
    CharacterListScreen(),
    FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        // Check if the current navigator can pop
        final currentNavigator = _navigatorKeys[_currentIndex].currentState;
        if (currentNavigator != null && currentNavigator.canPop()) {
          currentNavigator.pop();
        } else if (_currentIndex != 0) {
          // If we're not on the first tab, go back to it
          setState(() {
            _currentIndex = 0;
          });
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: List.generate(
            _rootPages.length,
            (index) => Navigator(
              key: _navigatorKeys[index],
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                  builder: (context) => _rootPages[index],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: AnimatedBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (_currentIndex == index) {
              // If tapping the same tab, pop to root
              final currentNavigator = _navigatorKeys[index].currentState;
              if (currentNavigator != null && currentNavigator.canPop()) {
                currentNavigator.popUntil((route) => route.isFirst);
              }
            } else {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          icons: const [
            Icons.people_outline,
            Icons.favorite_outline,
          ],
          activeIcons: const [
            Icons.people,
            Icons.favorite,
          ],
          selectedColor: AppColors.primary,
          unselectedColor: AppColors.grey400,
        ),
      ),
    );
  }
}
