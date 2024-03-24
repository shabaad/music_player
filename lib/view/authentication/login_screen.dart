// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/image_constants.dart';
import 'package:music_player/view/authentication/error_message.dart';
import 'package:music_player/view/authentication/registration_screen.dart';
import 'package:music_player/view/bottom_navigationbar/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  void passwordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final loginKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final kHeight10 = SizedBox(height: 10);
    final kHeight5 = SizedBox(height: 5);
    return Scaffold(
      backgroundColor: ConstantColors.themeBlueColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ConstantImage.mainLogoPng,
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    "LogIn",
                    style: TextStyle(
                        color: ConstantColors.themeWhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  kHeight10,
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: TextFormField(
                      style: TextStyle(color: ConstantColors.themeWhiteColor),
                      controller: emailController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: "email",
                          suffixIcon: Icon(
                            Icons.email,
                            color: ConstantColors.themeWhiteColor,
                          ),
                          hintStyle:
                              TextStyle(color: ConstantColors.themeWhiteColor),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (emailController.text.isEmpty) {
                          return "Enter Email";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  kHeight10,
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: TextFormField(
                      obscureText: _obscureText,
                      style: TextStyle(color: ConstantColors.themeWhiteColor),
                      controller: passwordController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: "password",
                          suffixIcon: GestureDetector(
                            onTap: () {
                              passwordVisibility();
                            },
                            child: _obscureText
                                ? Icon(Icons.visibility_off)
                                : Icon(
                                    Icons.visibility,
                                    color: ConstantColors.themeWhiteColor,
                                  ),
                          ),
                          hintStyle:
                              TextStyle(color: ConstantColors.themeWhiteColor),
                          border: OutlineInputBorder()),
                      validator: (value) {
                        if (passwordController.text.isEmpty) {
                          return "Enter password";
                        } else if (passwordController.text.length < 6) {
                          return 'password must be min 6 characters';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: ConstantColors.themeWhiteColor,
                                decoration: TextDecoration.underline,
                                decorationColor:
                                    ConstantColors.themeWhiteColor),
                          ))
                    ],
                  ),
                  kHeight10,
                  GestureDetector(
                    onTap: () async {
                      if (emailController.text == "email" &&
                          passwordController.text == "password") {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', true);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigationWidget(),
                            ));
                      } else {
                        Fluttertoast.showToast(msg:
                            "Please fill login details as email and password");
                      }

                      // if (loginKey.currentState!.validate()) {
                      //   loginKey.currentState!.save();

                      //   try {
                      //     final credential = await FirebaseAuth.instance
                      //         .signInWithEmailAndPassword(
                      //             email: emailController.text,
                      //             password: passwordController.text);
                      //     if (credential.user?.uid != null) {
                      //       Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) =>
                      //                 BottomNavigationWidget(),
                      //           ));
                      //     }
                      //   } on FirebaseAuthException catch (e) {
                      //     if (e.code == 'user-not-found') {
                      //       print('no user found');
                      //     } else if (e.code == 'wrong-password') {
                      //       print('wrong password provided');
                      //     }
                      //     ErrorMessage.showSnackbar(e.message);
                      //   }
                      // }
                    },
                    child: Container(
                      height: 40,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(colors: [
                            ConstantColors.containerGradient1,
                            ConstantColors.containerGradient2,
                            ConstantColors.containerGradient13
                          ])),
                      child: Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                            color: ConstantColors.themeWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                    ),
                  ),
                  kHeight10,
                  // TextButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => RegistrationScreen(),
                  //           ));
                  //     },
                  //     child: Text(
                  //       "Don't have an Account? Click here to register",
                  //       style: TextStyle(color: ConstantColors.themeWhiteColor),
                  //     ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
