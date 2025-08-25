import 'dart:io';

import 'package:bt_door/model/configuration.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_ble/universal_ble.dart';

class Bluetooth {
  static Future<void> enable() async {
    await UniversalBle.enableBluetooth(timeout: Configuration.timeoutDur);
  }

  static Future<void> disable() async {
    await UniversalBle.disableBluetooth(timeout: Configuration.timeoutDur);
  }

  static Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      bool permitted = true;
      final permissions = [
        Permission.location,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ];
      for (final permission in permissions) {
        if (!await permission.isGranted) {
          permitted = await permission.request() == PermissionStatus.granted;
        }
      }
      return permitted;
    }
    return true;
  }
}
