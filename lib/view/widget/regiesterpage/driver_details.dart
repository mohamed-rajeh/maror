import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../homepage/textrow.dart';

class DriverDetails extends StatelessWidget {
  const DriverDetails({
    super.key,
    required this.idDriver,
    required this.name,
    required this.photo,
    required this.city,
    required this.lecon,
  });
  final String idDriver;
  final String name, city, lecon;
  final Uint8List? photo;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: photo != null
                  ? Image.memory(photo!)
                  : Image.asset("images/splash.png"),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextRow(lable: "name".tr, content: name),
                TextRow(lable: "city".tr, content: city),
                TextRow(lable: "id".tr, content: idDriver),
              ],
            ),
          )
        ],
      ),
      const SizedBox(height: 10),
      TextRow(lable: "license".tr, content: lecon),
    ]);
  }
}
