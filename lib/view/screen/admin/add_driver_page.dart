// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:maroor/components/function/valid.dart';

import 'package:maroor/view/widget/homepage/c_text_field.dart';

import '../../../components/constant/them.dart';

import '../../../controller/admin/add_driver_page_controller.dart';
import '../../widget/admin/my_lable.dart';
import '../../widget/regiesterpage/regist_button.dart';

class AddDriverPage extends StatelessWidget {
  const AddDriverPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddDiverPageController());
    final AddDiverPageController controller = Get.find();
    controller.driver = Get.arguments;
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
            Get.arguments == null ? "addD".tr : "dDetails".tr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyLable(lable: "id".tr),
                  CTextField(
                    validator: (value) {
                      return validInput(value!, 1, 15);
                    },
                    controller: controller.id,
                    icon: Icons.add_card_sharp,
                    color: wight,
                    borderColre: darkColor,
                    hint: "exId".tr,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  MyLable(lable: "driver".tr),
                  CTextField(
                    validator: (value) {
                      return validInput(value!, 3, 20);
                    },
                    controller: controller.name,
                    icon: Icons.person,
                    color: wight,
                    borderColre: darkColor,
                    hint: "exName".tr,
                  ),
                  SizedBox(height: 10),
                  MyLable(lable: "license".tr),
                  CTextField(
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return validInput(value!, 3, 20);
                    },
                    controller: controller.licons,
                    icon: Icons.numbers,
                    color: wight,
                    borderColre: darkColor,
                    hint: "exLicense".tr,
                  ),
                  SizedBox(height: 10),
                  MyLable(lable: "city".tr),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: CTextField(
                            validator: (value) {
                              return validInput(value!, 3, 20);
                            },
                            controller: controller.city,
                            color: wight,
                            borderColre: darkColor,
                            icon: Icons.location_city,
                            hint: "exCity".tr,
                          )),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                              border: Border.all(color: darkColor, width: 2),
                              color: wight,
                              borderRadius: BorderRadius.circular(5)),
                          child: IconButton(
                            tooltip: "img".tr,
                            onPressed: controller.getImage,
                            icon: Icon(
                              Icons.add_a_photo,
                              color: darkColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: GetBuilder<AddDiverPageController>(
                      builder: (controller) => controller.imageFile == null
                          ? Text("noImg".tr)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(controller.imageFile!,
                                  height: 300),
                            ),
                    ),
                  )
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
