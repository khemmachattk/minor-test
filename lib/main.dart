import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:minor_register/src/app.dart';

void main() {
  FlavorConfig(
    variables: {
      "apiKey": 'test_api_key',
      "baseUrl": 'http://localhost:8080',
    },
  );

  runApp(const App());
}
