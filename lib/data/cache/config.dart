import 'network_config.dart';

enum Flavor {
  DEVELOPMENT,
  RELEASE,
}

class Config {
  static Flavor? appFlavor;

  static String get BASEURL {
    switch (appFlavor) {
      case Flavor.DEVELOPMENT:
        return NetworkConfig.DEVELOP_BASE_URL;
      case Flavor.RELEASE:
        return NetworkConfig.RELEASE_BASE_URL;
      default:
        return '';
    }
  }
}