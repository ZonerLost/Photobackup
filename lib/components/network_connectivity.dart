import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { online, offline }

class NetworkConnectivity {
  NetworkConnectivity._(); // private constructor
  static final NetworkConnectivity instance = NetworkConnectivity._();

  Future<NetworkStatus> getNetworkStatus() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return NetworkStatus.offline;
    } else {
      return NetworkStatus.online;
    }
  }
}
