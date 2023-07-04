import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:minor_register/src/app.dart';

void main() {
  FlavorConfig(
    variables: {
      "apiKey": 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyZWZfaWQiOiI4Mjk3ZWMzYS0zMjQzLTQ3YTUtYWZkMi02NDkxNjEzN2E2NzgiLCJleHAiOjE2OTA0NDkzMDEsImlhdCI6MTY4ODM3NTcwMSwiaXNzIjoicmVjcnVpdG1lbnQuZmUuYXBpIn0.G5pt9eQq5iRF7xcRznoiB-Z-IeFQfNP7kzHHp2MMp0Y',
      "baseUrl": 'https://rehlnnzmnii3vunend7gatv7zq0ydqwa.lambda-url.ap-southeast-1.on.aws',
    },
  );

  runApp(const App());
}
