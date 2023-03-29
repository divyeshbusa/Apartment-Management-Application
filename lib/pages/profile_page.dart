import 'dart:io';
import 'dart:math';

import 'package:apartment_management/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isgetdata = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: CupertinoIconThemeData(color: Colors.pink),
        ),
        body: FutureBuilder<UserModel?>(
          builder: (context, snapshot) {
            if (snapshot.data != null || snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    flex: 30,
                    child: Center(
                      child: Icon(
                        CupertinoIcons.profile_circled,
                        color: Colors.pink,
                        size: 200,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Name : ',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(100, 10, 156, 1),
                                ),
                              ),
                              Text(
                                snapshot.data!.UserName.toString(),
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 100, 156, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Phone : ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(100, 10, 156, 1),
                                ),
                              ),
                              Text(
                                snapshot.data!.Phone.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 100, 156, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Email : ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(100, 10, 156, 1),
                                ),
                              ),
                              Text(
                                snapshot.data!.Email.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 100, 156, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Usertype : ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(100, 10, 156, 1),
                                ),
                              ),
                              Text(
                                snapshot.data!.UserType.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(255, 100, 156, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
          future: isgetdata ? getProfile() : null,
        ),
      ),
    );
  }

  Future<UserModel?> getProfile() async {
    var sharedPref = await SharedPreferences.getInstance();

    UserModel modelU = UserModel(
      UserName1: sharedPref.getString('UserName').toString(),
      Phone1: sharedPref.getString('Phone'),
      Email1: sharedPref.getString('Email').toString(),
      UserType1: sharedPref.getString('UserType').toString(),
      UserImage1: sharedPref.getString('UserImage').toString(),
    );

    return modelU;
  }
}
