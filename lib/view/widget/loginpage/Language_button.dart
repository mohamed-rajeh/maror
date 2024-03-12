import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/constant/them.dart';
import '../../../controller/locale_controller.dart';
import '../admin/custom_dialog.dart';

class LangButton extends StatelessWidget {
  final langController = Get.find<MyLocaleController>();
  LangButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: wight, width: 2),
        // color: wight,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () {
          Get.dialog(
            barrierDismissible: false,
            Dialog(
                child: CDialog(
              icon: Icons.translate,
              titel: "changeLang".tr,
              btn1Text: "العربية",
              btn2Text: "English",
              onTapB1: () {
                langController.changeLang("ar");
                Get.back();
              },
              onTapB2: () {
                langController.changeLang("en");
                print("object");
                Get.back();
              },
            )),
          );
        },
        splashColor: darkColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            "lang".tr,
            style: TextStyle(
                color: black, fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
