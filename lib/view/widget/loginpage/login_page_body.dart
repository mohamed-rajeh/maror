import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../animation/fade_in.dart';
import '../../../components/constant/them.dart';
import '../../../components/function/valid.dart';
import '../../../controller/login_page_controller.dart';
import '../homepage/c_text_field.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({
    super.key,
    required this.controller,
  });

  final LoginPageController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimationImage(),
        LoginPageForm(controller: controller),
      ],
    );
  }
}

class LoginPageForm extends StatelessWidget {
  const LoginPageForm({
    super.key,
    required this.controller,
  });

  final LoginPageController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          AnimetedUserNameFeild(controller: controller),
          const SizedBox(height: 15),
          AnimatedPasswordFeild(controller: controller),
          const SizedBox(height: 20),
          FadeInAnimation(
            delay: 1.7,
            direction: FadeInDirection.btt,
            fadeOffset: 20,
            child: ElevatedButton(
              onPressed: () => controller.submitForm(),
              //  onPressed: controller.submitForm,
              style: ElevatedButton.styleFrom(
                shadowColor: darkColor,
                elevation: 10,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                backgroundColor: darkColor,
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: Text(
                "login".tr,
                style: TextStyle(color: wight),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AnimatedPasswordFeild extends StatelessWidget {
  const AnimatedPasswordFeild({
    super.key,
    required this.controller,
  });

  final LoginPageController controller;

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      delay: 1.7,
      direction: FadeInDirection.rtl,
      fadeOffset: 20,
      child: CTextField(
          controller: controller.password,
          color: wight,
          borderColre: primaryColor,
          isPass: true,
          hint: "pass".tr,
          icon: Icons.lock,
          validator: (value) => validInput(value!, 3, 50)),
    );
  }
}

class AnimetedUserNameFeild extends StatelessWidget {
  const AnimetedUserNameFeild({
    super.key,
    required this.controller,
  });

  final LoginPageController controller;

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      delay: 1.7,
      direction: FadeInDirection.ltr,
      fadeOffset: 20,
      child: CTextField(
          controller: controller.username,
          color: wight,
          borderColre: primaryColor,
          hint: "userName".tr,
          icon: Icons.person,
          validator: (value) => validInput(value!, 1, 20)),
    );
  }
}

class AnimationImage extends StatelessWidget {
  const AnimationImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      delay: 1.7,
      direction: FadeInDirection.ttb,
      fadeOffset: 20,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Image.asset(
          "images/png.png",
          height: 300,
        ),
      ),
    );
  }
}
