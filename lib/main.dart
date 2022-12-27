import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_login/view/home_screen.dart';
import 'package:local_login/view/signup_screen.dart';

import 'PreferenceManager/preference_manager.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PreferencesManager().getLogin() == null
          ? SignUpScreen()
          : HomeScreen(),
    );
  }
}
