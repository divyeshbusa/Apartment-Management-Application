import 'package:apartment_management/Componets/my_button.dart';
import 'package:apartment_management/Componets/my_textfield.dart';
import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/models/apartment_list_model.dart';
import 'package:apartment_management/models/city_model.dart';
import 'package:apartment_management/models/country_model.dart';
import 'package:apartment_management/models/location_model.dart';
import 'package:apartment_management/models/state_model.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:apartment_management/pages/add_apartment.dart';
import 'package:apartment_management/pages/add_user.dart';
import 'package:apartment_management/pages/user_detail.dart';
import 'package:apartment_management/pages/user_list.dart';
import 'package:apartment_management/pages/verification_list.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApartmentList extends StatefulWidget {
  late UserModel? model;

  ApartmentList({required this.model});

  @override
  State<ApartmentList> createState() => _ApartmentListState();
}

class _ApartmentListState extends State<ApartmentList> {
  MyDatabase db = MyDatabase();
  LocationModel modelL = LocationModel(
      CityID1: -1,
      CityName1: 'Select City',
      StateID1: -1,
      StateName1: 'Select State',
      CountryID1: -1,
      CountryName1: 'Select Country');
  CountryModel modelN = CountryModel(
    CountryID1: -1,
    CountryName1: 'Select Country',
  );
  StateModel modelS = StateModel(
    StateID1: -1,
    StateName1: 'Select State',
  );
  CityModel modelC = CityModel(
    CityID1: -1,
    CityName1: 'Select City',
  );

  int selectedCountry = -1;
  int selectedState = -1;
  int selectedCity = -1;

  bool isGetCountry = true;
  bool isGetState = true;
  bool isGetCity = true;
  bool isGetData = true;
  bool isVerify = false;
  bool showVerifyButton = false;

  List<apartmentModel> localList = [];
  List<apartmentModel> searchList = [];
  TextEditingController controller = TextEditingController();
  TextEditingController verifyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    db.copyPasteAssetFileToRoot();
    db.initDatabase();

