import 'package:bt_door/model/nearby_devices.dart';
import 'package:bt_door/model/system_devices.dart';
import 'package:bt_door/providers/bt_status_provider.dart';
import 'package:bt_door/providers/refresh_provider.dart';
import 'package:bt_door/view/widgets/device_tile.dart';
import 'package:bt_door/view/widgets/empty_list.dart';
import 'package:bt_door/view/widgets/scroll_area.dart';
import 'package:flutter/material.dart';
import 'package:universal_ble/universal_ble.dart';

class DevicesList extends StatefulWidget {
  const DevicesList({super.key});

  @override
  State<DevicesList> createState() => _DevicesListState();
}

class _DevicesListState extends State<DevicesList> {
  final Map<String, BleDevice> devices = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await refreshFunction();
    });
  }

  Future<void> refreshFunction() async {
    // turn on bluetooth if not active
    final btActive = BTStatusProvider.activeOf(context);
    if (!btActive) return;
    // fetch system devices
    devices.clear();
    final sysDevices = await SystemDevices.fetch();
    for (final d in sysDevices) {
      devices[d.deviceId] = d;
    }
    setState(() {});
    // fetch nearby devices
    if (mounted) {
      final nearbyDevices = NearbyDevices.of(context);
      await nearbyDevices.stopScan();
      nearbyDevices.clearDevices();
      await nearbyDevices.startScan();
    }
  }

  @override
  Widget build(BuildContext context) {
    final nearbyDevices = NearbyDevices.of(context, true);
    devices.addAll(nearbyDevices.devices);
    final deviceIterable = devices.values;

    final deviceList = ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) =>
          DeviceTile(device: deviceIterable.elementAt(index)),
    );

    return ScrollArea(
      child: RefreshIndicator(
        key: RefreshProvider.devicesKeyOf(context),
        onRefresh: refreshFunction,
        child: devices.isEmpty ? EmptyList() : deviceList,
      ),
    );
  }
}
