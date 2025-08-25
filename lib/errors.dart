import 'package:flutter/material.dart';

void showSnackbarOf(BuildContext context, String message) {
  final snackbar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
