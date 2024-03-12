import 'package:get/get.dart';

import '../../model/violations_type.dart';
import '../db_controller.dart';

class TypeController extends GetxController {
  final _dbController = Get.find<DbController>();

  List<ViolationType> types = <ViolationType>[];
  int selectedValue = 0; // Observable to track the selected value

  void updateSelectedValue(int value) {
    selectedValue = value; // Update the selected value
    update();
  }

  Future<List<ViolationType>> getAllViolationTypes() async {
    final db =
        await _dbController.db; // Assuming you have a getter for the database

    try {
      final sql = '''
        SELECT * FROM types
      ''';
      final results = await db.rawQuery(sql);

      return results.map((map) => ViolationType.fromMap(map)).toList();
    } catch (e) {
      // Handle errors gracefully
      print("Error getting all violation types: $e");
      rethrow; // Rethrow to allow outer code to handle the exception
    }
  }

  Future<ViolationType?> getViolationTypeById(int id) async {
    final db =
        await _dbController.db; // Assuming you have a getter for the database

    try {
      final sql = '''
        SELECT * FROM types
        WHERE id = ?
      ''';
      final results = await db.rawQuery(sql, [id]);

      if (results.isEmpty) {
        return null; // Return null if no type found
      } else {
        return ViolationType.fromMap(results.first);
      }
    } catch (e) {
      // Handle errors gracefully
      print("Error getting violation type by ID: $e");
      rethrow; // Rethrow to allow outer code to handle the exception
    }
  }

  @override
  void onInit() async {
    types.addAll(await getAllViolationTypes());
    super.onInit();
  }
}
