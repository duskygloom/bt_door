import 'package:bt_door/model/characteristic.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class CharacteristicTile extends StatelessWidget {
  const CharacteristicTile({
    super.key,
    required this.characteristic,
    this.onRefresh,
  });

  final Characteristic characteristic;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      title: ValueDisplay(characteristic: characteristic, onRefresh: onRefresh),
    );
  }
}

class ValueDisplay extends StatelessWidget {
  const ValueDisplay({super.key, required this.characteristic, this.onRefresh});

  final Characteristic characteristic;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final valueFuture = characteristic.fetchValue();
    return FutureBuilder(
      future: valueFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        } else if (snapshot.hasData) {
          final textCtrl = TextEditingController(text: snapshot.data);
          final name = characteristic.name;
          return TextFormField(
            decoration: InputDecoration(
              prefixIcon: name == 'Sender'
                  ? Icon(Symbols.upload)
                  : name == 'Receiver'
                  ? Icon(Symbols.download)
                  : Icon(Symbols.error),
            ),
            controller: textCtrl,
            textAlign: TextAlign.center,
            enabled: characteristic.type == 'WRITE',
            textInputAction: TextInputAction.go,
            onEditingComplete: () async {
              await characteristic.sendValue(textCtrl.text);
            },
          );
        } else {
          return Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: onRefresh,
              icon: Icon(Symbols.refresh),
            ),
          );
        }
      },
    );
  }
}
