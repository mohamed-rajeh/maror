import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/constant/them.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
    required this.isLoading,
    required this.cheack,
  });

  final bool isLoading;
  final Function() cheack;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.6,
        child: ElevatedButton(
            onPressed: cheack,
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                textStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                backgroundColor: darkColor,
                shadowColor: darkColor,
                elevation: 5),
            child: isLoading
                ? const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: wight,
                  )
                : Text(
                    "submit".tr,
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  )));
  }
}
