import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:maroor/controller/user_controller.dart';

import 'package:maroor/model/user.dart';
import 'package:maroor/model/violations_type.dart';

import '../../model/car.dart';

import '../../model/violation.dart';
import 'type_controller.dart';
import 'violation_controller.dart';

class AddViolationController extends GetxController {
  final TextEditingController note = TextEditingController();
  final TextEditingController loction = TextEditingController();
  final TypeController _typeController = Get.find();
  final ViolationController _violationController = Get.find();
  final UserController _userController = Get.find();

  final Car car = Get.arguments;

  addDate() async {
    int? userId = GetStorage().read("user");

    DateTime date = DateTime.now();

    ViolationType? type = await _typeController
        .getViolationTypeById(_typeController.selectedValue);

    User? user = await _userController.getUserById(userId!);

    Violation violtion = Violation(
        date: date,
        type: type!,
        car: car,
        user: user!,
        note: note.text,
        loction: loction.text);

    _violationController.insertViolation(violtion);

    Get.offNamed("record");
  }
}
