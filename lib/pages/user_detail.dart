import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/pages/verification_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetail extends StatefulWidget {
  var apartmentid;

  UserDetail({required this.apartmentid});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  MyDatabase db = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Column(
          children: [
            SizedBox(height: 10),
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
                        child: Row(
                          children: [
                            Text(
                              'Verify',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.verified_rounded,
                              color: Color.fromRGBO(174, 143, 60, 1),
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
            SizedBox(height: 10),
            Center(
              child: Text('USER DATA'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> isAdminOrNot() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('UserID');
    int isAdmin = await db.getAdminOrNotFromTbl(userid!, widget.apartmentid);
    print("::::::isAdmin:::${isAdmin}::::::::");
    return (isAdmin == 1);
  }
}
