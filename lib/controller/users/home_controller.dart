import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/constant/them.dart';
import '../../model/car.dart';

import '../cars_controller.dart';
import '../driver_controller.dart';

class HomeController extends GetxController {
  CarsController carController = Get.find();
  DriverController driverController = Get.find();

  bool isLoading = false;
  final number = TextEditingController();

  void check() async {
    isLoading = true;
    update();

    await Future.delayed(const Duration(seconds: 2));
    isLoading = false;
    update();

    Car? carDetails = await carController.getCarByNumber(number.text);
    if (carDetails != null) {
      Get.toNamed("/add_violation", arguments: carDetails);
    } else {
      showSnackBar();
    }
  }
}

void showSnackBar() {
  Get.showSnackbar(GetSnackBar(
    messageText: Text(
      "msgNoCar".tr,
      style: style,
    ),
    backgroundColor: secondaryColor,
    duration: Duration(milliseconds: 1500),
    snackPosition: SnackPosition.TOP,
  ));
}
