import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:characters_king_tide/l10n/app_localizations.dart';
import 'core/config/flavor_config.dart';
import 'core/constants/api_constants.dart';
import 'core/di/injection_container.dart' as di;
import 'core/services/home_widget_service.dart';
import 'shared/stores/theme_store.dart';
import 'shared/navigation/main_navigation_shell.dart';
import 'shared/widgets/global_theme_toggle.dart';

// Custom scroll behavior to hide scrollbars
class NoScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize default flavor (prod)
  FlavorConfig.initialize(Flavor.prod);
  ApiConstants.baseUrl = FlavorConfig.instance.baseUrl;

  // Initialize dependency injection
  await di.init();
  await HomeWidgetService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Global key to maintain navigation state across theme changes
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final themeStore = di.sl<ThemeStore>();

    // iPhone 17 Pro Max design size: 430 x 932 dp
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Observer(
          builder: (context) {
            return MaterialApp(
              navigatorKey: navigatorKey,
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context)!.appTitle,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeStore.themeMode,
              scrollBehavior: NoScrollbarBehavior(),
              home: const MainNavigationShell(),
              builder: (context, child) {
                return GlobalThemeToggle(
                  child: child ?? const SizedBox.shrink(),
                );
              },
            );
          },
        );
      },
    );
  }
}
