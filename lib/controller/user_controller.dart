import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maroor/components/shared/snackbar.dart';
import 'package:maroor/model/user.dart';
import 'package:sqflite/sqflite.dart';

import 'db_controller.dart';

class UserController extends GetxController {
  final _dbController = Get.find<DbController>();

  final box = GetStorage();

  Future submit(User user) async {
    if (user.id != null) {
      await updateUser(user);
    } else {
      await insertUser(user);
    }
    update();
  }

  Future<int> insertUser(User user) async {
    Database db = await _dbController.db;
    const sql = '''
    INSERT INTO users (name, password,type ,allow) VALUES (?, ?, ?,?)
  ''';
    final values = [
      user.name,
      user.password,
      user.type,
      true
    ]; // Add other values based on your user schema
    final result = await db.rawInsert(sql, values);
    return result;
  }

  Future<int> updateUser(User user) async {
    Database db = await _dbController.db;
    const sql = '''
    UPDATE users
    SET name = ?,
        password = ?,
        type = ?,
        allow = ?
    WHERE id = ?
  ''';
    final values = [
      user.name,
      user.password,
      user.type,
      user.allow, // Assuming allow is boolean or can be converted to int
      user.id, // Essential for identifying the user to update
    ];
    final result = await db.rawUpdate(sql, values);
    return result;
  }

  Future<int> deleteUser(int userId) async {
    Database db = await _dbController.db;
    const sql = 'DELETE FROM users WHERE id = ?';
    final values = [userId];
    final result = await db.rawDelete(sql, values);
    return result;
  }

  Future<void> validateUser(String name, String password) async {
    try {
      Database db = await _dbController.db;
      const sql = '''
                SELECT *
                FROM users
                WHERE name = ? AND password = ?
                 ''';
      final values = [name, password];
      final results = await db.rawQuery(sql, values);

      // Check if any results exist
      if (results.isEmpty) {
        showSnackBar("msgNoUser".tr);
        return; // No user found with the given credentials
      }

      final userMap = results.first;
      User user = User.fromMap(userMap);
      if (user.allow == 0) {
        showSnackBar("msgNoAllow".tr);
        return;
      }
      await box.write("user", user.id);
      await box.write("type", user.type);

      if (user.type == "admin") {
        Get.offNamed("/admin");
      } else {
        Get.offNamed("home");
      }
    } catch (e) {
      showSnackBar("some thing wrong");
    }
  }

  Future<User?> getUserById(int id) async {
    Database db = await _dbController.db;
    const sql =
        'SELECT * FROM users WHERE id = ?'; // Select user with specific ID
    final results = await db.rawQuery(sql, [id]);

    // Check if any results were found
    if (results.isEmpty) {
      return null;
    }

    // Convert the first map (assuming only one user with the ID) to a User object
    final userMap = results.first;
    return User.fromMap(userMap);
  }

  Future<List<User>> fetchUsers() async {
    Database db = await _dbController.db;
    const sql = 'SELECT * FROM users'; // Select all users from the table
    final results = await db.rawQuery(sql);

    // Convert each map in results to a User object
    final users = results.map((userMap) => User.fromMap(userMap)).toList();
    return users;
  }

  Future<int?> getViolationCountByUser(int userId) async {
    final db = await _dbController.db;
    final sql =
        'SELECT COUNT(*) as count FROM violations WHERE user_id = ?'; // Use "violations" for clarity
    final results = await db.rawQuery(sql, [userId]);

    // Return null if no violations found, otherwise extract the count
    return results.isEmpty ? null : results.first["count"] as int?;
  }
}
