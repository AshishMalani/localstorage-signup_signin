import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_login/view/login_screen.dart';
import 'package:random_text_reveal/random_text_reveal.dart';

import '../PreferenceManager/preference_manager.dart';
import '../controllers/db_config_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailCtrlSignIn = TextEditingController();
  final fullNameCtrlSignIn = TextEditingController();
  final passwordCtrlSignIn = TextEditingController();
  int Value = 0;
  final formKey = GlobalKey<FormState>();

  DBConfigController dBConfigController = Get.put(DBConfigController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DBConfigController>(
        builder: (controller) {
          if (controller.isDbConfig) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 150,
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: fullNameCtrlSignIn,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This is required User Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          hintText: 'User Name',
                          filled: true,
                          fillColor: Color(0xffF5F6FA),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
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
                        height: 20,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
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
                        color: Color(0xff9775FA),
                        onPressed: () async {
                          print("create");
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          currentFocus.unfocus();

                          if (formKey.currentState!.validate()) {
                            await saveDetail();
                            PreferencesManager().setLogin();
                            Get.to(
                              LoginScreen(),
                            );
                          }
                        },
                        child: FadeInLeft(
                          child: RandomTextReveal(
                            text: 'Sign Up',
                            duration: Duration(seconds: 1),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            curve: Curves.easeIn,
                          ),
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
                          Get.to(
                            LoginScreen(),
                          );
                        },
                        child: FadeInRight(
                          child: RandomTextReveal(
                            text: 'Login',
                            duration: Duration(seconds: 1),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            curve: Curves.easeIn,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> saveDetail() async {
    int id = await dBConfigController.database.insert(
      'user',
      {
        'id': null,
        'username': fullNameCtrlSignIn.text,
        'email': emailCtrlSignIn.text,
        'password': passwordCtrlSignIn.text
      },
    );

    print(
      "inserted id:$id",
    );
  }
}
