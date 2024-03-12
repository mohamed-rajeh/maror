import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maroor/view/screen/appstartup.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.off(AppStartup());
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Builder(builder: (context) {
              return Image.asset('images/splash.png');
            }),
          ),
        ),
      ),
    );
  }
}
