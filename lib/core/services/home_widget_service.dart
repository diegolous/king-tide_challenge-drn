import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';

const String _favoritesCountKey = 'favorites_count';
const String _lastUpdatedKey = 'last_updated';
const String _refreshAction = 'refresh';
const String _widgetScheme = 'futurama';
const String _appGroupId = 'group.com.diegolousx.kt_challenge';
const String _androidWidgetProvider = 'CharacterWidgetProvider';
const String _androidWidgetQualifiedProvider =
    'com.diegolousx.kt_challenge.widgets.CharacterWidgetProvider';

class HomeWidgetService {
  static Future<void> init() async {
    if (kIsWeb) return;
    await HomeWidget.setAppGroupId(_appGroupId);
    await HomeWidget.registerInteractivityCallback(
      homeWidgetBackgroundCallback,
    );
  }

  static Future<void> updateFavoritesCount(int count) async {
    if (kIsWeb) return;
    await HomeWidget.saveWidgetData<int>(_favoritesCountKey, count);
    await HomeWidget.saveWidgetData<String>(_lastUpdatedKey, _nowLabel());
    await HomeWidget.updateWidget(
      name: _androidWidgetProvider,
      androidName: _androidWidgetProvider,
      qualifiedAndroidName: _androidWidgetQualifiedProvider,
    );
  }

  static String _nowLabel() {
    return DateFormat.yMMMd().add_Hm().format(DateTime.now());
  }
}

@pragma('vm:entry-point')
Future<void> homeWidgetBackgroundCallback(Uri? uri) async {
  if (kIsWeb) return;
  if (uri == null || uri.scheme != _widgetScheme) return;
  if (uri.host != _refreshAction) return;

  WidgetsFlutterBinding.ensureInitialized();

  final favoritesCount =
      await HomeWidget.getWidgetData<int>(
        _favoritesCountKey,
        defaultValue: 0,
      ) ??
      0;
  await HomeWidget.saveWidgetData<int>(_favoritesCountKey, favoritesCount);
  await HomeWidget.saveWidgetData<String>(
    _lastUpdatedKey,
    DateFormat.yMMMd().add_Hm().format(DateTime.now()),
  );
  await HomeWidget.updateWidget(
    name: _androidWidgetProvider,
    androidName: _androidWidgetProvider,
    qualifiedAndroidName: _androidWidgetQualifiedProvider,
  );
}
