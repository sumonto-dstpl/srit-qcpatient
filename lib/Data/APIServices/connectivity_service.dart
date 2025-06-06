// import 'package:connectivity/connectivity.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  Future<bool> checkconnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
