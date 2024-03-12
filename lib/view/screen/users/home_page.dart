// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maroor/components/constant/them.dart';

import '../../../animation/fade_in.dart';
import '../../../controller/users/home_controller.dart';
import '../../widget/homepage/c_appbar.dart';
import '../../widget/homepage/c_text_field.dart';
import '../../widget/homepage/home_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: CAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInAnimation(
                      delay: 1.7,
                      direction: FadeInDirection.rtl,
                      fadeOffset: 20,
                      child: Image.asset("images/regist.png")),
                  SizedBox(height: 10),
                  GetBuilder<HomeController>(
                      builder: (controller) => Column(
                            children: [
                              FadeInAnimation(
                                delay: 1.7,
                                direction: FadeInDirection.ltr,
                                fadeOffset: 20,
                                child: CTextField(
                                  keyboardType: TextInputType.number,
                                  color: wight,
                                  borderColre: darkColor,
                                  controller: controller.number,
                                  hint: "carNumber".tr,
                                  icon: Icons.car_crash_outlined,
                                ),
                              ),
                              SizedBox(height: 20),
                              FadeInAnimation(
                                delay: 1.7,
                                direction: FadeInDirection.btt,
                                fadeOffset: 20,
                                child: HomeButton(
                                    isLoading: controller.isLoading,
                                    cheack: controller.check),
                              )
                            ],
                          )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
