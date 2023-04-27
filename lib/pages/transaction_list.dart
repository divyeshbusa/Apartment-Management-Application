import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/models/transaction_model.dart';
import 'package:apartment_management/pages/add_tansaction.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionList extends StatefulWidget {
  var apartmentid;
  bool isAdmin;

  TransactionList({required this.apartmentid, required this.isAdmin});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    MyDatabase db = MyDatabase();
    bool isGetData = true;
    List<TransactionModel> localList = [];
    List<TransactionModel> searchList = [];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<bool>(
        builder: (context, snapshot) {
          if (snapshot.data == true && snapshot.hasData) {
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
                            builder: (context) => AddTransaction(
                              apartmentid: widget.apartmentid,
                              model: null,
                            ),
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
                                  color: Colors.brown.shade900,
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
                    child: FutureBuilder<List<TransactionModel>>(
                        builder: (context, snapshot) {
                          if (snapshot != null && snapshot.hasData) {
                            if (isGetData) {
                              localList.addAll(snapshot.data!);
                              searchList.addAll(localList);
                            }
                            isGetData = false;

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
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
                                            (states) => Colors.brown.shade100)),
                                    columnSpacing: 1,
                                    horizontalMargin: 1,
                                    minWidth: 400,
                                    columns: [
                                      DataColumn2(
                                        label: Center(
                                          child: Text(
                                            'USERNAME',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Center(
                                          child: Text(
                                            'TYPE',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Center(
                                          child: Text(
                                            'REMARK',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Center(
                                          child: Text(
                                            'AMOUNT',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        size: ColumnSize.L,
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
                                          size: ColumnSize.L),
                                      DataColumn2(
                                          label: Center(
                                            child: Text(
                                              'Delete',
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
                                                            .TansactionType ==
                                                        0
                                                    ? 'DEBIT'
                                                    : 'CREDIT',
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Center(
                                              child: Text(
                                                searchList[index]
                                                    .Remark
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
                                                          AddTransaction(
                                                        apartmentid:
                                                            widget.apartmentid,
                                                        model: TransactionModel(
                                                            TansactionType1:
                                                                searchList[index]
                                                                    .TansactionType,
                                                            ApartmentID1:
                                                                searchList[index]
                                                                    .ApartmentID,
                                                            UserID1: searchList[
                                                                    index]
                                                                .UserID,
                                                            UserName1:
                                                                searchList[index]
                                                                    .UserName,
                                                            Date1: searchList[
                                                                    index]
                                                                .Date,
                                                            Amount1: searchList[
                                                                    index]
                                                                .Amount,
                                                            Remark1: searchList[
                                                                    index]
                                                                .Remark),
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
                            ? db.getTransactionData(widget.apartmentid)
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
                    child: FutureBuilder<List<TransactionModel>>(
                        builder: (context, snapshot) {
                          if (snapshot != null && snapshot.hasData) {
                            if (isGetData) {
                              localList.addAll(snapshot.data!);
                              searchList.addAll(localList);
                            }
                            isGetData = false;

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
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
                                            (states) => Colors.brown.shade100)),
                                    columnSpacing: 1,
                                    horizontalMargin: 1,
                                    minWidth: 400,
                                    columns: [
                                      DataColumn2(
                                        label: Center(
                                          child: Text(
                                            'USERNAME',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Center(
                                          child: Text(
                                            'TYPE',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        size: ColumnSize.M,
                                      ),
                                      DataColumn2(
                                        label: Center(
                                          child: Text(
                                            'REMARK',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        size: ColumnSize.L,
                                      ),
                                      DataColumn2(
                                        label: Center(
                                          child: Text(
                                            'AMOUNT',
                                            style:
                                                TextStyle(color: Colors.white),
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
                                                            .TansactionType ==
                                                        0
                                                    ? 'DEBIT'
                                                    : 'CREDIT',
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Center(
                                              child: Text(
                                                searchList[index]
                                                    .Remark
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
                            ? db.getTransactionData(widget.apartmentid)
                            : null),
                  ),
                ),
              ],
            );
          }
        },
        future: isAdminOrNot(),
      ),
    );
  }

  Future<bool> isAdminOrNot() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getInt('UserID');
    print("::::::Userid:::${userid}::::::::");
    int isAdmin =
        await MyDatabase().getAdminOrNotFromTbl(userid!, widget.apartmentid);
    print("::::::isAdmin:::${isAdmin}::::::::");
    return (isAdmin == 1);
  }
}
