import 'package:flutter/material.dart';
import 'package:to_do_list/app/modules/create-to-do/view/create_to_do.dart';
import 'package:to_do_list/app/modules/home-screen/view/home.dart';
import 'package:to_do_list/app/modules/initialize-screen/view/initial.dart';

part 'routes_list.dart';

class RoutesGenerate {
  static Route<dynamic> genrate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (_) => const InitializeScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.createRoute:
        return MaterialPageRoute(builder: (_) => const CreateToDo());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
