import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/constant/them.dart';

class RegistButton extends StatelessWidget {
  final addItem;
  const RegistButton({
    super.key,
    required this.addItem,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: addItem,
      style: ElevatedButton.styleFrom(
          shape: BeveledRectangleBorder(),
          foregroundColor: primaryColor,
          fixedSize: const Size(double.infinity, 70),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          backgroundColor: darkColor),
      child: Text(
        "record".tr,
      ),
    );
  }
}
