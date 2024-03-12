import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:maroor/components/constant/them.dart';

class MyDropdown extends StatelessWidget {
  final List<dynamic> items;
  final void Function(dynamic)? onChanged;
  final String? labelText;
  final String? hintText;
  final dynamic selectedItem;
  MyDropdown(
      {super.key,
      required this.items,
      required this.onChanged,
      this.labelText,
      this.hintText,
      this.selectedItem});
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<dynamic>(
      popupProps: const PopupProps.menu(showSearchBox: true),
      items: items,
      selectedItem: selectedItem,
      itemAsString: (item) => item.name,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: darkColor)),
          suffixIconColor: darkColor,
          labelText: labelText,
          labelStyle:
              style.copyWith(color: darkColor, fontWeight: FontWeight.bold),
          hintText: hintText,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
