import 'package:get/get.dart';
import 'package:maroor/view/screen/admin/add_car_page.dart';
import 'package:maroor/view/screen/admin/add_driver_page.dart';

import '../../view/screen/admin/add_user_page.dart';
import '../../view/screen/admin/admin_home_page.dart';
import '../../view/screen/admin/all_violation_record_page.dart';
import '../../view/screen/splash_screen.dart';
import '../../view/screen/users/add_violation_page.dart';
import '../../view/screen/users/home_page.dart';
import '../../view/screen/show_violation_page.dart';
import '../../view/screen/users/violation_record_page.dart';

List<GetPage<dynamic>> MyPages = [
  GetPage(name: "/", page: () => SplashScreen()),
  GetPage(name: "/home", page: () => const HomePage()),
  GetPage(name: "/add_violation", page: () => const AddViolationPage()),
  GetPage(name: "/add_car", page: () => const AddCarPage()),
  GetPage(name: "/add_driver", page: () => const AddDriverPage()),
  GetPage(name: "/show_violation", page: () => const ShowViolationPage()),
  GetPage(name: "/record", page: () => const ViolationRecordPage()),
  GetPage(name: "/all_record", page: () => const AllViolationRecordPage()),
  GetPage(name: "/admin", page: () => const AdminPage()),
  GetPage(name: "/add_user", page: () => const AddUserPage())
];
