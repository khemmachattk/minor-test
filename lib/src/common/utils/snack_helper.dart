import 'package:flutter/material.dart';

enum SnackBarType { success, error }

void showSnackBar(
  BuildContext context, {
  required String text,
  SnackBarType? type = SnackBarType.success,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: type == SnackBarType.error ? Colors.red : Colors.green,
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
    ),
  );
}