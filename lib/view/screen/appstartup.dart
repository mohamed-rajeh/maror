import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maroor/view/screen/admin/admin_home_page.dart';

import 'users/home_page.dart';
import 'login_page.dart';

class AppStartup extends StatelessWidget {
  AppStartup({super.key});
  final box = GetStorage();
  Widget start() {
    String? authenticated = box.read('type');

    if (authenticated == "admin") {
      return const AdminPage();
    }
    if (authenticated == "user") {
      return const HomePage();
    }

    return const LoginPage();
  }

  @override
  Widget build(BuildContext context) {
    return start();
  }
}
