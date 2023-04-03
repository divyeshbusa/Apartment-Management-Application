import 'dart:ui';

import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:apartment_management/pages/verification_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminUserDashboard extends StatefulWidget {
  var apartmentid;

  AdminUserDashboard({required this.apartmentid});

  @override
  State<AdminUserDashboard> createState() => _AdminUserDashboardState();
}

class _AdminUserDashboardState extends State<AdminUserDashboard> {
  MyDatabase db = MyDatabase();

  bool isGetData = true;
  int isAdmin = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          // elevation: 10,

          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'User Detail',
                  style: GoogleFonts.montserratAlternates(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          // fit: StackFit.expand,
          children: [
            Container(
              height: double.maxFinite,
              child: FutureBuilder<bool>(
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return Image.asset(
                      "assets/images/bg5.jpg",
                      color: Colors.black12,
                      colorBlendMode: BlendMode.color,
                      fit: BoxFit.fill,
                    );
                  } else {
                    return Image.asset(
                      "assets/images/bg4.jpg",
                      color: Colors.black12,
                      colorBlendMode: BlendMode.color,
                      fit: BoxFit.fill,
                    );
                  }
                },
                future: isAdminOrNot(),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FutureBuilder<bool>(
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data == true) {
                              return GestureDetector(
                                onTap: () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => VerificationList(
                                          apartmentid: widget.apartmentid),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Verify',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.verified_rounded,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                          future: isAdminOrNot(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 20,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 40,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 3, color: Colors.white),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Icon(Icons.person,
                                  color: Colors.white, size: 130),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 50,
                          child: Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FutureBuilder<UserModel>(
                                  builder: (context, snapshot) {
                                    if (snapshot != null && snapshot.hasData) {
                                      isGetData = false;

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            '${snapshot.data!.UserName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Phone: ${snapshot.data!.Phone}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 1,
                                          ),
                                          Text(
                                            'Email: ${snapshot.data!.Email}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Center(
                                        child: Text('USER NOT FOUND '),
                                      );
                                    }
                                  },
                                  future: isGetData ? userDetail() : null),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: Column(
                      children: [
                        Card(
                          margin: EdgeInsets.all(10),
                          elevation: 10,
                          shape: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2)),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 25, 25, 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Available Fund',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      alignment: Alignment.topRight,
                                      width: 140,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        'Rs. XXXXXX',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.green.shade400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 5, 25, 25),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Amount Receivable',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      alignment: Alignment.topRight,
                                      width: 140,
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        'Rs. XXXXXX',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red.shade400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 10,
                                      child: Column(
                                        children: [
                                          Icon(Icons.people_alt_sharp),
                                          Text('Members'),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Column(
                                        children: [
                                          Icon(Icons.money),
                                          Text('Collection'),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Column(
                                        children: [
                                          Icon(Icons.emoji_symbols),
                                          Text('Expances'),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Column(
                                        children: [
                                          Icon(Icons.question_answer_outlined),
                                          Text('Complaint'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> isAdminOrNot() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('UserID');
    print("::::::Userid:::${userid}::::::::");
    int isAdmin = await db.getAdminOrNotFromTbl(userid!, widget.apartmentid);
    print("::::::isAdmin:::${isAdmin}::::::::");
    return (isAdmin == 1);
  }

  Future<UserModel> userDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel modelU = UserModel(
        UserName1: prefs.getString('UserName').toString(),
        Phone1: prefs.getString('Phone'),
        Email1: prefs.getString('Email').toString(),
        UserType1: prefs.getString('UserType').toString(),
        UserImage1: prefs.getString('UserImage').toString());
    modelU.UserID = prefs.getInt('UserID');

    return modelU;
  }
}
