import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/models/apartment_list_model.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:apartment_management/pages/add_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserList extends StatefulWidget {
  late apartmentModel? model;

  UserList({required this.model});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  MyDatabase db = MyDatabase();
  bool isGetData = true;
  List<UserModel> localList = [];
  List<UserModel> searchList = [];
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
                  'Member List',
                  style: GoogleFonts.montserratAlternates(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: Column(children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddUser(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Add User',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.add_circle,
                    color: Color.fromRGBO(174, 143, 60, 1),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: FutureBuilder<List<UserModel>>(
                  builder: (context, snapshot) {
                    print("::::SnapShot1::::::::${snapshot.data}");
                    print(":::::::::ENTER IN BUILD METHOD::::::::");
                    if (snapshot != null && snapshot.hasData) {
                      print("::::SnapShot12::::::::${snapshot.data}");
                      if (isGetData) {
                        print("::::SnapShot13::::::::${snapshot.data}");
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
                                  color:
                                  Color.fromRGBO(230, 150, 156, 1)),
                            ),
                            child: TextField(
                              style: TextStyle(
                                  color:
                                  Color.fromRGBO(230, 150, 156, 1),
                                  fontSize: 17),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search'),
                              controller: controller,
                              onChanged: (value) {
                                searchList.clear();
                                for (int i = 0;
                                i < localList.length;
                                i++) {
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
                                      BorderRadius.all(
                                          Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Color.fromRGBO(
                                              230, 150, 156, 1),
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
                                                  .UserName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              'Phone :${searchList[index].Phone.toString()}',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            ),
                                            SizedBox(height: 2),
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
                  future: isGetData
                      ? db.getDataFromUserTable(widget.model!.ApartmentID as int)
                      : null),
            )
          ),
        ]),
      ),
    );
  }
}