    setState(() {
      AdminOrNot();
    });
  }

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
                  'Apartment List',
                  style: GoogleFonts.montserratAlternates(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddApartment(model: null),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Add',
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
                        )
                      ],
                    ),
                  ),
                  showVerifyButton
                      ? GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => VerificationList(),
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
                        )
                      : Container(),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<List<CountryModel>>(
                  builder: (context, snapshot) {
                    if (snapshot.data != null || snapshot.hasData) {
                      if (isGetCountry) {
                        modelN = snapshot.data![0];
                      }

                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonWidth: MediaQuery.of(context).size.width * 0.90,
                          items: snapshot.data!
                              .map((item) => DropdownMenuItem<CountryModel?>(
                                    value: item,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item.CountryName.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: modelN,
                          onChanged: (value) {
                            setState(() {
                              isGetCountry = false;
                              modelN = value!;
                              selectedCountry = value!.CountryID;
                              isGetState = true;
                              isGetCity = true;
                              print(
                                  'selectedCountry:::::::::${selectedCountry}');
                            });
                          },
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: const Icon(
                              color: Colors.white,
                              Icons.keyboard_arrow_down_outlined,
                            ),
                          ),
                          iconSize: 28,
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade700),
                            color: Color.fromRGBO(230, 150, 156, 1),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                  future: isGetCountry ? db.getCountryListFromTbl() : null,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<List<StateModel>>(
                  builder: (context, snapshot) {
                    if (snapshot.data != null || snapshot.hasData) {
                      if (isGetState) {
                        modelS = snapshot.data![0];
                      }

                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonWidth: MediaQuery.of(context).size.width * 0.90,
                          items: snapshot.data!
                              .map((item) => DropdownMenuItem<StateModel?>(
                                    value: item,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item.StateName.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: modelS,
                          onChanged: (value) {
                            setState(() {
                              isGetState = false;
                              modelS = value!;
                              selectedState = value.StateID;
                              isGetCity = true;
                            });
                          },
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: const Icon(
                              color: Colors.white,
                              Icons.keyboard_arrow_down_outlined,
                            ),
                          ),
                          iconSize: 28,
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade700),
                            color: Color.fromRGBO(230, 150, 156, 1),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                  future: isGetState
                      ? db.getStateListFromTbl(selectedCountry)
                      : null,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<List<CityModel>>(
                  builder: (context, snapshot) {
                    if (snapshot.data != null || snapshot.hasData) {
                      if (isGetCity) {
                        modelC = snapshot.data![0];
                      }

                      return DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonWidth: MediaQuery.of(context).size.width * 0.90,
                          items: snapshot.data!
                              .map((item) => DropdownMenuItem<CityModel?>(
                                    value: item,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        item.CityName.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: modelC,
                          onChanged: (value) {
                            setState(() {
                              isGetCity = false;
                              modelC = value!;
                              selectedCity = value.CityID;
                            });
                          },
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: const Icon(
                              color: Colors.white,
                              Icons.keyboard_arrow_down_outlined,
                            ),
                          ),
                          iconSize: 28,
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade700),
                            color: Color.fromRGBO(230, 150, 156, 1),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                  future:
                      isGetCity ? db.getCityListFromTbl(selectedState) : null,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                    onTap: () {
                      setState(() {
                        localList.clear();
                        searchList.clear();
                        isGetData = true;
                      });
                    },
                    name: 'Submit',
                    ContainerColor: Color.fromRGBO(174, 143, 60, 1),
                    fontsize: 20,
                    padding: 15),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
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
                                    border: InputBorder.none,
                                    hintText: 'Search'),
                                controller: controller,
                                onChanged: (value) {
                                  searchList.clear();
                                  for (int i = 0; i < localList.length; i++) {
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
                            SizedBox(height: 20),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      // int ID = await db.getUserID(widget.model!.UserName);
                                      // print("USERID:::::$ID");

                                      // db.upsertIntoApartmentWiseUser(
                                      //   ApartmentWiseUserID: null,
                                      //   ApartmentID:
                                      //   searchList[index].ApartmentID,
                                      //   UserID: ID,
                                      //   isAdmin: 0,
                                      //   isVerified: 0,
                                      // );
                                      print(
                                          "USERID::::::${widget.model!.UserID}");
                                      showAlertDialogForVerification(context,
                                          searchList[index].ApartmentID);
                                    },
                                    child: Card(
                                      margin: EdgeInsets.all(10),
                                      elevation: 10,
                                      shape: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  230, 150, 156, 1),
                                              width: 2)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  searchList[index]
                                                      .ApartmentName
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  'Wings :${searchList[index].wings1.toString()}',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 2),
                                              ],
                                            ),
                                          ],
                                        ),
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
                        ? db.getApartmentListFromTbl(selectedCity)
                        : null),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialogForVerification(BuildContext context, int? apartmentID) {
    verifyController.text = '';
    Widget okButton = TextButton(
      child: Container(
        color: Colors.grey.shade700,
        padding: EdgeInsets.all(10),
        child: Text(
          "Verify",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      onPressed: () async {
        print("USERID::::::${widget.model!.UserID}");
        int verifydata = await db.VerifiedOrNot(
            code: verifyController.text.toString(),
            UserID: widget.model!.UserID as int);
        print('VERIFY:::DATA::::::${verifydata}');
        if (verifydata == 1) {
          Future.delayed(
            Duration.zero,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetail(),
                ),
              );
            },
          );
        } else if (verifydata == 2) {
          Future.delayed(
            Duration.zero,
            () {
              showAlertDialogForNotVerifyYet(context);
            },
          );
        } else {
          Future.delayed(
            Duration.zero,
            () {
              db.upsertIntoApartmentWiseUser(
                ApartmentWiseUserID: null,
                ApartmentID: apartmentID,
                UserID: widget.model!.UserID as int,
                isVerified: 0,
                isAdmin: 0,
              );
              showAlertDialogForSendingToVerification(context);
            },
          );
        }
        // setState(() {
        //   verifyController.clear();
        // });
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Color.fromRGBO(230, 150, 156, 1),
      shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      title: Text(
        "Enter Verificaton Code",
        style: TextStyle(color: Colors.white),
      ),
      content: MyTextField(
          controller: verifyController,
          hintText: 'Verification Code',
          obscureText: false,
          onChange: (value) {}),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogForNotVerifyYet(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Color.fromRGBO(230, 150, 156, 1),
      shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      title: Text(
        "",
        style: TextStyle(color: Colors.white),
      ),
      content: Text("Admin has not yet verified you, PLEASE WAIT",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogForSendingToVerification(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Color.fromRGBO(230, 150, 156, 1),
      shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      title: Text(
        "",
        style: TextStyle(color: Colors.white),
      ),
      content: Text("Your Request send succesfully for verification.",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> AdminOrNot() async {
    int isAdmin = await db.getAdminOrNotFromTbl(widget.model!.UserID as int);
    print("::::::isAdmin:::${isAdmin}::::::::");
    if (isAdmin == 1) {
      showVerifyButton = true;
    }
  }
}
