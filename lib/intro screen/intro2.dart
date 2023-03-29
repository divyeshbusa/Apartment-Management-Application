import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Intro2 extends StatelessWidget {
  const Intro2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Column(
        children: [
          SizedBox(height: 140),
          Image.asset('assets/images/intro2.png', width: 380),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Column(
                children: [
                  Text(
                    'Check your account',
                    style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'status easily',
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
