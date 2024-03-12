import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maroor/components/shared/snackbar.dart';
import 'package:maroor/controller/cars_controller.dart';
import 'package:maroor/model/car.dart';
import 'package:maroor/model/driver.dart';

class AddCarPageController extends GetxController {
  final TextEditingController number = TextEditingController();

  final TextEditingController model = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Driver? owner;

  final CarsController carCon = Get.put(CarsController());

  updateSelectedValue(Driver val) {
    owner = val;
    update();
  }

  set car(Car? value) {
    if (value != null) {
      number.text = value.number;
      model.text = value.model;
      owner = value.owner!;
    }
  }

  submit() async {
    if (formKey.currentState!.validate()) {
      if (owner == null) {
        showSnackBar("Please Chose Driver");
        return;
      }
      Car? car = Car(number: number.text, model: model.text, owner: owner);
      Get.back();
      await carCon.submit(car);
    }
  }

  delete() async {
    Car? car = Car(number: number.text, model: model.text, owner: owner);

    await carCon.deleteCar(car.number);
    update();
  }
}
