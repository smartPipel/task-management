import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityProvider with ChangeNotifier {
  ConnectivityProvider() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      resultHandler(result);
    });
  }
  String _isConnect = 'false';
  String _message = 'Menyambungkan';
  String get isConnect => _isConnect;

  set isConnect(String value) {
    _isConnect = value;
    notifyListeners();
  }

  get message => _message;

  set message(value) {
    _message = value;
    notifyListeners();
  }

  ConnectivityResult _result = ConnectivityResult.none;
  ConnectivityResult get connectivity => _result;

  void resultHandler(ConnectivityResult result) {
    _result = result;

    if (result == ConnectivityResult.none) {
      isConnect = 'false';
      message = 'Tidak ada koneksi internet';
    } else if (result == ConnectivityResult.wifi) {
      isConnect = 'true';
      message = 'Terkoneksi dengan wifi';
    } else if (result == ConnectivityResult.mobile) {
      isConnect = 'true';
      message = 'Terkoneksi dengan mobile data';
    }

    notifyListeners();
  }

  void initialLoad() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    resultHandler(connectivityResult);
  }
}
