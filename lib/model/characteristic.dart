import 'dart:convert';

import 'package:bt_door/model/configuration.dart';
import 'package:universal_ble/universal_ble.dart';

class Characteristic extends BleCharacteristic {
  static Future<List<Characteristic>> fetchAll(BleDevice device) async {
    final services = await device.discoverServices(
      timeout: Configuration.timeoutDur,
    );
    final characteristics = <Characteristic>[];
    for (final service in services) {
      if (!Configuration.doorService.contains(service.uuid)) continue;
      for (final characteristic in service.characteristics) {
        final data = Configuration.doorCharacteristics[characteristic.uuid];
        if (data != null) {
          characteristics.add(
            Characteristic.fromBle(
              data['name']!,
              data['type']!,
              characteristic,
            ),
          );
        }
      }
    }
    return characteristics;
  }

  Characteristic(this.name, this.type, super.uuid, super.properties);

  final String name, type;

  static Characteristic fromBle(
    String name,
    String type,
    BleCharacteristic characteristic,
  ) {
    return Characteristic(
      name,
      type,
      characteristic.uuid,
      characteristic.properties,
    )..metaData = characteristic.metaData;
  }

  Future<String> fetchValue() async {
    if (type == 'READ') {
      final bytes = await read(timeout: Configuration.timeoutDur);
      final message = utf8.decode(bytes);
      return message;
    }
    return '';
  }

  Future<void> sendValue(String message) async {
    if (type == 'WRITE') {
      final bytes = utf8.encode(message);
      await write(bytes, timeout: Configuration.timeoutDur);
    }
  }
}
