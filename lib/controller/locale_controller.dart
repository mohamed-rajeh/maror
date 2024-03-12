import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MyLocaleController extends GetxController {
  Locale intialLang =
      GetStorage().read("lang") == "ar" ? Locale("ar") : Locale("en");
  void changeLang(String langCode) {
    Locale locale = Locale(langCode);
    GetStorage().write("lang", langCode);
    Get.updateLocale(locale);
  }
}
