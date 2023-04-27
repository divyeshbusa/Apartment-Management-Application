import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/models/verify_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberList extends StatefulWidget {
  var apartmentid;
  bool isAdmin;

  MemberList({required this.apartmentid,required this.isAdmin});

  @override
  State<MemberList> createState() => _MemberListState();
}

class _MemberListState extends State<MemberList> {

  MyDatabase db = MyDatabase();
  bool isGetData = true;
  List<MemberModel> localList = [];
  List<MemberModel> searchList = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: double.maxFinite,
        child: FutureBuilder<List<MemberModel>>(
            builder: (context, snapshot) {
              if (snapshot != null &&
                  snapshot.hasData) {
                if (isGetData) {
                  localList.addAll(snapshot.data!);
                  searchList.addAll(localList);
                }
                isGetData = false;

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // TextField(
                    //   style: TextStyle(
                    //       color: Color.fromRGBO(
                    //           230, 150, 156, 1),
                    //       fontSize: 17),
                    //   decoration: InputDecoration(
                    //     enabledBorder:
                    //         OutlineInputBorder(
                    //             borderSide: BorderSide(
                    //                 color:
                    //                     Colors.brown
                    //                         .shade900,
                    //                 width: 2),
                    //             borderRadius:
                    //                 BorderRadius
                    //                     .circular(
                    //                         12)),
                    //     focusedBorder:
                    //         OutlineInputBorder(
                    //       borderSide: BorderSide(
                    //         color: Color.fromRGBO(
                    //             237, 192, 80, 1),
                    //       ),
                    //     ),
                    //     fillColor: Colors.white,
                    //     filled: true,
                    //     hintText: 'Search',
                    //     hintStyle: TextStyle(
                    //       color: Color.fromRGBO(
                    //           67, 89, 101, 1),
                    //     ),
                    //   ),
                    //   controller: controller,
                    //   onChanged: (value) {
                    //     searchList.clear();
                    //     for (int i = 0;
                    //         i < localList.length;
                    //         i++) {
                    //       if (localList[i]
                    //           .UserName
                    //           .toLowerCase()
                    //           .contains(value
                    //               .toLowerCase())) {
                    //         searchList
                    //             .add(localList[i]);
                    //
                    //         print(
                    //             'SEARCHLIST::::LENGHTH::::${searchList.length}');
                    //         print(
                    //             'LOCALLIST::::LENGHTH::::${localList[i]}');
                    //       }
                    //     }
                    //     setState(() {});
                    //   },
                    // ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder:
                            (context, index) {
                          return Card(
                            color:
                            widget.isAdmin ? Colors.brown.shade500:Colors.blue.shade900,
                            elevation: 10,
                            shape: const OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(
                                    Radius
                                        .circular(
                                        10)),
                                borderSide:
                                BorderSide(
                                    color: Colors
                                        .white,
                                    width: 2)),
                            child: Padding(
                              padding:
                              const EdgeInsets
                                  .all(15.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .center,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  searchList[index].UserName.toString(),
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                5),
                                            Row(
                                              children: [
                                                Text(
                                                  "Phone",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  " : ",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  searchList[index].Phone.toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Email",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  " : ",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  searchList[index].Email.toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "User Type",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  " : ",
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  searchList[index].UserType.toString(),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height:
                                                10),
                                          ],
                                        ),
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
            future: isGetData
                ? db.getMemberData(widget.apartmentid)
                : null),
      ),
    );
  }
}
