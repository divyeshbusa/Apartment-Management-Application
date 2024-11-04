import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText, validation;
  final bool obscureText;
  final onChange;

  const MyTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.onChange,
      required this.validation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return validation;
        } else {
          return null;
        }
      },
      controller: controller,
      obscureText: obscureText,
      onChanged: onChange,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromRGBO(237, 192, 80, 1), width: 2),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey, width: 3),
            borderRadius: BorderRadius.circular(10)),
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
            color: Color.fromRGBO(237, 192, 80, 1),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
