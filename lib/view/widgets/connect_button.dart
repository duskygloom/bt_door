import 'dart:async';
import 'package:bt_door/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:universal_ble/universal_ble.dart';

class ConnectButton extends StatelessWidget {
  const ConnectButton({
    super.key,
    required this.connected,
    required this.device,
    this.onPressed,
  });

  final bool? connected;
  final BleDevice device;
  final FutureOr<void> Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final Widget icon;
    if (connected == null) {
      icon = SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else if (connected == true) {
      icon = Icon(Symbols.link, color: activeColorOf(context));
    } else {
      icon = Icon(Symbols.link_off);
    }

    return IconButton(onPressed: onPressed, icon: icon);
  }
}
