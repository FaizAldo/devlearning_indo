import 'package:devlearning_indo/pages/form_daftar.dart';
import 'package:devlearning_indo/pages/home.dart';
import 'package:devlearning_indo/pages/login_screen.dart';
import 'package:devlearning_indo/pages/tes.dart';
import 'package:devlearning_indo/pages/validasi.dart';
import 'package:devlearning_indo/preference_system/preference.dart';
import 'package:devlearning_indo/splash/splash.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await PreferenceHandler.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Devlearning.Indo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Poppins',
      ),
      home: const Splash(),
    );
  }
}
