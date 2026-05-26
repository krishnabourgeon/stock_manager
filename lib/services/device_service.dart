import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceService {
  static const String _deviceKeyPref = 'device_key';

  /// Get device ID (unique per device)
  static Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      return android.id; // Android ID
    } else if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      return ios.identifierForVendor ?? 'unknown_ios';
    } else {
      return 'unsupported';
    }
  }

  /// Get or generate device key (stored locally)
  static Future<String> getDeviceKey() async {
    final prefs = await SharedPreferences.getInstance();

    String? key = prefs.getString(_deviceKeyPref);

    if (key == null) {
      key = const Uuid().v4();
      await prefs.setString(_deviceKeyPref, key);
    }

    return key;
  }
}