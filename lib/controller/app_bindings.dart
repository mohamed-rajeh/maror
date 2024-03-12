import 'package:get/get.dart';

import 'cars_controller.dart';
import 'db_controller.dart';
import 'driver_controller.dart';
import 'user_controller.dart';
import 'users/home_controller.dart';
import 'users/type_controller.dart';
import 'users/violation_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(DbController());
    Get.put(UserController());
    Get.put(DriverController());
    Get.put(CarsController());
    Get.put(TypeController());
    Get.put(ViolationController());
    Get.put(HomeController());
  }
}
