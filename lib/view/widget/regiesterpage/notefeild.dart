import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/constant/them.dart';

class NoteFeild extends StatelessWidget {
  const NoteFeild({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 10,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          hintText: "addN".tr,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: darkColor),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: darkColor),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}
