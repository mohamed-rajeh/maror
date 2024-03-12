import 'package:flutter/material.dart';

import '../../../components/constant/them.dart';

class CTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Color? color;
  final Color? borderColre;
  final String? hint;
  final String? labe;
  final IconData? icon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? isPass;

  const CTextField(
      {super.key,
      this.controller,
      this.color,
      this.borderColre,
      this.hint,
      this.labe,
      this.icon,
      this.validator,
      this.keyboardType,
      this.isPass});

  @override
  State<CTextField> createState() => _CTextFieldState();
}

class _CTextFieldState extends State<CTextField> {
  bool hide = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: widget.isPass != null ? hide : false,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        validator: widget.validator,
        style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
            color: black),
        decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(color: gray),
            labelText: widget.labe,
            prefixIcon: widget.icon != null
                ? Icon(
                    widget.icon,
                    color: darkColor,
                  )
                : null,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  BorderSide(color: widget.borderColre ?? wight, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: darkColor, width: 2),
                borderRadius: BorderRadius.circular(5)),
            fillColor: widget.color ?? primaryColor,
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            suffix: widget.isPass != null
                ? InkWell(
                    onTap: () {
                      setState(() {
                        hide = !hide;
                      });
                    },
                    child: hide
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )
                : null));
  }
}
