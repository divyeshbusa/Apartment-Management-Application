import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/intro%20screen/introduction_page.dart';
import 'package:apartment_management/login/login_page.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:apartment_management/pages/userwise_apartment_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "login";

  @override
  void initState() {
    super.initState();
    print("::::::DATABASE INITIALIZATION:::::::");
    MyDatabase().copyPasteAssetFileToRoot();
    MyDatabase().initDatabase();
    print("::::::DATABASE INITIALIZATION COMPLETE:::::::");
    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Icon(
            Icons.apartment,
            color: Color.fromRGBO(255, 150, 166, 1),
            size: 200,
          ),
        ),
      ),
    );
  }

  Future<void> whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();

    var isLogin = sharedPref.getBool(KEYLOGIN);

    Timer(Duration(seconds: 2), () {
      if (isLogin != null) {
        if (isLogin) {
          UserModel modelU = UserModel(
            UserID1: sharedPref.getInt('UserID') as int,
            UserName1: sharedPref.getString('UserName').toString(),
            Phone1: sharedPref.getString('Phone'),
            Email1: sharedPref.getString('Email').toString(),
            UserType1: sharedPref.getString('UserType').toString(),
            UserImage1: sharedPref.getString('UserImage').toString(),
          );
          modelU.UserID = sharedPref.getInt('UserID');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => UserwiseApartmentList(id: modelU.UserID),
            ),
          );
          print("nextScreen:::::DASHBOARD");
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
          print("nextScreen:::::LoginPage");
        }
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => IntroPage(),
          ),
        );
        print("nextScreen:::::IntroPage");
      }
    });
  }
}
