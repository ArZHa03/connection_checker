# Connection Checker

Simple check connection (internet) to CloudFlare or Google.

## Features

- Check internet connection by pinging CloudFlare or Google DNS servers.
- Lightweight and easy to use.

## Installation

Add this to your package's `pubspec.yaml` file then run `pub get`:

```yaml
dependencies:
  connection_checker: 
    git: https://github.com/ArZHa03/connection_checker.git
```

## Usage

A simple check connection (internet) to CloudFlare or Google.

```dart
import 'package:connection_checker/connection_checker.dart';
```

```dart
Future<Map<String, dynamic>> fetchAPI() async {
  if (await ConnectionChecker().isConnected()) {
    // get data
    return {'status': 'connected', 'data': 'your data here'};
  } else {
    // no internet connection
    return {'status': 'disconnected', 'data': null};
  }
}
```

## Example

Here is a complete example of how to use the `ConnectionChecker`:

```dart
import 'package:flutter/material.dart';
import 'package:connection_checker/connection_checker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Connection Checker Example'),
        ),
        body: Center(
          child: FutureBuilder(
            future: ConnectionChecker().isConnected(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData && snapshot.data == true) {
                return Text('Connected to the internet');
              } else {
                return Text('No internet connection');
              }
            },
          ),
        ),
      ),
    );
  }
}
```