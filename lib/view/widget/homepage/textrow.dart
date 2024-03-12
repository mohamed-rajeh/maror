// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:maroor/components/constant/them.dart';
import 'package:maroor/view/widget/admin/my_lable.dart';

class TextRow extends StatelessWidget {
  final String lable;
  final String content;
  const TextRow({super.key, required this.lable, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyLable(
          lable: lable,
          vertical: 1,
        ),
        Text(
          content,
          overflow: TextOverflow.ellipsis,
          style: style,
        ),
      ],
    );
  }
}
