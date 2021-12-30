import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnection {
  static final _check = CheckConnection._singleton();
  static ConnectivityResult _connectivityResult = ConnectivityResult.none;

  CheckConnection._singleton();

  factory CheckConnection() {
    return _check;
  }

  List<String> resultHandler(ConnectivityResult result) {
    _connectivityResult = result;

    if (result == ConnectivityResult.none) {
      return ['false', 'Tidak ada koneksi internet'];
    } else if (result == ConnectivityResult.wifi) {
      return ['true', 'Terkoneksi dengan jaringan wifi'];
    } else if (result == ConnectivityResult.mobile) {
      return ['true', 'Terkoneksi dengan jaringan seluler'];
    }

    return ['true', 'Terkoneksi dengan ethernet'];
  }
}
