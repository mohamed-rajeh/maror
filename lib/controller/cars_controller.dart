import 'package:get/get.dart';
import 'package:maroor/controller/db_controller.dart';
import 'package:maroor/controller/driver_controller.dart';
import 'package:maroor/model/car.dart';
import 'package:sqflite/sqflite.dart';

import '../components/shared/snackbar.dart';

class CarsController extends GetxController {
  final DbController _dbController = Get.find();
  final DriverController _driverController = Get.find();
  Future submit(Car car) async {
    bool carsIsAssest = await getCarByNumber(car.number) != null;
    if (carsIsAssest) {
      await updateCar(car);
      showSnackBar("Updated");
    } else {
      await insertCar(car);
      showSnackBar("Inseeted");
    }
    update();
  }

  Future<Car?> getCarByNumber(String number) async {
    try {
      final db = await _dbController.db;
      const sql = '''
      SELECT * FROM cars WHERE number = ?
    ''';
      final values = [number];
      final results = await db.rawQuery(sql, values);

      // Check if any results were found
      if (results.isEmpty) {
        return null;
      }

      // Convert the first map (assuming only one car with the ID) to a Car object
      final map = results.first;
      Car car = Car(
          number: map["number"] as String,
          model: map["model"] as String,
          owner: await _driverController.getDriverById(map["owner_id"] as int));

      return car;
    } catch (e) {
      // Handle errors gracefully
      showSnackBar("Error getting car by ID: $e");
      rethrow; // Rethrow to allow outer code to handle the exception
    }
  }

  Future<int> insertCar(Car car) async {
    try {
      final db = await _dbController.db;
      const sql =
          '''INSERT INTO cars (number, model, owner_id) VALUES (?, ?, ?)''';
      final values = [car.number, car.model, car.owner!.id];
      final result = await db.rawInsert(sql, values);
      return result;
    } catch (e) {
      showSnackBar("Error inserting car: $e");
      rethrow;
    }
  }

  Future<int> updateCar(Car car) async {
    try {
      final db = await _dbController.db;
      const sql = '''
      UPDATE cars
      SET number = ?,
          model = ?,
          owner_id = ?
      WHERE number = ?
    '''; // Update based on existing car number
      final values = [
        car.number,
        car.model,
        car.owner!.id,
        car.number
      ]; // Include existing number for identification
      final result = await db.rawUpdate(sql, values);
      return result;
    } catch (e) {
      showSnackBar(
          "Error Updating: $e"); // Rethrow to allow outer code to handle the exception
      rethrow;
    }
  }

  Future<int> deleteCar(String carNumber) async {
    try {
      final db = await _dbController.db;
      const sql = '''
      DELETE FROM cars WHERE number = ?
    ''';
      final values = [carNumber];
      final result = await db.rawDelete(sql, values);
      return result;
    } catch (e) {
      // Handle errors gracefully
      showSnackBar("Error deleting car: $e");
      rethrow; // Rethrow to allow outer code to handle the exception
    }
  }

  Future<List<Car>> getAllCars() async {
    Database db = await _dbController.db;
    const sql = 'SELECT * FROM cars'; // Select all Cars from the table
    final results = await db.rawQuery(sql);

    // Convert each map in results to a Car object
    List<Car> cars = [];
    for (var map in results) {
      final owner =
          await _driverController.getDriverById(map["owner_id"] as int);

      cars.add(Car(
        number: map["number"] as String,
        model: map["model"] as String,
        owner: owner,
      ));
    }
    return cars;
  }
}
