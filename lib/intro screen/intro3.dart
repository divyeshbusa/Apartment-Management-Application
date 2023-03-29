import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Intro3 extends StatelessWidget {
  const Intro3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        children: [
          SizedBox(height: 120,),
          Image.asset('assets/images/intro3.png', width: 380),
          SizedBox(
            height: 80,
          ),
          Row(
            children: [
              SizedBox(width: 30),
              Text(
                'Welcome!',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 50),
          Row(
            children: [
              SizedBox(width: 30),
              Text(
                'Manage your expanses ',
                style: TextStyle(
                    fontSize: 23, fontWeight: FontWeight.w400, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 30),
              Flexible(
                child: Text(
                  'seamlessly & intuitiely',
                  style: TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
