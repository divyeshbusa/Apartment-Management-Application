import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String name;
  final Color ContainerColor;
  final double fontsize,padding;

  const MyButton(
      {Key? key,
      required this.onTap,
      required this.name,
      required this.ContainerColor,
      required this.fontsize,
      required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            color: ContainerColor, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: fontsize,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
