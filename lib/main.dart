import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'components/constant/app_pages.dart';
import 'components/localization/locale.dart';
import 'controller/app_bindings.dart';
import 'controller/locale_controller.dart';

void main() async {
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyLocaleController _controller = Get.put(MyLocaleController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maroor',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Cairo'),
      getPages: MyPages,
      locale: _controller.intialLang,
      initialBinding: AppBindings(),
      translations: MyLocale(),
    );
  }
}
