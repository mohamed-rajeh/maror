import 'package:maroor/model/violations_type.dart';

import 'car.dart';
import 'user.dart';

class Violation {
  final int? id;
  final DateTime date;
  final ViolationType type;
  final String? note;
  final Car car;
  final User user;
  final String loction;

  // Improved constructor for clarity
  Violation(
      {this.id,
      required this.date,
      required this.type,
      this.note,
      required this.car,
      required this.user,
      required this.loction});

  // Corrected factory constructor
}
