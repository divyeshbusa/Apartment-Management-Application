import 'package:apartment_management/Componets/my_textfield.dart';
import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/models/apartment_list_model.dart';
import 'package:apartment_management/models/city_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddApartment extends StatefulWidget {
  late apartmentModel? model;

  AddApartment({required this.model});

  @override
  State<AddApartment> createState() => _AddApartmentState();
}

class _AddApartmentState extends State<AddApartment> {
  late TextEditingController nameController;
  late TextEditingController codeController;
  late TextEditingController wingController;
  final _formKey = GlobalKey<FormState>();
  MyDatabase db = MyDatabase();
  CityModel modelC = CityModel(
    CityID1: -1,
    CityName1: 'Select City',
  );
  bool isGetCity = true;
  bool SubmitValue = false;
  int selectedCity = -1;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text:
            widget.model != null ? widget.model!.ApartmentName.toString() : '');

    codeController = TextEditingController(
        text:
            widget.model != null ? widget.model!.ApartmentCode.toString() : '');

    wingController = TextEditingController(
        text: widget.model != null ? widget.model!.wings.toString() : '');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(66, 66, 66, 1),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.grey.shade700,
          ),
          backgroundColor: Colors.white,
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
                  'Add Apartment',
                  style: GoogleFonts.montserratAlternates(
                      color: Color.fromRGBO(66, 66, 66, 1),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Name :',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 150, 166, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: MyTextField(
                            validation: "please enter apartment name.",
                            controller: nameController,
                            hintText: 'Apartment Name',
                            obscureText: false,
                            onChange: (value) {}),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        ' Code :',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 150, 166, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: MyTextField(
                            validation: "please enter apartment code.",
                            controller: codeController,
                            hintText: 'Apartment Code',
                            obscureText: false,
                            onChange: (value) {}),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Wings :',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 150, 166, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: MyTextField(
                            validation: "please enter Wings.",
                            controller: wingController,
                            hintText: 'Total Wings',
                            obscureText: false,
                            onChange: (value) {}),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        ' City :',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 150, 166, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      FutureBuilder<List<CityModel>>(
                        builder: (context, snapshot) {
                          if (snapshot.data != null || snapshot.hasData) {
                            if (isGetCity) {
                              modelC = snapshot.data![0];
                            }

                            return DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                buttonStyleData: ButtonStyleData(

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.grey.shade700),
                                    color: Color.fromRGBO(230, 150, 156, 1),
                                  ),
                                ),
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
                                    SubmitValue = true;
                                  });
                                },
                                iconStyleData: IconStyleData(
                                  icon: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: const Icon(
                                      color: Colors.white,
                                      Icons.keyboard_arrow_down_outlined,
                                    ),
                                  ),
                                  iconSize: 28,
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                        future: isGetCity ? db.getCityListFromTbl(-1) : null,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        print(':::::CALLING 2:::::::');

                        db.upsertIntoApartmentTable(
                          ApartmentID: widget.model != null
                              ? widget.model!.ApartmentID
                              : -1,
                          City: modelC.CityID,
                          ApartmentName: nameController.text.toString(),
                          Wings: wingController.text.toString(),
                          Code: codeController.text.toString(),
                        );
                        setState(() {});
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.grey.shade700),
                        color: Color.fromRGBO(174, 143, 60, 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
