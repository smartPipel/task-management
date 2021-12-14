import 'package:flutter/material.dart';
import 'package:to_do_list/app/modules/home-screen/view/home.dart';
import 'package:to_do_list/app/modules/initialize-screen/initial.dart';

part './route_list.dart';

class RouteGenerate {
  static Route<dynamic> genrate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (_) => const InitializeScreen());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
