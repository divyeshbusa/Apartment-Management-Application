import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/login/login_page.dart';
import 'package:apartment_management/login/splashscreen.dart';
import 'package:apartment_management/models/apartment_list_model.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:apartment_management/pages/add_apartment.dart';
import 'package:apartment_management/pages/admin_user_dashboard.dart';
import 'package:apartment_management/pages/apartment_list.dart';
import 'package:apartment_management/About_Us/devloper_screen.dart';
import 'package:apartment_management/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserwiseApartmentList extends StatefulWidget {
  var id;

  UserwiseApartmentList({required this.id});

  @override
  State<UserwiseApartmentList> createState() => _UserwiseApartmentListState();
}

class _UserwiseApartmentListState extends State<UserwiseApartmentList> {
  MyDatabase db = MyDatabase();
  bool isGetData = true;
  List<apartmentModel> localList = [];
  List<apartmentModel> searchList = [];
  TextEditingController controller = TextEditingController();
  TextEditingController verifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.brown,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'Apartment List',
                  style: GoogleFonts.montserratAlternates(
                      color: Colors.brown.shade900,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/splashscreen.gif",
                          height: 130,
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueGrey.shade700,
                      ),
                      height: 40,
                      width: 40,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 30),
                    const Text(
                      'Profile',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  UserModel modelU = UserModel(
                      UserID1: prefs.getInt('UserID') as int,
                      UserName1: prefs.getString('UserName').toString(),
                      Phone1: prefs.getString('Phone'),
                      Email1: prefs.getString('Email').toString(),
                      UserType1: prefs.getString('UserType').toString(),
                      UserImage1: prefs.getString('UserImage').toString());
                  modelU.UserID = prefs.getInt('UserID');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApartmentList(model: modelU),
                    ),
                  );
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueGrey.shade700,
                      ),
                      height: 40,
                      width: 40,
                      child: const Icon(
                        Icons.list_alt_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 30),
                    const Text(
                      'Add in Apartment',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  UserModel modelU = UserModel(
                      UserID1: prefs.getInt('UserID') as int,
                      UserName1: prefs.getString('UserName').toString(),
                      Phone1: prefs.getString('Phone'),
                      Email1: prefs.getString('Email').toString(),
                      UserType1: prefs.getString('UserType').toString(),
                      UserImage1: prefs.getString('UserImage').toString());
                  modelU.UserID = prefs.getInt('UserID');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddApartment(model: null),
                    ),
                  );
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueGrey.shade700,
                      ),
                      height: 40,
                      width: 40,
                      child: const Icon(
                        Icons.add_business,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 30),
                    const Text(
                      'Add your Apartment',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUs(),
                    ),
                  );
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueGrey.shade700,
                        // color:  Colors.blueGrey.shade700,,
                      ),
                      height: 40,
                      width: 40,
                      child: const Icon(
                        Icons.engineering_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 30),
                    const Text(
                      'Devloper',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  prefs.setBool(SplashScreenState.KEYLOGIN, false);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blueGrey.shade700,
                      ),
                      height: 40,
                      width: 40,
                      child: const Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 30),
                    const Text(
                      'Log Out',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            // Container(
            //   height: double.maxFinite,
            //   child: Image.asset(
            //     "assets/images/bg4.jpg",
            //     fit: BoxFit.fill,
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FutureBuilder<List<apartmentModel>>(
                  builder: (context, snapshot) {
                    if (snapshot != null && snapshot.hasData) {
                      if (isGetData) {
                        localList.addAll(snapshot.data!);
                        searchList.addAll(localList);
                      }
                      isGetData = false;

                      return localList.length != 0
                          ? Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: 60,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: TextField(
                                    style: TextStyle(
                                        color: Colors.brown, fontSize: 17),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: BorderSide(
                                              color: Colors.blueGrey.shade900,
                                              width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: BorderSide(
                                              color: Colors.deepOrange,
                                              width: 3),
                                        ),
                                        hintText: 'Search',
                                        hintStyle: TextStyle(
                                            color: Colors.deepOrange,
                                            fontWeight: FontWeight.bold)),
                                    controller: controller,
                                    onChanged: (value) {
                                      searchList.clear();
                                      for (int i = 0;
                                          i < localList.length;
                                          i++) {
                                        if (localList[i]
                                            .ApartmentName
                                            .toLowerCase()
                                            .contains(value.toLowerCase())) {
                                          searchList.add(localList[i]);

                                          print(
                                              'SEARCHLIST::::LENGHTH::::${searchList.length}');
                                          print(
                                              'LOCALLIST::::LENGHTH::::${localList[i]}');
                                        }
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminUserDashboard(
                                                    modelA: searchList[index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Card(
                                              shadowColor: Colors.red.shade300,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              elevation: 10,
                                              shape: const OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  borderSide: BorderSide(
                                                      // color: Color.fromRGBO(
                                                      //     230, 150, 156, 1),
                                                      color: Colors.deepOrange,
                                                      width: 2)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          searchList[index]
                                                              .ApartmentName
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueGrey
                                                                  .shade900,
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        // SizedBox(height: 5),
                                                        // Text(
                                                        //   'Wings :${searchList[index].wings1.toString()}',
                                                        //   style: TextStyle(
                                                        //       fontSize: 13,
                                                        //       fontWeight:
                                                        //       FontWeight.bold),
                                                        // ),
                                                        SizedBox(height: 2),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          )
                                        ],
                                      );
                                    },
                                    itemCount: searchList.length,
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    UserModel modelU = UserModel(
                                        UserID1: prefs.getInt('UserID') as int,
                                        UserName1: prefs
                                            .getString('UserName')
                                            .toString(),
                                        Phone1: prefs.getString('Phone'),
                                        Email1:
                                            prefs.getString('Email').toString(),
                                        UserType1: prefs
                                            .getString('UserType')
                                            .toString(),
                                        UserImage1: prefs
                                            .getString('UserImage')
                                            .toString());
                                    modelU.UserID = prefs.getInt('UserID');

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ApartmentList(model: modelU),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    margin: EdgeInsets.all(10),
                                    shadowColor: Colors.white,
                                    elevation: 10,
                                    shape: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 25, 15, 25),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Want to Enter in Aprtment ?',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();

                                    UserModel modelU = UserModel(
                                        UserID1: prefs.getInt('UserID') as int,
                                        UserName1: prefs
                                            .getString('UserName')
                                            .toString(),
                                        Phone1: prefs.getString('Phone'),
                                        Email1:
                                            prefs.getString('Email').toString(),
                                        UserType1: prefs
                                            .getString('UserType')
                                            .toString(),
                                        UserImage1: prefs
                                            .getString('UserImage')
                                            .toString());
                                    modelU.UserID = prefs.getInt('UserID');

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddApartment(model: null),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    margin: EdgeInsets.all(10),
                                    shadowColor: Colors.white,
                                    elevation: 10,
                                    shape: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 25, 15, 25),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Want to Add Your Apartment \nto list?',
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            );
                    } else {
                      return Center(
                        child: Text('USER NOT FOUND '),
                      );
                    }
                  },
                  future: isGetData
                      ? db.getApartmentListUserWise(widget.id)
                      : null),
            ),
          ],
        ),
      ),
    );
  }
}
