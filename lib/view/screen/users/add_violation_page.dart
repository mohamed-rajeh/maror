// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maroor/controller/users/add_violation_controller.dart';
import 'package:maroor/model/violations_type.dart';
import 'package:maroor/view/widget/homepage/c_text_field.dart';

import 'package:maroor/view/widget/regiesterpage/type_dropdown.dart';
import 'package:maroor/components/constant/them.dart';
import '../../../animation/fade_in.dart';
import '../../../controller/users/type_controller.dart';
import '../../widget/regiesterpage/driver_details.dart';
import '../../widget/regiesterpage/notefeild.dart';
import '../../widget/regiesterpage/regist_button.dart';

class AddViolationPage extends StatelessWidget {
  const AddViolationPage({super.key});

  @override
  Widget build(BuildContext context) {
    AddViolationController controller = Get.put(AddViolationController());
    TypeController _typeController = Get.find();

    return Scaffold(
      backgroundColor: wight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: darkColor,
        title: Text("addV".tr),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              // ****************************************
              DriverDetails(
                  idDriver: controller.car.owner!.id.toString(),
                  city: controller.car.owner!.city,
                  name: controller.car.owner!.name,
                  lecon: controller.car.owner!.license,
                  photo: controller.car.owner!.photo),
              //******************************************

              FutureBuilder<List<ViolationType>>(
                  future: _typeController.getAllViolationTypes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final items = snapshot.data!;
                      return MyDropdown(
                        labelText: "Violations".tr,
                        hintText: "ViolationHint".tr,
                        items: items,
                        onChanged: (value) =>
                            _typeController.updateSelectedValue(value!.id!),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              // ****************************************
              SizedBox(height: 20),
              CTextField(
                hint: "exLoc".tr,
                color: wight,
                borderColre: darkColor,
                controller: controller.loction,
                icon: Icons.location_on,
              ),
              // ****************************************

              SizedBox(height: 20),
              NoteFeild(controller: controller.note),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FadeInAnimation(
        delay: 1.7,
        direction: FadeInDirection.btt,
        fadeOffset: 20,
        child: RegistButton(
          addItem: () async {
            await controller.addDate();
          },
        ),
      ), // Save Button
    );
  }
}
