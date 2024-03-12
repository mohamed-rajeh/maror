import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maroor/components/constant/them.dart';

import 'package:maroor/controller/login_page_controller.dart';

import '../widget/loginpage/Language_button.dart';
import '../widget/loginpage/login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginPageController controller = Get.put(LoginPageController());

    return GestureDetector(
        onTap: () {
          //? To close the Kebord whene clicking on screen
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: primaryColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  MySingleChildScrollView(controller: controller),
                  Positioned(child: LangButton()),
                ],
              ),
            ),
          ),
        ));
  }
}

class MySingleChildScrollView extends StatelessWidget {
  const MySingleChildScrollView({
    super.key,
    required this.controller,
  });

  final LoginPageController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LoginPageBody(controller: controller),
      ),
    );
  }
}
