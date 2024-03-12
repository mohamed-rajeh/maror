// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:maroor/components/function/valid.dart';
import 'package:maroor/controller/admin/add_car_page_controller.dart';
import 'package:maroor/controller/driver_controller.dart';
import 'package:maroor/model/driver.dart';

import 'package:maroor/view/widget/admin/my_lable.dart';
import 'package:maroor/view/widget/homepage/c_text_field.dart';

import '../../../components/constant/them.dart';

import '../../widget/regiesterpage/regist_button.dart';
import '../../widget/regiesterpage/type_dropdown.dart';

class AddCarPage extends StatelessWidget {
  const AddCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddCarPageController controller = Get.put(AddCarPageController());
    final DriverController _driverController = Get.find();
    controller.car = Get.arguments;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: wight,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: darkColor,
          title: Text(
            Get.arguments == null ? "cDetails".tr : "cDetails".tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: Get.arguments != null
              ? [
                  IconButton(
                      splashColor: darkColor,
                      onPressed: () {},
                      icon: Icon(Icons.delete, color: Colors.red))
                ]
              : null,
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyLable(lable: "carNumber".tr),
                  CTextField(
                    controller: controller.number,
                    icon: Icons.numbers,
                    color: wight,
                    borderColre: darkColor,
                    hint: "number".tr,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return validInput(value!, 1, 6);
                    },
                  ),
                  SizedBox(height: 10),
                  MyLable(lable: "model".tr),
                  CTextField(
                    controller: controller.model,
                    icon: Icons.car_repair,
                    color: wight,
                    borderColre: darkColor,
                    hint: "carModel".tr,
                    validator: (value) {
                      return validInput(value!, 3, 20);
                    },
                  ),
                  SizedBox(height: 10),
                  MyLable(lable: "owner".tr),
                  //******************************************

                  FutureBuilder<List<Driver>>(
                      future: _driverController.fetchDrivers(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final items = snapshot.data!;
                          return GetBuilder<DriverController>(
                              builder: (context) {
                            return MyDropdown(
                              selectedItem: controller.owner,
                              hintText: "driverHint".tr,
                              items: items,
                              onChanged: (value) =>
                                  controller.updateSelectedValue(value),
                            );
                          });
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text("Error: ${snapshot.error}"));
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  // ****************************************

                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: RegistButton(
          addItem: controller.submit,
        ), // Save Button
      ),
    );
  }
}
