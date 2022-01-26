import 'package:flutter/material.dart';
import 'package:test_arkademi/view/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/dashboard':
      return MaterialPageRoute(
          settings: routeSettings(settings),
          builder: (context) => const HomeScreen());

    default:
      return MaterialPageRoute(
          settings: routeSettings(settings),
          builder: (context) => const HomeScreen());
  }
}

RouteSettings routeSettings(RouteSettings settings) =>
    RouteSettings(name: settings.name);
