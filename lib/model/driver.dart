// Driver information

import 'dart:typed_data';

class Driver {
  final int? id;
  final String name;
  final Uint8List? photo;
  final String city;
  final String license;

  Driver.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int?,
        name = map['name'] as String,
        photo = map['photo'] as Uint8List?,
        city = map['city'] as String,
        license = map['license'] as String;

  Driver({
    this.id,
    required this.name,
    this.photo,
    required this.city,
    required this.license,
  });
}
