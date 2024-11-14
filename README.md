## Usage
A simple check connection (internet) to CloudFlare or Google.

```dart
Future<Map<String, dynamic>> fetchAPI() async {
    if (await ConnectionChecker().isConnected()) return // get data
    return // no internet connection
}
```