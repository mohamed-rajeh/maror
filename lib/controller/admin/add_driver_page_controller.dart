import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maroor/components/function/images.dart';

import '../../components/shared/snackbar.dart';
import '../../model/driver.dart';
import '../driver_controller.dart';

class AddDiverPageController extends GetxController {
  final TextEditingController id = TextEditingController();

  final TextEditingController name = TextEditingController();

  final TextEditingController city = TextEditingController();

  final TextEditingController licons = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DriverController driverCon = Get.put(DriverController());
  bool isUpdate = false;

  Uint8List? imageFile;

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Check image size before processing
      final fileSize = await pickedFile.length();
      if (fileSize <= 2 * 1024 * 1024) {
        // 2 MB limit
        imageFile = await getFileBytes(pickedFile);

        update(); // update  UI
      } else {
        showSnackBar('msgImageToBig'.tr);
      }
    }
  }

  submit() async {
    if (formKey.currentState!.validate()) {
      Driver driver = Driver(
          id: int.parse(id.text),
          name: name.text,
          city: city.text,
          license: licons.text,
          photo: imageFile);

      // cheack if we click on add buttton or not

      isUpdate
          ? await driverCon.updateDriver(driver) > 0
              ? {Get.back(), showSnackBar("msgEditD".tr)}
              : showSnackBar("Field")
          : await driverCon.insertDriver(driver) > 0
              ? {Get.back(), showSnackBar("msgAddD".tr)}
              : showSnackBar("Field");
    }
  }

  set driver(Driver? value) {
    if (value != null) {
      id.text = value.id.toString();
      name.text = value.name;
      licons.text = value.license;
      city.text = value.city;
      imageFile = value.photo;
      isUpdate = true;
    }
  }
}
