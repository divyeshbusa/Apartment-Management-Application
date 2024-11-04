import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/login/splashscreen.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:apartment_management/pages/userwise_apartment_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GmailLogin extends StatefulWidget {
  final String Gmail;
  final String Password;

  const GmailLogin({super.key, required this.Gmail, required this.Password});

  @override
  State<GmailLogin> createState() => _GmailLoginState();
}

class _GmailLoginState extends State<GmailLogin> {
  MyDatabase db = MyDatabase();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print("::::::::::::::::before model::::::::::::::::::::");
        UserModel? modelU = await db.getLoginDetail(
          widget.Gmail,
          widget.Password,
        );
        print(
            "::::::::::::::::after model::::::::::::::::::::${modelU!.UserName}");

        final SharedPreferences prefs =
        await SharedPreferences.getInstance();
        await prefs.setInt('UserID', modelU!.UserID as int);
        await prefs.setString('UserName', modelU.UserName.toString());
        await prefs.setString('Email', modelU.Email.toString());
        await prefs.setString('Phone', modelU.Phone.toString());
        await prefs.setString('UserType', modelU.UserType.toString());
        await prefs.setString('UserImage', modelU.UserImage.toString());

        prefs.setBool(SplashScreenState.KEYLOGIN, true);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                UserwiseApartmentList(id: modelU.UserID),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: Colors.blue.shade900),
            borderRadius: BorderRadius.circular(10)),
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
            ),
            Image.asset("assets/images/google.png", width: 20),
            SizedBox(
              width: 25,
            ),
            Text(
              widget.Gmail,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
