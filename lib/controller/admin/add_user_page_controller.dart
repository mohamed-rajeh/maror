import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maroor/components/shared/snackbar.dart';
import 'package:maroor/controller/user_controller.dart';
import 'package:maroor/model/user.dart';

class AddUserPageController extends GetxController {
  final TextEditingController userName = TextEditingController();

  final TextEditingController type = TextEditingController();

  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool allow = true;

  int? id;

  UserController userCon = Get.find();
  cheackAllow(bool value) {
    allow = value;
    update;
  }

  set user(value) {
    if (value != null) {
      userName.text = value.name;
      type.text = value.type;
      password.text = value.password;
      id = value.id;
      allow = value.allow == 1 ? true : false;
    }
  }

  submit() async {
    try {
      if (formKey.currentState!.validate()) {
        User? user = User(
            id: id,
            name: userName.text,
            type: type.text,
            password: password.text,
            allow: allow ? 1 : 0);
        await userCon.submit(user);
        Get.back();
        formKey.currentState!.reset();
      }
    } catch (e) {
      showSnackBar("Some thing Wrong ,try latter!");
    }
  }
}
