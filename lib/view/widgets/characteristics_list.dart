import 'dart:async';
import 'package:bt_door/model/characteristic.dart';
import 'package:bt_door/view/widgets/characteristic_tile.dart';
import 'package:bt_door/view/widgets/empty_list.dart';
import 'package:bt_door/view/widgets/scroll_area.dart';
import 'package:flutter/material.dart';

class CharacteristicsList extends StatelessWidget {
  const CharacteristicsList({
    super.key,
    required this.characteristics,
    required this.refreshFunc,
  });

  final List<Characteristic> characteristics;
  final Future<void> Function() refreshFunc;

  @override
  Widget build(BuildContext context) {
    final characteristicsList = Align(
      alignment: Alignment.center,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: characteristics.length,
        itemBuilder: (context, index) => CharacteristicTile(
          characteristic: characteristics[index],
          onRefresh: refreshFunc,
        ),
      ),
    );

    return ScrollArea(
      child: RefreshIndicator(
        onRefresh: refreshFunc,
        child: characteristics.isEmpty ? EmptyList() : characteristicsList,
      ),
    );
  }
}
