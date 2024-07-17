//this class has all remote service configurations, and it takes care of the different environments we have
import 'constants.dart';

class NetworkConfig {

  static String DEVELOP_BASE_URL = baseUrl;
  static String RELEASE_BASE_URL = productionBaseUrl;
  static String API_KEY = apiKey;
  static String APP_ID = appID;
  static String ORGANIZATION_ID = organizationID;
  static String IMAGES_URL = imagesUrl;

}
