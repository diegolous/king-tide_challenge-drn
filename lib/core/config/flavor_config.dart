enum Flavor {
  dev,
  staging,
  prod,
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final String baseUrl;
  final bool showDebugBanner;

  FlavorConfig._({
    required this.flavor,
    required this.name,
    required this.baseUrl,
    required this.showDebugBanner,
  });

  static FlavorConfig? _instance;

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception('FlavorConfig not initialized. Call FlavorConfig.initialize() first.');
    }
    return _instance!;
  }

  static void initialize(Flavor flavor) {
    switch (flavor) {
      case Flavor.dev:
        _instance = FlavorConfig._(
          flavor: Flavor.dev,
          name: 'DEV',
          baseUrl: 'https://futuramaapi.com/api',
          showDebugBanner: true,
        );
        break;
      case Flavor.staging:
        _instance = FlavorConfig._(
          flavor: Flavor.staging,
          name: 'STAGING',
          baseUrl: 'https://futuramaapi.com/api',
          showDebugBanner: true,
        );
        break;
      case Flavor.prod:
        _instance = FlavorConfig._(
          flavor: Flavor.prod,
          name: 'PROD',
          baseUrl: 'https://futuramaapi.com/api',
          showDebugBanner: false,
        );
        break;
    }
  }

  bool get isDev => flavor == Flavor.dev;
  bool get isStaging => flavor == Flavor.staging;
  bool get isProd => flavor == Flavor.prod;
}
