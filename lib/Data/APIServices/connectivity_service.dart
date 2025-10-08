// import 'package:connectivity/connectivity.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

// class ConnectivityService {
//   Future<bool> checkconnectivity() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.mobile) {
//       return true;
//     } else if (connectivityResult == ConnectivityResult.wifi) {
//       return true;
//     }
//     return false;
//   }
// }

import 'dart:io';

class ConnectivityService {
  Future<bool> checkconnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}