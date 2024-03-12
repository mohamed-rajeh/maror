// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maroor/components/function/formatdate.dart';
import 'package:maroor/model/violation.dart';

import 'package:maroor/components/constant/them.dart';
import '../../animation/fade_in.dart';
import '../widget/homepage/textrow.dart';
import '../widget/regiesterpage/driver_details.dart';

class ShowViolationPage extends StatelessWidget {
  const ShowViolationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Violation? violation = Get.arguments;

    return Scaffold(
      backgroundColor: wight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: darkColor,
        title: Text("Details".tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FadeInAnimation(
            delay: 1.5,
            direction: FadeInDirection.ltr,
            fadeOffset: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ****************************************
                DriverDetails(
                  idDriver: violation!.car.owner!.id.toString(),
                  city: violation.car.owner!.city,
                  name: violation.car.owner!.name,
                  lecon: violation.car.owner!.license,
                  photo: violation.car.owner!.photo!,
                ),
                TextRow(lable: "type".tr, content: violation.type.name),
                TextRow(lable: "cost".tr, content: " ${violation.type.cost}\$"),
                TextRow(lable: "date".tr, content: formatDate(violation.date)),
                TextRow(
                    lable: "location".tr,
                    content: violation.loction.isEmpty
                        ? "msgNoLoce".tr
                        : violation.loction),
                TextRow(
                    lable: "note".tr,
                    content: violation.note == null || violation.note!.isEmpty
                        ? "msgNoNote".tr
                        : violation.note!),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
