import 'package:bl_dairy_app/view/screens/auth/login.dart';
import 'package:bl_dairy_app/view/screens/auth/verify_otp.dart';
import 'package:bl_dairy_app/view/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
        title: 'BhagyaLaxmi Dairy App', theme: ThemeData(), home: verify_otp());
=======
        title: 'BhagyaLaxmi Dairy App', theme: ThemeData(), home: login());
>>>>>>> 100c7f58b344e6df82b36a3c73eec27411794cb2
  }
}
