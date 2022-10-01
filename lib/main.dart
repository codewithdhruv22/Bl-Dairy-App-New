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

        title: 'BhagyaLaxmi Dairy App', theme: ThemeData(), home: Home());

  }
}
