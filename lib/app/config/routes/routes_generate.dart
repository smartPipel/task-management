import 'package:flutter/material.dart';
import 'package:to_do_list/app/modules/create-task/view/create_task_screen.dart';
import 'package:to_do_list/app/modules/home-screen/view/home_screen.dart';
import 'package:to_do_list/app/modules/initialize-screen/view/initial.dart';
import 'package:to_do_list/app/modules/login-screen/view/login_screen.dart';

part 'routes_list.dart';

class RoutesGenerate {
  static Route<dynamic> genrate(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (_) => const InitializeScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.createRoute:
        return MaterialPageRoute(builder: (_) => const CreateTaskScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
