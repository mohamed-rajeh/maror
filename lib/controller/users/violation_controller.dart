import 'package:get/get.dart';
import 'package:maroor/components/shared/snackbar.dart';
import 'package:maroor/controller/db_controller.dart';
import 'package:maroor/controller/users/type_controller.dart';
import 'package:maroor/model/car.dart';
import 'package:maroor/model/user.dart';
import 'package:maroor/model/violations_type.dart';

import '../../model/violation.dart';
import '../cars_controller.dart';
import '../user_controller.dart';

class ViolationController extends GetxController {
  final _dbController = Get.find<DbController>();
  final CarsController _carController = Get.find();
  final UserController _userController = Get.find();
  final TypeController _typeController = Get.find();

  Future<void> insertViolation(Violation violation) async {
    final db =
        await _dbController.db; // Assuming you have a getter for the database

    try {
      const sql = '''
      INSERT INTO violations (date, type_id, note,loction, car_number, user_id)
      VALUES (?, ?, ?, ?,? ,?)
    ''';
      final values = [
        violation.date.toIso8601String(),
        violation.type.id,
        violation.note,
        violation.loction,
        violation.car.number,
        violation.user.id
      ];
      final id = await db.rawInsert(sql, values);
      showSnackBar('Violation inserted successfully with ID: $id');
    } catch (e) {
      // Handle errors gracefully
      print('Error inserting violation: $e');
    }
  }

  Future<List<Violation>> getAllViolationsByUser(int userId) async {
    try {
      final db = await _dbController.db;
      final sql = '''
      SELECT * FROM violations WHERE user_id=$userId
    ''';
      final results = await db.rawQuery(sql);
      List<Violation> violations = [];
      for (var v in results) {
        int id = v["id"] as int;
        DateTime date = DateTime.parse(v["date"].toString());
        String? note = v["note"] != null ? v["note"] as String : null;
        String? loction = v["loction"] as String?;

        int typeId = v["type_id"] as int;
        String? carNumber = v["car_number"] as String;
        int userId = v["user_id"] as int;
        ViolationType? type =
            await _typeController.getViolationTypeById(typeId);
        Car? car = await _carController.getCarByNumber(carNumber);
        User? user = await _userController.getUserById(userId);
        violations.add(Violation(
            id: id,
            note: note,
            loction: loction ?? "",
            date: date,
            type: type!,
            car: car!,
            user: user!));
      }

      return violations;
    } catch (e) {
      // Handle errors gracefully
      showSnackBar("Hi Error getting all violations: $e");
      print(e);
      rethrow; // Rethrow to allow outer code to handle the exception
    }
  }

  Future<List<Violation>> getAllViolations() async {
    try {
      final db = await _dbController.db;
      final sql = '''
      SELECT * FROM violations
    ''';
      final results = await db.rawQuery(sql);
      List<Violation> violations = [];
      for (var v in results) {
        int id = v["id"] as int;
        DateTime date = DateTime.parse(v["date"].toString());
        String? note = v["note"] != null ? v["note"] as String : null;
        String? loction = v["loction"] != null ? v["note"] as String : "";

        int typeId = v["type_id"] as int;
        String? carNumber = v["car_number"] as String;
        int userId = v["user_id"] as int;
        ViolationType? type =
            await _typeController.getViolationTypeById(typeId);
        Car? car = await _carController.getCarByNumber(carNumber);
        User? user = await _userController.getUserById(userId);
        violations.add(Violation(
            id: id,
            note: note,
            loction: loction,
            date: date,
            type: type!,
            car: car!,
            user: user!));
      }

      return violations;
    } catch (e) {
      // Handle errors gracefully
      showSnackBar("Hi Error getting all violations: $e");
      print(e);
      rethrow; // Rethrow to allow outer code to handle the exception
    }
  }
}
