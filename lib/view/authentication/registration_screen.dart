// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:music_player/utils/color_constants.dart';
// import 'package:music_player/utils/image_constants.dart';
// import 'package:music_player/view/authentication/error_message.dart';
// import 'package:music_player/view/authentication/login_screen.dart';

// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({super.key});

//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   bool _obscureText = true;
//   bool _obscureTextConfirm = true;
//   final loginKey = GlobalKey<FormState>();

//   void passwordVisibility() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   void passwordVisibilityConfirm() {
//     setState(() {
//       _obscureTextConfirm = !_obscureTextConfirm;
//     });
//   }

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final nameController = TextEditingController();
//   final confirmPasswordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final kHeight10 = SizedBox(height: 10);
//     final kHeight5 = SizedBox(height: 5);
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: ConstantColors.themeWhiteColor),
//         backgroundColor: ConstantColors.themeBlueColor,
//         elevation: 0,
//       ),
//       backgroundColor: ConstantColors.themeBlueColor,
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Form(
//             key: loginKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   ConstantImage.mainLogoPng,
//                   height: 200,
//                   width: 200,
//                 ),
//                 Text(
//                   "Create Account",
//                   style: TextStyle(
//                       color: ConstantColors.themeWhiteColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24),
//                 ),
//                 kHeight10,
//                 GestureDetector(
//                   onTap: () {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                   },
//                   child: TextFormField(
//                     style: TextStyle(color: ConstantColors.themeWhiteColor),
//                     controller: nameController,
//                     decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(8),
//                         hintText: "Enter Your Name",
//                         suffixIcon: Icon(
//                           Icons.person,
//                           color: ConstantColors.themeWhiteColor,
//                         ),
//                         hintStyle:
//                             TextStyle(color: ConstantColors.themeWhiteColor),
//                         border: OutlineInputBorder()),
//                     validator: (value) {
//                       if (nameController.text.isEmpty) {
//                         return "Enter your name";
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),
//                 ),
//                 kHeight10,
//                 GestureDetector(
//                   onTap: () {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                   },
//                   child: TextFormField(
//                     style: TextStyle(color: ConstantColors.themeWhiteColor),
//                     controller: emailController,
//                     decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(8),
//                         hintText: "Enter Email",
//                         suffixIcon: Icon(
//                           Icons.email,
//                           color: ConstantColors.themeWhiteColor,
//                         ),
//                         hintStyle:
//                             TextStyle(color: ConstantColors.themeWhiteColor),
//                         border: OutlineInputBorder()),
//                     validator: (value) {
//                       if (emailController.text.isEmpty) {
//                         return "Enter email";
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),
//                 ),
//                 kHeight10,
//                 GestureDetector(
//                   onTap: () {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                   },
//                   child: TextFormField(
//                     style: TextStyle(color: ConstantColors.themeWhiteColor),
//                     obscureText: _obscureText,
//                     controller: passwordController,
//                     decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(8),
//                         hintText: "Enter Password",
//                         suffixIcon: GestureDetector(
//                           onTap: () {
//                             passwordVisibility();
//                           },
//                           child: _obscureText
//                               ? Icon(Icons.visibility_off)
//                               : Icon(
//                                   Icons.visibility,
//                                   color: ConstantColors.themeWhiteColor,
//                                 ),
//                         ),
//                         hintStyle:
//                             TextStyle(color: ConstantColors.themeWhiteColor),
//                         border: OutlineInputBorder()),
//                     validator: (value) {
//                       if (passwordController.text.isEmpty) {
//                         return "Enter password";
//                       } else if (passwordController.text.length < 6) {
//                         return "Password must be min 6 characters";
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),
//                 ),
//                 kHeight10,
//                 kHeight10,
//                 GestureDetector(
//                   onTap: () {
//                     FocusManager.instance.primaryFocus?.unfocus();
//                   },
//                   child: TextFormField(
//                     obscureText: _obscureTextConfirm,
//                     style: TextStyle(color: ConstantColors.themeWhiteColor),
//                     controller: confirmPasswordController,
//                     decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(8),
//                         hintText: "Confirm Password",
//                         suffixIcon: GestureDetector(
//                           onTap: () {
//                             passwordVisibilityConfirm();
//                           },
//                           child: _obscureTextConfirm
//                               ? Icon(Icons.visibility_off)
//                               : Icon(
//                                   Icons.visibility,
//                                   color: ConstantColors.themeWhiteColor,
//                                 ),
//                         ),
//                         hintStyle:
//                             TextStyle(color: ConstantColors.themeWhiteColor),
//                         border: OutlineInputBorder()),
//                     validator: (value) {
//                       if (confirmPasswordController.text.isEmpty) {
//                         return "Enter confirm password";
//                       } else if (confirmPasswordController.text !=
//                           passwordController.text) {
//                         return "Password doesn't match";
//                       } else if (confirmPasswordController.text.length < 6) {
//                         return "Password must be min 6 characters";
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),
//                 ),
//                 kHeight10,
//                 GestureDetector(
//                   onTap: () async {
//                     if (loginKey.currentState!.validate()) {
//                       loginKey.currentState!.save();

//                       try {
//                         final credentials = await FirebaseAuth.instance
//                             .createUserWithEmailAndPassword(
//                                 email: emailController.text,
//                                 password: passwordController.text);

//                         if (credentials.user?.uid != null) {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => LoginScreen(),
//                               ));
//                         }
//                       } on FirebaseAuthException catch (e) {
//                         if (e.code == 'weak-password') {
//                           print('the password provided is too waek');
//                         } else if (e.code == 'email-already-in-use') {
//                           print('The account already exists for that email');
//                         }
//                         ErrorMessage.showSnackbar(e.message);
//                       } catch (e) {
//                         print(e);
//                       }
//                     }
//                   },
//                   child: Container(
//                     height: 40,
//                     width: 90,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         gradient: LinearGradient(colors: [
//                           ConstantColors.containerGradient1,
//                           ConstantColors.containerGradient2,
//                           ConstantColors.containerGradient13
//                         ])),
//                     child: Center(
//                         child: Text(
//                       "Register",
//                       style: TextStyle(
//                           color: ConstantColors.themeWhiteColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15),
//                     )),
//                   ),
//                 ),
//                 kHeight10,
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => LoginScreen(),
//                           ),
//                           (route) => false);
//                     },
//                     child: Text(
//                       "Already have an Account? Click here to Login",
//                       style: TextStyle(color: ConstantColors.themeWhiteColor),
//                     ))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
