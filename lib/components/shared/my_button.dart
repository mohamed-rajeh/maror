import 'package:flutter/material.dart';

import '../constant/them.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final String lable;
  final void Function()? onTap;
  const MyButton({
    super.key,
    required this.lable,
    this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 50,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.center,
      child: InkWell(
        onTap: onTap,
        child: Text(
          lable,
          style: TextStyle(
              color: wight, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
