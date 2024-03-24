import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_player/controller/audiopalyer_controller.dart';
import 'package:music_player/controller/search_controller.dart';
import 'package:music_player/utils/color_constants.dart';
import 'package:music_player/utils/image_constants.dart';
import 'package:music_player/view/authentication/login_screen.dart';
import 'package:music_player/view/bottom_navigationbar/bottom_navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLoginStatus();

    Future.delayed(Duration(seconds: 3)).then((value) {
      if(isLoggedIn){
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigationWidget(),
          ));
      }else{
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
      }
     
    });
    getData();
    super.initState();
  }

  Future<void> getData() async {
    Provider.of<PlayNowController>(context, listen: false).fetchDeviceSongs();
    Provider.of<SearchControllerProvider>(context, listen: false)
        .fetchDeviceSongs();
  }

bool isLoggedIn = false;
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.themeBlueColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              ConstantImage.mainLogoPng,
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ),
            Lottie.asset(ConstantImage.loadingAnimationSplash,
                height: 150, width: 150)
          ],
        ),
      ),
    );
  }
}
