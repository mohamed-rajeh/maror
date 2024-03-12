import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/them.dart';

void showSnackBar(String text) {
  Get.showSnackbar(GetSnackBar(
    messageText: Text(
      text,
      style: style,
    ),
    backgroundColor: secondaryColor,
    duration: const Duration(milliseconds: 1500),
    snackPosition: SnackPosition.TOP,
  ));
}
