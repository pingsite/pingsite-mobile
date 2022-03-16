import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeviceService {
  static Future<String?> getDeviceId() async {
    const storage = FlutterSecureStorage();
    String? id = await storage.read(key: 'device_id');

    if (id != null && id.isNotEmpty) {
      return id;
    }
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      id = iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      id = androidDeviceInfo.androidId;
    }
    await storage.write(key: 'device_id', value: id);
    return id ?? _generateId();
  }

  static String _generateId() {
    var uuid = const Uuid();
    return uuid.v5(Uuid.NAMESPACE_URL, 'pingsite.io');
  }
}
