import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maroor/view/widget/admin/custom_dialog.dart';

import '../../../components/constant/them.dart';
import '../../screen/login_page.dart';

class CAppBar extends AppBar {
  CAppBar({super.key})
      : super(
          foregroundColor: darkColor,
          backgroundColor: primaryColor,
          title: Text("maroor".tr),
          centerTitle: true,
          leading: PopupMenuButton(
            icon: const Icon(
              Icons.clear_all_rounded,
              size: 30,
              color: darkColor, // Set the icon color here
            ),
            itemBuilder: (ctx) => [
              _buildPopupMenuItem(
                "records".tr,
                Icons.recent_actors_outlined,
                () {
                  Get.back();
                  Get.toNamed("/record");
                },
              ),
              _buildPopupMenuItem(
                'logout'.tr,
                Icons.logout,
                () {
                  Get.dialog(barrierDismissible: false, Dialog(
                    child: CDialog(onTapB2: () {
                      GetStorage().erase(); //To delete saved data
                      Get.offAll(const LoginPage());
                    }),
                  ));
                },
              ),
            ],
          ),
        );

  static PopupMenuItem _buildPopupMenuItem(
      String title, IconData iconData, Function()? function) {
    return PopupMenuItem(
      child: InkWell(
        onTap: function,
        child: Row(
          children: [
            Icon(
              iconData,
              color: darkColor, // Set the icon color here
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}
