import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/constant/them.dart';
import '../../../../model/car.dart';
import '../../../screen/admin/add_car_page.dart';

class CarListTial extends StatelessWidget {
  const CarListTial({
    super.key,
    required this.car,
  });

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: primaryColor,
      child: InkWell(
        onTap: () {
          Get.to(AddCarPage(), arguments: car);
        },
        child: ListTile(
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  padding: EdgeInsets.all(10),
                  color: darkColor,
                  child: Icon(
                    Icons.car_crash,
                    size: 35,
                    color: wight,
                  ))),
          title: Text("number".tr + ": ${car.number}"),
          subtitle: Text("model".tr + ": ${car.model}"),
        ),
      ),
    );
  }
}
