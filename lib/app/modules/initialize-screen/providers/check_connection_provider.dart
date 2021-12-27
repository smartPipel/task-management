import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/app/utils/services/connection/check_connection.dart';
import 'package:to_do_list/app/widget/show_connection_dialog_widget.dart';

class CheckConnectionProvider with ChangeNotifier {
  final CheckConnection _checkConnection = CheckConnection();

  String? _connected;
  String? _message;
  Widget? _body;

  Widget get getBody => _body ?? CircularProgressIndicator();
  String get getValue => _connected ?? 'true';
  String get getMessage => _message ?? 'default message';

  void setConnected(String connected) {
    _connected = connected;
    notifyListeners();
  }

  void setBody(Widget body) {
    _body = body;
    notifyListeners();
  }

  void setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  CheckConnectionProvider() {
    Connectivity().onConnectivityChanged.listen((event) {
      connectivityHandler(event);
    });
  }

  void connectivityHandler(ConnectivityResult result, {Widget? child}) {
    List<String> _result = _checkConnection.resultHandler(result);
    if (_result[0] == 'false') {
      setBody(ShowConnectionDialogWidget());
    } else {
      setBody(child ?? CircularProgressIndicator());
    }
    setConnected(_result[0]);
    setMessage(_result[1]);
    notifyListeners();
    print(getMessage);
  }

  void initialLoad() async {
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    connectivityHandler(connectivityResult);
  }
}
