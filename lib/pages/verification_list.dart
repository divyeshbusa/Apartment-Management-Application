import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/models/verify_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationList extends StatefulWidget {
  var apartmentid;

  VerificationList({required this.apartmentid});

  @override
  State<VerificationList> createState() => _VerificationListState();
}

class _VerificationListState extends State<VerificationList> {
  MyDatabase db = MyDatabase();
  bool isGetData = true;
  List<VerifyModel> localList = [];
  List<VerifyModel> searchList = [];
  TextEditingController controller = TextEditingController();


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
                  'VERIFICATION LIST',
                  style: GoogleFonts.montserratAlternates(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder<List<VerifyModel>>(
              builder: (context, snapshot) {
                if (snapshot != null && snapshot.hasData) {
                  if (isGetData) {
                    localList.addAll(snapshot.data!);
                    searchList.addAll(localList);
                  }
                  isGetData = false;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(1),
                          border: Border.all(
                              color: Color.fromRGBO(230, 150, 156, 1)),
                        ),
                        child: TextField(
                          style: TextStyle(
                              color: Color.fromRGBO(230, 150, 156, 1),
                              fontSize: 17),
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Search'),
                          controller: controller,
                          onChanged: (value) {
                            searchList.clear();
                            for (int i = 0; i < localList.length; i++) {
                              if (localList[i]
                                  .UserName
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
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.all(10),
                              elevation: 10,
                              shape: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(230, 150, 156, 1),
                                      width: 2)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    searchList[index]
                                                        .UserName
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Phone",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    " : ",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    searchList[index]
                                                        .Phone
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Email",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    " : ",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    searchList[index]
                                                        .Email
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "User Type",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    " : ",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    searchList[index]
                                                        .UserType
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            db.upsertIntoApartmentWiseUser(
                                              ApartmentWiseUserID:
                                                  searchList[index]
                                                      .ApartmentWiseUserID,
                                              ApartmentID:  searchList[index]
                                                  .ApartmentID,
                                              UserID:  searchList[index]
                                                  .UserID,
                                              isAdmin:  searchList[index]
                                                  .isAdmin,
                                              isVerified: 1,


                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.verified_rounded,
                                                color: Color.fromRGBO(
                                                    174, 143, 60, 1),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                'Verify',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          " Want to add in Apartment",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  255, 100, 156, 1),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "\" ${searchList[index].ApartmentName.toString()} \"",
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  194, 143, 60, 1),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: searchList.length,
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
              future: isGetData ? db.getNotVerifirdUsrListFromTbl(widget.apartmentid) : null),
        ),
      ),
    );
  }
}
