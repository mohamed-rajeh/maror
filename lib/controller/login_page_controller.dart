import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maroor/controller/user_controller.dart';

class LoginPageController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final user = Get.find<UserController>();
  void submitForm() async {
    if (formKey.currentState!.validate()) {
      // Validation successful, proceed with login
      String enteredUsername = username.text;
      String enteredPassword = password.text;
      await user.validateUser(enteredUsername, enteredPassword);
      // Reset the form after successful login;
      formKey.currentState!.reset();
    }
  }
}
