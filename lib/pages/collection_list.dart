import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/models/collection_model.dart';
import 'package:apartment_management/models/verify_model.dart';
import 'package:apartment_management/pages/Add_Collection.dart';
import 'package:apartment_management/pages/admin_user_dashboard.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectionList extends StatefulWidget {
  var apartmentid;
  bool isAdmin;

  CollectionList({required this.apartmentid, required this.isAdmin});

  @override
  State<CollectionList> createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  MyDatabase db = MyDatabase();
  bool isGetData = true;
  List<CollectionModel> localList = [];
  List<CollectionModel> searchList = [];
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<bool>(
          builder: (context, snapshot1) {
            if (snapshot1.hasData && snapshot1.data == true) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddCollection(
                                  apartmentid: widget.apartmentid, model: null),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              Text(
                                'ADD ',
                                style: TextStyle(
                                    color: widget.isAdmin
                                        ? Colors.brown.shade900
                                        : Colors.blue.shade900,
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.add_circle_outline_rounded,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      height: double.maxFinite,
                      child: FutureBuilder<List<CollectionModel>>(
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: DataTable2(
                                      border: TableBorder.all(
                                          color: Colors.black, width: 2),
                                      headingRowColor: MaterialStatePropertyAll(
                                        MaterialStateColor.resolveWith(
                                          (states) => widget.isAdmin
                                              ? Colors.brown.shade900
                                              : Colors.blue.shade900,
                                        ),
                                      ),
                                      dataRowColor: MaterialStatePropertyAll(
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.brown.shade100),
                                      ),
                                      columnSpacing: 1,
                                      horizontalMargin: 5,
                                      minWidth: 370,
                                      columns: [
                                        DataColumn2(
                                          label: Center(
                                            child: Text(
                                              'USERNAME',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          size: ColumnSize.M,
                                        ),
                                        DataColumn2(
                                          label: Center(
                                            child: Text(
                                              'TYPE',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          size: ColumnSize.L,
                                        ),
                                        DataColumn2(
                                          label: Center(
                                            child: Text(
                                              'AMOUNT',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          size: ColumnSize.M,
                                        ),
                                        DataColumn2(
                                            label: Center(
                                              child: Text(
                                                'DATE',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            size: ColumnSize.L),
                                        DataColumn2(
                                            label: Center(
                                              child: Text(
                                                'Edit',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            size: ColumnSize.S),
                                        DataColumn2(
                                            label: Center(
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            size: ColumnSize.S),
                                      ],
                                      rows: List<DataRow>.generate(
                                        searchList.length,
                                        (index) => DataRow(
                                          cells: [
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  searchList[index]
                                                      .UserName
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  searchList[index]
                                                      .CollectionType
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  searchList[index]
                                                      .Amount
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  searchList[index]
                                                      .Date
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: GestureDetector(
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Colors.green,
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddCollection(
                                                          apartmentid: widget
                                                              .apartmentid,
                                                          model: CollectionModel(
                                                              CollectionID1:
                                                                  searchList[index]
                                                                      .CollectionID,
                                                              CollectionTypeID1:
                                                                  searchList[index]
                                                                      .CollectionTypeID,
                                                              CollectionType1:
                                                                  searchList[index]
                                                                      .CollectionType,
                                                              ApartmentID1:
                                                                  searchList[index]
                                                                      .ApartmentID,
                                                              UserID1: searchList[
                                                                      index]
                                                                  .UserID,
                                                              UserName1:
                                                                  searchList[
                                                                          index]
                                                                      .UserName,
                                                              Date1: searchList[
                                                                      index]
                                                                  .Date,
                                                              Amount1:
                                                                  searchList[
                                                                          index]
                                                                      .Amount),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                              ? db.getCollectionData(widget.apartmentid)
                              : null),
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      height: double.maxFinite,
                      child: FutureBuilder<List<CollectionModel>>(
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: DataTable2(
                                      border: TableBorder.all(
                                          color: Colors.black, width: 2),
                                      headingRowColor: MaterialStatePropertyAll(
                                        MaterialStateColor.resolveWith(
                                          (states) => widget.isAdmin
                                              ? Colors.brown.shade900
                                              : Colors.blue.shade900,
                                        ),
                                      ),
                                      dataRowColor: MaterialStatePropertyAll(
                                        MaterialStateColor.resolveWith(
                                            (states) => Colors.brown.shade100),
                                      ),
                                      columnSpacing: 1,
                                      horizontalMargin: 5,
                                      minWidth: 370,
                                      columns: [
                                        DataColumn2(
                                          label: Center(
                                            child: Text(
                                              'USERNAME',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          size: ColumnSize.M,
                                        ),
                                        DataColumn2(
                                          label: Center(
                                            child: Text(
                                              'TYPE',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          size: ColumnSize.L,
                                        ),
                                        DataColumn2(
                                          label: Center(
                                            child: Text(
                                              'AMOUNT',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          size: ColumnSize.M,
                                        ),
                                        DataColumn2(
                                            label: Center(
                                              child: Text(
                                                'DATE',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            size: ColumnSize.L),
                                      ],
                                      rows: List<DataRow>.generate(
                                        searchList.length,
                                        (index) => DataRow(
                                          cells: [
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  searchList[index]
                                                      .UserName
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  searchList[index]
                                                      .CollectionType
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  searchList[index]
                                                      .Amount
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Center(
                                                child: Text(
                                                  searchList[index]
                                                      .Date
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                              ? db.getCollectionData(widget.apartmentid)
                              : null),
                    ),
                  ),
                ],
              );
            }
          },
          future: isAdminOrNot()),
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
}
