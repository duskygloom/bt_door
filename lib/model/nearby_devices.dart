import 'package:bt_door/model/configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_ble/universal_ble.dart';

typedef ScanResultFunc = void Function(BleDevice device);

class NearbyDevices extends ChangeNotifier {
  bool _scanning = false;
  final Map<String, BleDevice> _devices = {};

  Future<void> startScan() async {
    UniversalBle.onScanResult = addDevice;
    await UniversalBle.startScan(
      scanFilter: ScanFilter(withServices: Configuration.doorService),
    );
    _scanning = true;
    notifyListeners();
  }

  Future<void> stopScan() async {
    await UniversalBle.stopScan();
    UniversalBle.onScanResult = null;
    _scanning = false;
    notifyListeners();
  }

  Map<String, BleDevice> get devices => _devices;

  void addDevice(BleDevice device) {
    _devices[device.deviceId] = device;
    notifyListeners();
  }

  void clearDevices() {
    _devices.clear();
    notifyListeners();
  }

  bool get scanning => _scanning;

  static NearbyDevices of(BuildContext context, [bool listen = false]) {
    return Provider.of<NearbyDevices>(context, listen: listen);
  }

  static Map<String, BleDevice> devicesOf(
    BuildContext context, [
    bool listen = false,
  ]) {
    return of(context, listen)._devices;
  }
}
