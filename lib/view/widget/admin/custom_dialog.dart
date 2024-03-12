// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maroor/components/constant/them.dart';

class CDialog extends StatelessWidget {
  final IconData? icon;
  final String? titel;

  final String? btn1Text;
  final String? btn2Text;
  final void Function()? onTapB1;
  final void Function()? onTapB2;

  const CDialog(
      {super.key,
      this.icon,
      this.titel,
      this.btn1Text,
      this.btn2Text,
      this.onTapB1,
      this.onTapB2});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: wight,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: darkColor)),
      padding: EdgeInsets.all(20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        CircleAvatar(
            backgroundColor: darkColor,
            child: Icon(
              Icons.exit_to_app,
              color: wight,
            )),
        SizedBox(
          height: 10,
        ),
        Text(
          titel ?? "logout".tr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
                child: InkWell(
              onTap: onTapB1,
              child: Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: wight,
                    border: Border.all(color: darkColor),
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  btn1Text ?? "cancel".tr,
                  style: TextStyle(
                      color: darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: InkWell(
              onTap: onTapB2,
              child: Container(
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: darkColor, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  btn2Text ?? "ok".tr,
                  style: TextStyle(
                      color: wight, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )),
          ],
        )
      ]),
    );
  }
}
