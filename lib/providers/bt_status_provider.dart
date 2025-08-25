import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_ble/universal_ble.dart';

class BTStatusProvider extends ChangeNotifier {
  bool _active = false;

  BTStatusProvider() {
    UniversalBle.availabilityStream.listen(
      (state) {
        _active = state == AvailabilityState.poweredOn;
        notifyListeners();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  static bool activeOf(BuildContext context, [bool listen = false]) {
    return Provider.of<BTStatusProvider>(context, listen: listen)._active;
  }
}
