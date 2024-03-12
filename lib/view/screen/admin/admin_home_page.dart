// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maroor/view/screen/admin/user_page.dart';

import '../../../components/constant/them.dart';
import 'cars_page.dart';
import 'drivers_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int selectedIndex = 1;
  List<Widget> pages = [CarsPage(), DriversPage(), UserPage()];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: wight,
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: darkColor,
          backgroundColor: primaryColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.car_crash), label: "cars".tr),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "drivers".tr),
            BottomNavigationBarItem(
                icon: Icon(Icons.admin_panel_settings), label: "users".tr),
          ],
          currentIndex: selectedIndex,
          onTap: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
        ),
      ),
    );
  }
}
