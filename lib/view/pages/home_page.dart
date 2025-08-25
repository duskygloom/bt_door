import 'dart:math';

import 'package:bt_door/main_theme.dart';
import 'package:bt_door/view/widgets/appbar.dart';
import 'package:bt_door/view/widgets/devices_list.dart';
import 'package:bt_door/view/widgets/scan_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: min(screenWidthOf(context), bigScreenWidth),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: DevicesList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ScanButton(),
    );
  }
}
