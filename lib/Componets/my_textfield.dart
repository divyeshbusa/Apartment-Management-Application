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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
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
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(237, 192, 80, 1),
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color.fromRGBO(67, 89, 101, 1),
          ),
        ),
      ),
    );
  }
}
