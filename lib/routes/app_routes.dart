import 'package:examen/screen/edit_category_screen.dart';
import 'package:examen/screen/main.screen.dart';
import 'package:flutter/material.dart';
import 'package:examen/screen/screen.dart';

import '../screen/edit_proveedor_screen.dart';

class AppRoutes {
  static const initialRoute = 'login';
  static Map<String, Widget Function(BuildContext)> routes = {
    'mainScreen': (BuildContext context) => const MainScreen(),
    'login': (BuildContext context) => const LoginScreen(),
    'list': (BuildContext context) => const ListProductScreen(),
    'edit': (BuildContext context) => const EditProductScreen(),
    'edit_category': (BuildContext context) => const EditCategoryScreen(),
    'edit_proveedor': (BuildContext context) => const EditProveedorScreen(),
    'add_user': (BuildContext context) => const RegisterUserScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}
