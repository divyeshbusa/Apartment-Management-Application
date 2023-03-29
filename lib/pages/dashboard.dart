import 'package:apartment_management/login/login_page.dart';
import 'package:apartment_management/login/splashscreen.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:apartment_management/pages/add_apartment.dart';
import 'package:apartment_management/pages/apartment_list.dart';
import 'package:apartment_management/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  late UserModel? model;

  Dashboard({required this.model});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.grey.shade700,
          // elevation: 10,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(100),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Dashboard',
                style: GoogleFonts.montserratAlternates(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ]),
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
                          "assets/images/apartment.jpg",
                          height: 130,
                        ),
                      ],
                    )),
                  ],
                ),
              ),
              ListTile(
                onTap:(){
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
                          color: Color.fromRGBO(174, 143, 60, 1)),
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

                  var prefs = await SharedPreferences.getInstance();
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
                          color: Color.fromRGBO(174, 143, 60, 1)),
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
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/images/background.jpg",
              fit: BoxFit.fill,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(40),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                  ),
                  children: [
                    InkWell(
                      onTap: () {
                        print(
                            "MODEL::::::::${widget.model!.UserName.toString()}");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ApartmentList(model: widget.model),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                              child: Image.asset(
                                "assets/images/apartment.jpg",
                                opacity: AlwaysStoppedAnimation(0.8),
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Text(
                                'Add in Apartment ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddApartment(model: null),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                              child: Image.asset(
                                "assets/images/apartment2.jpg",
                                opacity: AlwaysStoppedAnimation(0.8),
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: Text(
                                'Add Your Apartment',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
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
}
