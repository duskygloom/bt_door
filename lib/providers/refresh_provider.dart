import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef RefreshKeyType = GlobalKey<RefreshIndicatorState>;

class RefreshProvider {
  final devicesKey = RefreshKeyType();

  static RefreshKeyType devicesKeyOf(
    BuildContext context, [
    bool listen = false,
  ]) {
    return Provider.of<RefreshProvider>(context, listen: listen).devicesKey;
  }
}
