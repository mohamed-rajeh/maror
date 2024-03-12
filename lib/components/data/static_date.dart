import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maroor/components/function/images.dart';
import 'package:maroor/controller/db_controller.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/car.dart';
import '../../model/driver.dart';
import '../../model/user.dart';
import '../../model/violation.dart';
import '../../model/violations_type.dart';

class InitStaticDate extends GetxController {
  final dbController = Get.find<DbController>();
  late Database mydb;
  final box = GetStorage();

  Future<void> insertUsers() async {
    // Define the user data in a list of maps
    final users = [
      User(id: 1, name: "admin", type: "admin", password: "123", allow: 1),
      User(id: 2, name: "user1", type: "user", password: "123", allow: 1),
      User(id: 3, name: "user2", type: "user", password: "123", allow: 0),
    ];

    // Insert each user using a loop
    for (var user in users) {
      var sql = '''
      INSERT INTO users (name, password, type, allow)
      VALUES (?, ?, ?, ?)
    ''';
      int u = await mydb
          .rawInsert(sql, [user.name, user.password, user.type, user.allow]);
      print("Userss added : $u");
    }
  }

  Future<void> insertType() async {
    // **مخالفات تتعلق بالقيادة:**
    List<ViolationType> violationTypesAr = [
      ViolationType(id: 1, name: "تفحيط", cost: 5000),
      ViolationType(id: 2, name: "سرعة زايده", cost: 7500),
      ViolationType(id: 3, name: "تخطي اشاره", cost: 3500),

      ViolationType(id: 4, name: "قيادة مركبة بدون رخصة قيادة", cost: 5000),
      ViolationType(id: 5, name: "قيادة مركبة غير مؤمنة", cost: 2000),
      ViolationType(id: 6, name: "التحدث في الهاتف أثناء القيادة", cost: 500),
      ViolationType(id: 7, name: "استخدام الهاتف أثناء القيادة", cost: 500),
      ViolationType(
          id: 8, name: "القيادة تحت تأثير الكحول أو المخدرات", cost: 10000),
      ViolationType(id: 9, name: "القيادة عكس اتجاه السير", cost: 5000),
      ViolationType(id: 10, name: "عدم استخدام حزام الأمان", cost: 500),
      ViolationType(
          id: 11, name: "عدم استخدام مقاعد الأطفال الخاصة", cost: 500),
      ViolationType(id: 12, name: "قيادة مركبة بدون لوحات معدنية", cost: 2000),
      ViolationType(
          id: 13,
          name: "القيادة بسرعة أقل من الحد المسموح به بشكل كبير",
          cost: 500),
      ViolationType(id: 14, name: "التجاوز من اليمين", cost: 500),
      ViolationType(id: 15, name: "التجاوز في منطقة محظورة", cost: 500),
      ViolationType(id: 16, name: "عدم إعطاء الأولوية للمشاة", cost: 500),
      ViolationType(
          id: 17,
          name: "عدم إعطاء الأولوية للمركبات القادمة من اليمين",
          cost: 500),
      ViolationType(
          id: 18, name: "عدم إعطاء الأولوية للمركبات الطارئة", cost: 1000),
      ViolationType(id: 19, name: "التوقف في أماكن محظورة", cost: 500),
      ViolationType(
          id: 20,
          name: "وقوف المركبة في أماكن مخصصة لذوي الاحتياجات الخاصة",
          cost: 1000),
      ViolationType(id: 21, name: "إعاقة حركة المرور", cost: 500),
      ViolationType(
          id: 22, name: "قيادة مركبة مُظللة بشكل غير قانوني", cost: 500),
      ViolationType(
          id: 23, name: "قيادة مركبة مُعدلة بشكل غير قانوني", cost: 5000),

      // **مخالفات تتعلق بالمركبة:**
      ViolationType(
          id: 24, name: "عدم صلاحية المركبة للسير على الطريق", cost: 2000),
      ViolationType(id: 25, name: "عدم وجود تأمين على المركبة", cost: 2000),
      ViolationType(id: 26, name: "عدم تجديد رخصة المركبة", cost: 1000),
      ViolationType(id: 27, name: "عدم وجود ملصق فحص المركبة", cost: 500),
      ViolationType(
          id: 28,
          name: "وجود عيوب فنية في المركبة تُشكل خطراً على سلامة المرور",
          cost: 1000),
      ViolationType(
          id: 29, name: "استخدام لوحات معدنية غير قانونية", cost: 2000),
      ViolationType(
          id: 30, name: "تركيب إضاءة غير قانونية على المركبة", cost: 500),
    ];
    List<ViolationType> violationTypesEn = [
      ViolationType(id: 1, name: "Reckless driving (drifting)", cost: 5000),
      ViolationType(id: 2, name: "Speeding", cost: 7500),
      ViolationType(id: 3, name: "Running a red light", cost: 3500),

      // **Driving-related violations:**
      ViolationType(id: 4, name: "Driving without a license", cost: 5000),
      ViolationType(id: 5, name: "Driving an uninsured vehicle", cost: 2000),
      ViolationType(
          id: 6, name: "Talking on the phone while driving", cost: 500),
      ViolationType(id: 7, name: "Using the phone while driving", cost: 500),
      ViolationType(
          id: 8,
          name: "Driving under the influence of alcohol or drugs",
          cost: 10000),
      ViolationType(id: 9, name: "Driving against traffic", cost: 5000),
      ViolationType(id: 10, name: "Not using a seat belt", cost: 500),
      ViolationType(id: 11, name: "Not using child safety seats", cost: 500),
      ViolationType(id: 12, name: "Driving without license plates", cost: 2000),
      ViolationType(
          id: 13,
          name: "Driving significantly below the speed limit",
          cost: 500),
      ViolationType(id: 14, name: "Overtaking on the right", cost: 500),
      ViolationType(id: 15, name: "Overtaking in a prohibited area", cost: 500),
      ViolationType(
          id: 16, name: "Not giving priority to pedestrians", cost: 500),
      ViolationType(
          id: 17,
          name: "Not giving priority to vehicles coming from the right",
          cost: 500),
      ViolationType(
          id: 18,
          name: "Not giving priority to emergency vehicles",
          cost: 1000),
      ViolationType(id: 19, name: "Stopping in prohibited areas", cost: 500),
      ViolationType(
          id: 20,
          name: "Parking in areas reserved for people with disabilities",
          cost: 1000),
      ViolationType(id: 21, name: "Obstructing traffic", cost: 500),
      ViolationType(
          id: 22, name: "Driving a vehicle with illegal tint", cost: 500),
      ViolationType(
          id: 23,
          name: "Driving a vehicle with illegal modifications",
          cost: 5000),

      // **Vehicle-related violations:**
      ViolationType(id: 24, name: "Vehicle not roadworthy", cost: 2000),
      ViolationType(id: 25, name: "No vehicle insurance", cost: 2000),
      ViolationType(
          id: 26, name: "Failure to renew vehicle registration", cost: 1000),
      ViolationType(id: 27, name: "No vehicle inspection sticker", cost: 500),
      ViolationType(
          id: 28,
          name: "Technical defects in the vehicle that endanger traffic safety",
          cost: 1000),
      ViolationType(id: 29, name: "Using illegal license plates", cost: 2000),
      ViolationType(
          id: 30, name: "Installing illegal lights on the vehicle", cost: 500),
      ViolationType(id: 31, name: "Using illegal sound signals", cost: 500),
    ];

    // Insert each user using a loop
    for (var type in violationTypesEn) {
      var sql = '''
      INSERT INTO types (name, cost)
      VALUES (?, ?)
    ''';
      int u = await mydb.rawInsert(sql, [type.name, type.cost]);
      print("typess added : $u");
    }
  }

