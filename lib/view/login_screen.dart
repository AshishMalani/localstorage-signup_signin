import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_login/view/signup_screen.dart';

import '../PreferenceManager/preference_manager.dart';
import '../controllers/db_config_controller.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrlSignIn = TextEditingController();
  final passwordCtrlSignIn = TextEditingController();
  int Value = 0;
  final formKey = GlobalKey<FormState>();

  DBConfigController dBConfigController = Get.find<DBConfigController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                TextFormField(
                  controller: emailCtrlSignIn,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This is required Email";
                    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return "Please Enter a Valid Email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    hintText: 'Email',
                    filled: true,
                    fillColor: Color(0xffF5F6FA),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: Value != 0 ? false : true,
                  controller: passwordCtrlSignIn,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This is required Password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {});
                        },
                        child: IconButton(
                          icon: Value == 0
                              ? Icon(Icons.visibility,
                                  key: const ValueKey('icon1'))
                              : Icon(
                                  Icons.visibility_off,
                                  key: const ValueKey('icon2'),
                                ),
                          onPressed: () {
                            setState(() {
                              Value = Value == 0 ? 1 : 0;
                            });
                          },
                        )),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    hintText: 'Password',
                    filled: true,
                    fillColor: Color(0xffF5F6FA),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 55,
                  minWidth: double.infinity,
                  color: Color(0xffe7b83b),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      List result = await dBConfigController.database.rawQuery(
                          "SELECT * FROM user WHERE email='${emailCtrlSignIn.text}' AND password ='${passwordCtrlSignIn.text}'");

                      if (result.length > 0) {
                        PreferencesManager().setLogin();
                        Get.to(HomeScreen());
                      } else {
                        Get.snackbar("error", "Login failed");
                      }
                    }
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Or',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 55,
                  minWidth: double.infinity,
                  color: Color(0xff9775FA),
                  onPressed: () {
                    Get.to(SignUpScreen());
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
