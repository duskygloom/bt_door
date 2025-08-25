import 'package:bt_door/errors.dart';
import 'package:bt_door/main_theme.dart';
import 'package:bt_door/model/nearby_devices.dart';
import 'package:bt_door/providers/bt_status_provider.dart';
import 'package:bt_door/providers/refresh_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    final btActive = BTStatusProvider.activeOf(context, true);
    final nearbyDevices = NearbyDevices.of(context, true);
    final scanning = nearbyDevices.scanning;

    return FloatingActionButton(
      onPressed: () async {
        if (btActive && scanning) {
          await nearbyDevices.stopScan();
        } else if (btActive) {
          final refreshKey = RefreshProvider.devicesKeyOf(context);
          await refreshKey.currentState?.show();
        } else {
          showSnackbarOf(context, 'Turn on BT first.');
        }
      },
      tooltip: btActive
          ? scanning
                ? 'Stop scanning'
                : 'Start scanning'
          : 'Turn on BT first.',
      backgroundColor: btActive
          ? scanning
                ? activeColorOf(context)
                : colorSchemeOf(context).primaryContainer
          : colorSchemeOf(context).surfaceContainerHigh,
      child: Icon(Symbols.sensors),
    );
  }
}
