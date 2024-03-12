// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maroor/components/shared/logout_button.dart';
import 'package:maroor/controller/user_controller.dart';
import 'package:maroor/model/user.dart';

import '../../../animation/fade_in.dart';
import '../../../components/constant/them.dart';
import '../../../components/shared/my_button.dart';

import '../../widget/admin/user_page/user_list_tail.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController searchCon = TextEditingController();
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // its for remove dreach feild foucs  when we click on screen
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
                        hintText: "userSearchHint".tr,
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
                  SizedBox(
                    width: 15,
                  ),
                  // exit Button
                  LogoutButton()
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: MyButton(
                    lable: "addU".tr,
                    onTap: () => Get.toNamed("/add_user"),
                    color: darkColor,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MyButton(
                      lable: "records".tr,
                      onTap: () => Get.toNamed("/all_record"),
                      color: last),
                ),
              ],
            ),
            Divider(
              color: darkColor,
            ),
            Expanded(
                child: GetBuilder<UserController>(builder: (_usercontroller) {
              return FutureBuilder<List<User>>(
                future: _usercontroller.fetchUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final users = snapshot.data!;
                    return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          User user = users[index];

                          final searchText = searchCon.text.toLowerCase();
                          // Check for matches in desired fields
                          bool matchesSearch = user.id
                                  .toString()
                                  .contains(searchText) ||
                              user.name.toLowerCase().contains(searchText) ||
                              user.type.toLowerCase().contains(searchText);
                          return matchesSearch
                              ? FadeInAnimation(
                                  delay: 1.3,
                                  direction: FadeInDirection.btt,
                                  fadeOffset: 20,
                                  child: FutureBuilder(
                                      future: _usercontroller
                                          .getViolationCountByUser(user.id!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          String userVioltionCount =
                                              snapshot.data.toString();
                                          return UserListTail(
                                            user: user,
                                            count: userVioltionCount,
                                          );
                                        } else if (snapshot.hasError) {
                                          return UserListTail(
                                            user: user,
                                            count: "!",
                                          );
                                        } else {
                                          return UserListTail(
                                            user: user,
                                            count: "!",
                                          );
                                        }
                                      }),
                                )
                              : SizedBox.shrink();
                        });
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            })),
          ]),
        ),
      ),
    );
  }
}
