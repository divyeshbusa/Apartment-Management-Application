import 'dart:ui';

import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:apartment_management/models/verify_model.dart';
import 'package:apartment_management/pages/collection_list.dart';
import 'package:apartment_management/pages/member_list.dart';
import 'package:apartment_management/pages/transaction_list.dart';
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

class _AdminUserDashboardState extends State<AdminUserDashboard>
    with TickerProviderStateMixin {
  MyDatabase db = MyDatabase();
  bool isGetData = true;
  bool isGetCollection = true;
  List<MemberModel> localList = [];
  List<MemberModel> searchList = [];
  TextEditingController controller = TextEditingController();
  bool isGetData2 = true;
  int isAdmin = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AvailableFund();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

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
          fit: StackFit.expand,
          children: [
            Container(
              height: double.maxFinite,
              child: FutureBuilder<bool>(
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data == true) {
                    return Image.asset(
                      "assets/images/bg3.jpg",
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
            Container(
              height: double.maxFinite,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 65),
                    Row(
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
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Verify',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.verified_rounded,
                                        color: Colors.red,
                                        size: 18,
                                      )
                                    ],
                                  ),
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
                    SizedBox(
                      height: 20,
                    ),
                    Row(
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
                                  color: Colors.white, size: 100),
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
                    SizedBox(
                      height: 20,
                    ),
                    Column(
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
                                    const EdgeInsets.fromLTRB(20, 25, 15, 25),
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
                                      child: FutureBuilder<int>(
                                        builder: (context, snapshot1) {
                                          if (snapshot1.hasData &&
                                              snapshot1.data != null) {
                                            return FutureBuilder<int>(
                                              builder: (context, snapshot2) {
                                                if (snapshot2.hasData &&
                                                    snapshot2.data != null) {
                                                  var sum = snapshot2.data! -
                                                      snapshot1.data!;
                                                  if (sum >= 0) {
                                                    return Text(
                                                      'Rs. ${sum}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors
                                                              .green.shade400),
                                                    );
                                                  } else {
                                                    return Text(
                                                      'Rs. ${sum * (-1)}',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors
                                                              .red.shade400),
                                                    );
                                                  }
                                                } else {
                                                  return Text(
                                                    'data not found',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors
                                                            .green.shade400),
                                                  );
                                                }
                                              },
                                              future: isGetCollection
                                                  ? db.getTotalCollection(
                                                      widget.apartmentid)
                                                  : null,
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                        future: isGetCollection
                                            ? db.getTotalTransaction(
                                                widget.apartmentid)
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.fromLTRB(20, 5, 15, 25),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text(
                              //         'Amount Receivable',
                              //         style: TextStyle(
                              //             fontSize: 16,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //       Container(
                              //         alignment: Alignment.topRight,
                              //         width: 140,
                              //         padding: EdgeInsets.all(5),
                              //         decoration: BoxDecoration(
                              //             border:
                              //                 Border.all(color: Colors.black),
                              //             borderRadius:
                              //                 BorderRadius.circular(5)),
                              //         child: Text(
                              //           'Rs. XXXXXX',
                              //           style: TextStyle(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.w500,
                              //               color: Colors.red.shade400),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data == true) {
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade600,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TabBar(
                                      indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.brown.shade900,
                                      ),
                                      isScrollable: true,
                                      controller: tabController,
                                      labelPadding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      tabs: [
                                        Tab(
                                          child: Text(
                                            'Members',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            'Collection',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            'Expances',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller: tabController,
                                    children: [
                                      MemberList(
                                          apartmentid: widget.apartmentid,
                                          isAdmin: true),
                                      CollectionList(
                                          apartmentid: widget.apartmentid,
                                          isAdmin: true),
                                      TransactionList(
                                          apartmentid: widget.apartmentid,
                                          isAdmin: true),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade600,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: TabBar(
                                      indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                      ),
                                      isScrollable: true,
                                      controller: tabController,
                                      labelPadding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      tabs: [
                                        Tab(
                                          child: Text(
                                            'Members',
                                            style: TextStyle(
                                              color: Colors.blue.shade900,
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            'Collection',
                                            style: TextStyle(
                                              color: Colors.blue.shade900,
                                            ),
                                          ),
                                        ),
                                        Tab(
                                          child: Text(
                                            'Expances',
                                            style: TextStyle(
                                              color: Colors.blue.shade900,
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                                Expanded(
                                  child: TabBarView(
                                    controller: tabController,
                                    children: [
                                      MemberList(
                                          apartmentid: widget.apartmentid,
                                          isAdmin: false),
                                      CollectionList(
                                          apartmentid: widget.apartmentid,
                                          isAdmin: false),
                                      TransactionList(
                                          apartmentid: widget.apartmentid,
                                          isAdmin: false),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                        future: isAdminOrNot(),
                      ),
                    ),
                  ],
                ),
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
        UserID1: prefs.getInt('UserID') as int,
        UserName1: prefs.getString('UserName').toString(),
        Phone1: prefs.getString('Phone'),
        Email1: prefs.getString('Email').toString(),
        UserType1: prefs.getString('UserType').toString(),
        UserImage1: prefs.getString('UserImage').toString());
    modelU.UserID = prefs.getInt('UserID');

    return modelU;
  }

  Future<int> AvailableFund() async {
    db.getTotalCollection(widget.apartmentid);
    db.getTotalCollection(widget.apartmentid);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var c = prefs.getInt('collection') as int;
    var t = prefs.getInt('transaction') as int;

    var sum = c - t;

    return sum;
  }
}
