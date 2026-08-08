import 'package:flutter/services.dart';

class AppDeviceUtils {
  void lockDeviceRotation() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }
}
