import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constant/them.dart';
import '../../view/screen/login_page.dart';
import '../../view/widget/admin/custom_dialog.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: darkColor,
      icon: Icon(
        Icons.exit_to_app,
        color: black,
        size: 28,
      ),
      onPressed: () {
        Get.dialog(
            barrierDismissible: false,
            Dialog(
              child: CDialog(
                  onTapB2: () {
                    GetStorage().erase(); //Do delete saved data
                    Get.offAll(LoginPage());
                  },
                  onTapB1: () => Get.back()),
            ));
      },
    );
  }
}
