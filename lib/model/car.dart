// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:maroor/model/driver.dart';

class Car {
  final String number;
  final String model;
  final Driver? owner; //owner_id

  Car({required this.number, required this.model, required this.owner});
}
