import 'package:flutter/services.dart';


Future<String> getMapKey() async {
  const platform = MethodChannel('com.balapin.app/api_key');
  try {
    final String apiKey = await platform.invokeMethod('getApiKey');
    return apiKey;
  } on PlatformException catch (e) {
    return 'failed to get error: $e';
  }
}