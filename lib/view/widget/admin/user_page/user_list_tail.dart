import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/constant/them.dart';
import '../../../../model/user.dart';

class UserListTail extends StatelessWidget {
  final String count;
  const UserListTail({
    super.key,
    required this.user,
    required this.count,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: primaryColor,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Get.toNamed("/add_user", arguments: user);
        },
        child: ListTile(
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.all(10),
                color: darkColor,
                child: Icon(
                  user.type == "admin"
                      ? Icons.admin_panel_settings_outlined
                      : Icons.person,
                  size: 35,
                  color: wight,
                ),
              )),
          title: Text(user.name),
          subtitle: Text(user.type),
          trailing: user.type != "admin"
              ? CircleAvatar(
                  backgroundColor: primaryColor,
                  child: Text(
                    count,
                    style: TextStyle(color: last),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
