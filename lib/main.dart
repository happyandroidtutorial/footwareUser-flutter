import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fw_client/Pages/home_page.dart';
import 'package:fw_client/Pages/login_page.dart';
import 'package:fw_client/Pages/register_page.dart';
import 'package:fw_client/controller/home_controller.dart';
import 'package:fw_client/controller/login_controller.dart';
import 'package:fw_client/firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Footware Client',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginPage());
  }
}
