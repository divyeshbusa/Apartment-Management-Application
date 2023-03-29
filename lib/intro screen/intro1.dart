import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Intro1 extends StatelessWidget {
  const Intro1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        children: [
          SizedBox(height: 150),
          Image.asset('assets/images/intro1.png', width: 350),
          SizedBox(
            height: 73,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Column(
                children: [
                  Text(
                    'Track your apartment',
                    style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Maintainance',
                    style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}