  Future<void> insertDriver() async {
    // Define the list of Driver objects
    final drivers = [
      Driver(
          id: 1,
          name: "Ali Samy",
          license: "ABC123",
          city: "Sanaa",
          photo: await getAssetBytes("images/1.jpg")),
      Driver(
          id: 2,
          name: "Soltan Abdoo",
          license: "DEF456",
          city: "Eab",
          photo: await getAssetBytes("images/2.jpg")),
      Driver(
          id: 3,
          name: "Mohamed Rajeh",
          license: "GHI789",
          city: "Hodidah",
          photo: await getAssetBytes("images/3.jpg")),
      // Add 7 more Driver objects with appropriate details
    ];

    // Insert each driver using a loop
    for (var driver in drivers) {
      var sql = '''
      INSERT INTO drivers ( name, license, city, photo)
      VALUES ( ?, ?, ?, ?)
    ''';
      int u = await mydb.rawInsert(sql, [
        driver.name,
        driver.license,
        driver.city,
        driver.photo,
      ]);
      print("Drivers added: $u");
    }
  }

  Future<void> insertCars() async {
    // Define the list of car data (assuming you have driver IDs)
    final cars = [
      Car(
          number: "110011",
          model: "Mh444",
          owner: Driver(id: 1, name: "", license: "", city: "")),
      Car(
          number: "220022",
          model: "Hi11",
          owner: Driver(id: 2, name: "", license: "", city: "")),
      Car(
          number: "330033",
          model: "Rx700",
          owner: Driver(id: 1, name: "", license: "", city: "")),
    ];

    // Insert each car using a loop
    for (var car in cars) {
      var sql = '''
      INSERT INTO cars (number,model, owner_id)
      VALUES (?, ?, ?)
    ''';
      int u = await mydb.rawInsert(sql, [car.number, car.model, car.owner!.id]);
      print("Cars added: $u");
    }
  }

  Future<void> insertViolations() async {
    // Define violation data
    final violations = [
      Violation(
          date: DateTime.now(),
          type: ViolationType(id: 1, name: "", cost: 0),
          note: "",
          loction: "Sanaa Streat",
          car: Car(
              number: "220022",
              model: "",
              owner: Driver(id: 1, name: "", license: "", city: "")),
          user: User(id: 2, name: "", type: "", password: "", allow: 1))
    ];

    // Insert each violation using a loop
    for (var violation in violations) {
      var sql = '''
      INSERT INTO violations (date, type_id, note,loction, car_number, user_id)
      VALUES (?, ?, ?, ?,? ,?)
    ''';
      int u = await mydb.rawInsert(sql, [
        violation.date.toIso8601String(),
        violation.type.id, // Access ID from the type object
        violation.note,
        violation.loction,
        violation.car
            .number, // Access number from the car object (assuming unique identifier)
        violation.user.id, // Access ID from the driver object
      ]);
      print("Violations added: $u");
    }
  }

  Future<void> _insertInitialData(Database db) async {
    final hasData = await db.query('users');
    if (hasData.isEmpty) {
      await insertUsers();
      await insertType();
      await insertDriver();
      await insertCars();
      await insertViolations();
    }
  }

  @override
  void onInit() async {
    mydb = await dbController.db;
    _insertInitialData(mydb);

    super.onInit();
  }
}
