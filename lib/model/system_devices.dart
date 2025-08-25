import 'package:bt_door/model/configuration.dart';
import 'package:universal_ble/universal_ble.dart';

class SystemDevices {
  static Future<List<BleDevice>> fetch() {
    return UniversalBle.getSystemDevices(timeout: Configuration.timeoutDur);
  }
}
