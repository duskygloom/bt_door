import 'dart:async';

import 'package:bt_door/errors.dart';
import 'package:bt_door/main_theme.dart';
import 'package:bt_door/model/characteristic.dart';
import 'package:bt_door/providers/refresh_provider.dart';
import 'package:bt_door/view/widgets/characteristics_list.dart';
import 'package:bt_door/view/widgets/connect_button.dart';
import 'package:flutter/material.dart';
import 'package:universal_ble/universal_ble.dart';

class DeviceTile extends StatefulWidget {
  const DeviceTile({super.key, required this.device});

  final BleDevice device;

  @override
  State<DeviceTile> createState() => _DeviceTileState();
}

class _DeviceTileState extends State<DeviceTile> {
  bool? connected;
  late StreamSubscription connectionSub;
  final characteristics = <Characteristic>[];

  final refreshKey = RefreshKeyType();

  @override
  void initState() {
    super.initState();
    widget.device.connectionState
        .then((state) {
          setState(() {
            connected = state == BleConnectionState.connected;
          });
        })
        .onError((error, trace) {
          print(error);
        });
    connectionSub = widget.device.connectionStream.listen((state) {
      if (mounted) setState(() => connected = state);
    });
  }

  @override
  void dispose() {
    connectionSub.cancel().then((_) {});
    super.dispose();
  }

  Future<void> buttonFunction() async {
    if (connected == true) {
      if (mounted) setState(() => connected = null);
      try {
        await widget.device.disconnect();
      } catch (e) {
        print(e);
        if (mounted) {
          showSnackbarOf(context, e.toString());
          setState(() => connected = true);
        }
      }
    } else if (connected == false) {
      if (mounted) setState(() => connected = null);
      try {
        await widget.device.connect();
        await refreshKey.currentState?.show();
      } catch (e) {
        if (mounted) {
          showSnackbarOf(context, e.toString());
          setState(() => connected = false);
        }
      }
    }
  }

  Future<void> refreshFunc() async {
    characteristics.clear();
    final allCharacteristics = await Characteristic.fetchAll(widget.device);
    characteristics.addAll(allCharacteristics);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceName = widget.device.name;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8),
          leading: CircleAvatar(
            child: Text(
              deviceName == null || deviceName.isEmpty
                  ? '!'
                  : deviceName.substring(0, 1),
            ),
          ),
          title: Text(
            deviceName == null || deviceName.isEmpty ? '<Unnamed>' : deviceName,
          ),
          subtitle: Text(widget.device.deviceId),
          trailing: ConnectButton(
            connected: connected,
            device: widget.device,
            onPressed: buttonFunction,
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 250),
          padding: EdgeInsets.symmetric(vertical: 4),
          width: double.infinity,
          height: connected == true ? 160 : 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: colorSchemeOf(context).surfaceContainerHigh,
          ),
          clipBehavior: Clip.antiAlias,
          child: CharacteristicsList(
            key: refreshKey,
            characteristics: characteristics,
            refreshFunc: refreshFunc,
          ),
        ),
      ],
    );
  }
}
