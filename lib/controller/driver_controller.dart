import 'package:get/get.dart';
import 'package:maroor/model/driver.dart';
import 'package:sqflite/sqflite.dart';

import '../components/shared/snackbar.dart';
import 'db_controller.dart';

class DriverController extends GetxController {
  final _dbController = Get.find<DbController>();

  Future<Driver?> getDriverById(int driverId) async {
    try {
      final db = await _dbController.db;
      const sql = '''
      SELECT * FROM drivers WHERE id = ?
    ''';
      final values = [driverId];
      final results = await db.rawQuery(sql, values);

      // Check if any results were found
      if (results.isEmpty) {
        return null;
      }

      // Convert the first map (assuming only one driver with the ID) to a Driver object
      final driverMap = results.first;
      return Driver.fromMap(driverMap);
    } catch (e) {
      // Handle errors gracefully
      showSnackBar("Error getting driver by ID: $e");
      rethrow; // Rethrow to allow outer code to handle the exception
    }
  }

  Future<int> insertDriver(Driver driver) async {
    try {
      final db = await _dbController.db;
      const sql = '''
      INSERT INTO drivers (id,name, photo, city, license) VALUES (?, ?, ?, ?, ?)
    ''';
      final values = [
        driver.id,
        driver.name,
        driver.photo,
        driver.city,
        driver.license
      ];
      final result = await db.rawInsert(sql, values);
      update();
      return result;
    } catch (e) {
      // Handle errors gracefully
      showSnackBar("Error inserting driver: $e");
      rethrow; // Rethrow to allow outer code to handle the exception
    }
  }

  Future<int> updateDriver(Driver driver) async {
    try {
      final db = await _dbController.db;
      const sql = '''
      UPDATE drivers
      SET name = ?,
          photo = ?,
          city = ?,
          license = ?
      WHERE id = ?
    ''';
      final values = [
        driver.name,
        driver.photo,
        driver.city,
        driver.license,
        driver.id
      ];
      final result = await db.rawUpdate(sql, values);
      update();
      return result;
    } catch (e) {
      // Handle errors gracefully
      showSnackBar("Error updating driver: $e");
      rethrow; // Rethrow to allow outer code to handle the exception
    }
  }

  Future<int> deleteDriver(int driverId) async {
    try {
      final db = await _dbController.db;
      const sql = '''
      DELETE FROM drivers WHERE id = ?
    ''';
      final values = [driverId];
      final result = await db.rawDelete(sql, values);
      return result;
    } catch (e) {
      // Handle errors gracefully
      showSnackBar("Error deleting driver: $e");
      rethrow; // Rethrow to allow outer code to handle the exception
    }
  }

  Future<List<Driver>> fetchDrivers() async {
    Database db = await _dbController.db;
    const sql = 'SELECT * FROM drivers'; // Select all users from the table
    final results = await db.rawQuery(sql);

    // Convert each map in results to a User object
    final drivers =
        results.map((driverMap) => Driver.fromMap(driverMap)).toList();
    return drivers;
  }
}
