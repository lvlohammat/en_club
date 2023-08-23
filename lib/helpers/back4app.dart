import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class Back4App {
  static Future<void> init() async {
    const keyApplicationId = 'WjV3d6aoMXq3PuQnHZYtg9zN9ecKwgNi9cV5JgFx';
    const keyClientId = 'se4xtoOhuxtCqDn34Dz1XFm2Qa8fjE4t2MZmCcaI';
    const keyParseServerUrl = 'https://parseapi.back4app.com';
    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientId, autoSendSessionId: true);
  }
}
