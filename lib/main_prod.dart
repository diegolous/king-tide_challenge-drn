import 'package:flutter/material.dart';
import 'core/config/flavor_config.dart';
import 'core/constants/api_constants.dart';
import 'main.dart' as main_app;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize flavor
  FlavorConfig.initialize(Flavor.prod);

  // Set base URL for production
  ApiConstants.baseUrl = FlavorConfig.instance.baseUrl;

  // Run the app
  main_app.main();
}
