import 'package:connectivity_plus/connectivity_plus.dart';

extension ConnResultUtils on ConnectivityResult {
  bool get isConnected {
    return this == ConnectivityResult.mobile || this == ConnectivityResult.wifi;
  }
}
