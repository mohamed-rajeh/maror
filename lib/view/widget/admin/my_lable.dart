import 'package:flutter/material.dart';

import '../../../components/constant/them.dart';

class MyLable extends StatelessWidget {
  const MyLable({super.key, required this.lable, this.vertical});
  final double? vertical;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical ?? 10),
      child: Text(
        lable,
        style: style.copyWith(fontWeight: FontWeight.bold, color: gray),
      ),
    );
  }
}
