// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:maroor/components/function/valid.dart';
import 'package:maroor/controller/admin/add_user_page_controller.dart';
import 'package:maroor/view/widget/admin/my_lable.dart';
import 'package:maroor/view/widget/homepage/c_text_field.dart';

import '../../../components/constant/messages.dart';
import '../../../components/constant/them.dart';

import '../../widget/regiesterpage/regist_button.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddUserPageController controller = Get.put(AddUserPageController());

    controller.user = Get.arguments;
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
            Get.arguments == null ? "addU".tr : "uDetails".tr,
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
                  MyLable(lable: "name".tr),
                  CTextField(
                    validator: (value) {
                      return validInput(value!, 1, 15);
                    },
                    controller: controller.userName,
                    icon: Icons.person,
                    color: wight,
                    borderColre: darkColor,
                    hint: "exName".tr,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 10),
                  MyLable(lable: "type".tr),
                  CTextField(
                    validator: (value) {
                      if (value!.isEmpty) return messageInputEmpty;
                      if (value == 'user') return null;
                      if (value == 'admin') return null;
                      return messageInputType;
                    },
                    controller: controller.type,
                    icon: Icons.admin_panel_settings,
                    color: wight,
                    borderColre: darkColor,
                    hint: "exType".tr,
                  ),
                  SizedBox(height: 10),
                  MyLable(lable: "pass".tr),
                  CTextField(
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return validInput(value!, 3, 20);
                    },
                    controller: controller.password,
                    icon: Icons.lock,
                    color: wight,
                    borderColre: darkColor,
                    hint: "exPass".tr,
                    isPass: true,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 20,
                  ),
                  MyLable(lable: "allow".tr),
                  AllowSwitch(
                    con: controller,
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

class AllowSwitch extends StatefulWidget {
  final con;
  const AllowSwitch({
    super.key,
    this.con,
  });

  @override
  State<AllowSwitch> createState() => _AllowSwitchState();
}

class _AllowSwitchState extends State<AllowSwitch> {
  @override
  Widget build(BuildContext context) {
    return Switch(
        activeColor: Colors.green,
        inactiveThumbColor: Colors.red,
        value: widget.con.allow,
        onChanged: (value) {
          widget.con.cheackAllow(value);
          setState(() {});
        });
  }
}
