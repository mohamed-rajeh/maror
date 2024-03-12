// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:maroor/components/shared/logout_button.dart';
import 'package:maroor/components/shared/my_button.dart';
import 'package:maroor/controller/driver_controller.dart';
import 'package:maroor/model/driver.dart';
import 'package:maroor/view/screen/admin/add_driver_page.dart';

import '../../../animation/fade_in.dart';
import '../../../components/constant/them.dart';

class DriversPage extends StatefulWidget {
  const DriversPage({super.key});

  @override
  State<DriversPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<DriversPage> {
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
                        prefixIcon: Icon(
                          Icons.search,
                          color: gray,
                        ),
                        suffixIcon: searchCon.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    searchCon.clear();
                                  });
                                },
                                icon: Icon(Icons.clear, color: gray),
                              )
                            : null,
                      ),
                    ),
                  ),

                  SizedBox(width: 15),

                  // exit Button
                  LogoutButton()
                ],
              ),
            ),
            SizedBox(height: 20),
            MyButton(
              color: darkColor,
              lable: "addD".tr,
              onTap: () => Get.toNamed("/add_driver"),
            ),
            Divider(color: darkColor),
            Items(searchCon: searchCon)
          ]),
        ),
      ),
    );
  }
}

// Items n listbuilder
class Items extends StatelessWidget {
  final TextEditingController searchCon;

  const Items({
    super.key,
    required this.searchCon,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverController>(
        builder: (driverController) => Expanded(
              child: FutureBuilder<List<Driver>>(
                  future: driverController.fetchDrivers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final drivers = snapshot.data!;
                      return ListView.builder(
                        itemCount: drivers.length,
                        itemBuilder: (context, index) {
                          Driver driver = drivers[index];
                          final searchText = searchCon.text.toLowerCase();
                          // Check for matches in desired fields
                          bool matchesSearch = driver.id
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchText) ||
                              driver.name.toLowerCase().contains(searchText) ||
                              driver.license
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchText) ||
                              driver.city.toLowerCase().contains(searchText);
                          return matchesSearch
                              ? FadeInAnimation(
                                  delay: 1.3,
                                  direction: FadeInDirection.btt,
                                  fadeOffset: 20,
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    color: primaryColor,
                                    child: InkWell(
                                      onTap: () => Get.to(AddDriverPage(),
                                          arguments: driver),
                                      child: ListTile(
                                        leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: driver.photo != null
                                                ? Image.memory(
                                                    driver.photo!,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.asset(
                                                    "images/splash.png",
                                                    fit: BoxFit.cover,
                                                  )),
                                        title: Text("${driver.name}"),
                                        subtitle: Text("license".tr +
                                            " : ${driver.license}"),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox.shrink();
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ));
  }
}
