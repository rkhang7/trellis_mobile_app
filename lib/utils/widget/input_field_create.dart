import 'package:flutter/material.dart';

class InputFieldCreate extends StatelessWidget {
  final String title;
  final bool autoFocus;
  final TextEditingController controller;
  final Color primaryColor;

  const InputFieldCreate({
    Key? key,
    required this.title,
    required this.controller,
    required this.autoFocus,
    required this.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(color: primaryColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
      cursorColor: primaryColor,
      cursorHeight: 25,
    );
  }
}
