// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:maroor/components/constant/them.dart';
import 'package:maroor/controller/users/violation_controller.dart';
import 'package:maroor/model/violation.dart';

import '../../../components/function/formatdate.dart';

class ViolationRecordPage extends StatefulWidget {
  const ViolationRecordPage({
    super.key,
  });

  @override
  State<ViolationRecordPage> createState() => _RecordPage();
}

final TextEditingController searchController = TextEditingController();

class _RecordPage extends State<ViolationRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 30,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                        cursorColor: darkColor,
                        controller: searchController,
                        onChanged: (v) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: wight,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "search".tr,
                          prefixIcon: Icon(Icons.search, color: darkColor),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    searchController.clear();
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    color: darkColor,
                                  ),
                                )
                              : null,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  color: wight,
                ),
                child: GetBuilder<ViolationController>(builder: (controller) {
                  int? id = GetStorage().read("user") as int;
                  print(id);

                  return FutureBuilder<List<Violation>>(
                      future: controller.getAllViolationsByUser(id),
                      builder: (contex, snapshot) {
                        if (snapshot.hasData) {
                          final violations = snapshot.data;
                          return ListView.builder(
                            itemCount: violations!.length,
                            itemBuilder: (BuildContext context, int index) {
                              Violation violation = violations[index];

                              final searchText =
                                  searchController.text.toLowerCase();
                              // Check for matches in desired fields
                              bool matchesSearch = violation.car.owner!.name
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchText) ||
                                  violation.type.name
                                      .toString()
                                      .contains(searchText) ||
                                  violation.car.number
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchText);
                              return matchesSearch
                                  ? Card(
                                      clipBehavior: Clip.antiAlias,
                                      child: InkWell(
                                          onTap: () => Get.toNamed(
                                              "/show_violation",
                                              arguments: violation),
                                          child: ListTile(
                                            leading: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: violation
                                                            .car.owner!.photo !=
                                                        null
                                                    ? Image.memory(violation
                                                        .car.owner!.photo!)
                                                    : Image.asset(
                                                        "images/splash.png")),
                                            title: Text(violations[index]
                                                .car
                                                .owner!
                                                .name
                                                .toString()),
                                            subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(violations[index]
                                                      .type
                                                      .name
                                                      .toString()),
                                                  Text(formatDate(
                                                      violations[index].date)),
                                                ]),
                                          )),
                                    )
                                  : SizedBox.shrink();
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error ${snapshot.error}"));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      });
                }),
              ),
            )
          ],
        ),
      )),
    );
  }
}
