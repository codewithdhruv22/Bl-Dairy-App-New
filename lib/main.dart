import 'package:bl_dairy_app/constants/Theme.dart';
import 'package:bl_dairy_app/view/blshop/CustomerShop.dart';
import 'package:bl_dairy_app/view/blshop/shopMain.dart';
import 'package:bl_dairy_app/view/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {});
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BhagyaLaxmi Dairy App',
        theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
          primaryColor: MyColors.primary,
        ),
        home:  ShopMain(initialIndex: 0,));
  }
}
