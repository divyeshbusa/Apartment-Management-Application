import 'package:apartment_management/Componets/my_textfield.dart';
import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/models/collection_model.dart';
import 'package:apartment_management/models/collection_type_model.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddCollection extends StatefulWidget {
  var apartmentid;
  late CollectionModel? model;

  AddCollection({required this.apartmentid, required this.model});

  @override
  State<AddCollection> createState() => _AddCollectionState();
}

class _AddCollectionState extends State<AddCollection> {
  late TextEditingController nameController;
  late TextEditingController amountController;
  late TextEditingController typeController;

  MyDatabase db = MyDatabase();
  DateTime selectedDate = DateTime.now();
  bool isValid = true;
  bool isGetUser = true;
  bool isGetType = true;
  final _formKey = GlobalKey<FormState>();
  UserModel modelU = UserModel(
    UserID1: -1,
    UserName1: 'Select User',
    Phone1: 0,
    Email1: '',
    UserType1: '',
    UserImage1: '',
  );
  CollectionModel modelC = CollectionModel(
      CollectionID1: -1,
      CollectionTypeID1: -1,
      CollectionType1: 'Select type',
      ApartmentID1: -1,
      UserID1: -1,
      UserName1: '',
      Date1: '',
      Amount1: 0);
  CollectionTypeModel modelT = CollectionTypeModel(
      CollectionTypeID1: -1, CollectionType1: "Select type");

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: modelU != null ? modelU.UserName.toString() : '');

    amountController = TextEditingController(
        text: widget.model != null ? widget.model?.Amount.toString() : '');

    typeController = TextEditingController(
        text: widget.model != null ? widget.model?.CollectionType.toString() : '');
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  'Add Collection',
                  style: GoogleFonts.montserratAlternates(
                      color: Color.fromRGBO(66, 66, 66, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      const Text(
                        'User Name :',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 150, 166, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: FutureBuilder<List<UserModel>>(
                            builder: (context, snapshot) {
                              if (snapshot.data != null || snapshot.hasData) {
                                if (isGetUser) {
                                  modelU = snapshot.data![0];
                                }

                                return DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    items: snapshot.data!
                                        .map((item) =>
                                            DropdownMenuItem<UserModel?>(
                                              value: item,
                                              child: Text(widget.model!=null?
                                                widget.model!.UserName.toString():item.UserName.toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: modelU,
                                    onChanged: (value) {
                                      setState(() {
                                        isGetUser = false;
                                        modelU = value!;
                                      });
                                    },
                                    iconStyleData: IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                      ),
                                      iconSize: 35,
                                    ),
                                    buttonStyleData: ButtonStyleData(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                            future: isGetUser
                                ? db.getDataFromUserTable(widget.apartmentid)
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Collection Type :',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 150, 166, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: FutureBuilder<List<CollectionTypeModel>>(
                            builder: (context, snapshot) {
                              if (snapshot.data != null || snapshot.hasData) {
                                if (isGetType) {
                                  modelT = snapshot.data![0];
                                }

                                return DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    items: snapshot.data!
                                        .map((item) => DropdownMenuItem<
                                                CollectionTypeModel?>(
                                              value: item,
                                              child: Text(widget.model!=null?
                                                widget.model!.CollectionType.toString():item.CollectionType.toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: modelT,
                                    onChanged: (value) {
                                      setState(() {
                                        isGetType = false;
                                        modelT = value!;
                                      });
                                    },
                                    iconStyleData: IconStyleData(
                                      icon: Icon(
                                        Icons.arrow_drop_down_sharp,
                                      ),
                                      iconSize: 35,
                                    ),
                                    buttonStyleData: ButtonStyleData(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                            future: isGetType ? db.getCollectionType() : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Amount :',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 150, 166, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: MyTextField(
                            controller: amountController,
                            hintText: 'Amount',
                            obscureText: false,
                            onChange: (value) {},
                            validation: 'please, enter Amount'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'DATE OF BIRTH :',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () => _pickDateDialog(),
                            child: Text(widget.model!=null?
                              widget.model!.Date:getFormateddate(selectedDate),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromRGBO(255, 150, 166, 1),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      // Text('Enter Valid date.')
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        db.upsertIntoCollectionTable(
                          CollectionID: widget.model != null
                              ? widget.model!.CollectionID
                              : -1,
                          UserID: modelU!.UserID,
                          ApartmentID: widget.apartmentid,
                          type: modelT?.CollectionTypeID,
                          Amount: amountController.text.toString(),
                          date: getFormateddate(selectedDate),

                        );
                        debugPrint(getFormateddate(selectedDate));
                      }
                      setState(() {
                      });
                      Navigator.of(context).pop();

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
                          'Add Detail',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
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

  void _pickDateDialog() {
    showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(1950),
            lastDate: DateTime.now())
        .then((pickedDate) {
      setState(() {
        selectedDate = pickedDate!;
      });
    });
  }

  String getFormateddate(dateToFormate) {
    if (isValid) {}
    if (dateToFormate != null) {
      return DateFormat('dd/MM/yyyy').format(dateToFormate);
    } else {
      return DateFormat('dd/MM/yyyy').format(DateTime.now());
    }
  }
}
