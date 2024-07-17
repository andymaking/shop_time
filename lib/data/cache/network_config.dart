//this class has all remote service configurations, and it takes care of the different environments we have
import 'constants.dart';

class NetworkConfig {

  static String DEVELOP_BASE_URL = baseUrl;
  static String RELEASE_BASE_URL = productionBaseUrl;
  static String FLW_SECRET_KEY = secretKey;
  static String FLW_PUBLIC_KEY = publicKey;

}
