import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_login/view/signup_screen.dart';

import '../PreferenceManager/preference_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () async {
                  await PreferencesManager().logOut();
                  Get.offAll(SignUpScreen());
                },
                child: Icon(Icons.logout),
              ),
            ],
          ),
          SizedBox(
            height: 350,
          ),
          Center(
            child: Text(
              "Home Screen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
