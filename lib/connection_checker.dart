import 'dart:async';
import 'dart:io';

import 'i_connection_checker.dart';

class ConnectionChecker implements IConnectionChecker {
  static const int _port = 53;
  static const Duration _timeout = Duration(seconds: 10);
  static final List<Map<String, dynamic>> _addressList = List.unmodifiable([
    {'address': InternetAddress('1.1.1.1'), 'port': _port, 'timeout': _timeout},
    {'address': InternetAddress('8.8.4.4'), 'port': _port, 'timeout': _timeout},
  ]);

  static Future<Map<String, dynamic>> _isReachable(Map<String, dynamic> options) async {
    try {
      final sock = await Socket.connect(options['address'], options['port'], timeout: options['timeout']);
      sock.destroy();
      return {'options': options, 'isSuccess': true};
    } catch (e) {
      return {'options': options, 'isSuccess': false};
    }
  }

  @override
  Future<bool> isConnected() async {
    final requests = _addressList.map(_isReachable).toList();
    final lastTryResults = List.unmodifiable(await Future.wait(requests));
    return lastTryResults.any((result) => result['isSuccess'] as bool);
  }
}
