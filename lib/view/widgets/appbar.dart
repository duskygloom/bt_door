import 'package:bt_door/view/widgets/bluetooth_button.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('DoorBLE'),
      forceMaterialTransparency: true,
      actions: [BluetoothButton()],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight);
}
