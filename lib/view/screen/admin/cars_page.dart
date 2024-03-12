// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maroor/components/shared/my_button.dart';

import 'package:maroor/controller/cars_controller.dart';
import 'package:maroor/model/car.dart';

import '../../../components/constant/them.dart';

import '../../widget/admin/car_page/car_list_tail.dart';
import '../../../components/shared/logout_button.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPage();
}

class _CarsPage extends State<CarsPage> {
  final carcontroller = Get.put(CarsController());
  TextEditingController searchCon = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(children: [
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: searchCon,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: wight,
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: darkColor, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: darkColor, width: 2)),
                        hintText: "search".tr,
                        hintStyle: TextStyle(color: gray),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              searchCon.clear();
                            });
                          },
                          icon: Icon(Icons.clear, color: gray),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: gray,
                        )),
                  )),
                  SizedBox(width: 15),
                  // exit Button
                  LogoutButton()
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(children: [
              Expanded(
                child: MyButton(
                  lable: "addC".tr,
                  onTap: () => Get.toNamed("/add_car"),
                  color: darkColor,
                ),
              ),
              Spacer()
            ]),
            Divider(color: darkColor),
            Expanded(
              child: GetBuilder<CarsController>(builder: (carcontroller) {
                return FutureBuilder<List<Car>>(
                    future: carcontroller.getAllCars(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final cars = snapshot.data!;
                        return ListView.builder(
                          itemCount: cars.length,
                          itemBuilder: (context, index) {
                            Car car = cars[index];
                            final searchText = searchCon.text.toLowerCase();
                            // Check for matches in desired fields
                            bool matchesSearch = car.number
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchText) ||
                                car.model.toLowerCase().contains(searchText) ||
                                car.owner!.name
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchText);
                            return matchesSearch
                                ? CarListTial(car: car)
                                : SizedBox.shrink();
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    });
              }),
            )
          ]),
        ),
      ),
    );
  }
}
