import 'package:bt_door/errors.dart';
import 'package:bt_door/main_theme.dart';
import 'package:bt_door/model/bluetooth.dart';
import 'package:bt_door/model/nearby_devices.dart';
import 'package:bt_door/providers/bt_status_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class BluetoothButton extends StatelessWidget {
  const BluetoothButton({super.key});

  @override
  Widget build(BuildContext context) {
    final btActive = BTStatusProvider.activeOf(context, true);

    return IconButton(
      onPressed: () async {
        final permitted = await Bluetooth.requestPermissions();
        if (!permitted && context.mounted) {
          showSnackbarOf(context, 'Allow all the permissions.');
          return;
        }
        if (btActive && context.mounted) {
          final nearbyDevices = NearbyDevices.of(context);
          await nearbyDevices.stopScan();
          await Bluetooth.disable();
        } else if (!btActive) {
          try {
            await Bluetooth.enable();
          } catch (e) {
            if (context.mounted) {
              showSnackbarOf(context, "Turn on BT manually.");
            }
          }
        }
      },
      icon: Icon(
        btActive ? Symbols.bluetooth_connected : Symbols.bluetooth,
        color: btActive ? activeColorOf(context) : null,
      ),
      tooltip: btActive ? 'Disable bluetooth' : 'Enable bluetooth',
    );
  }
}
