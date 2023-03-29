import 'package:apartment_management/Componets/my_textfield.dart';
import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/login/splashscreen.dart';
import 'package:apartment_management/models/apartment_list_model.dart';
import 'package:apartment_management/models/password_model.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:apartment_management/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController typeController;
  late TextEditingController imageController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  MyDatabase db = MyDatabase();
  final _formKey = GlobalKey<FormState>();
  UserModel modelU = UserModel(
    UserName1: '',
    Phone1: 0,
    Email1: '',
    UserType1: '',
    UserImage1: '',
  );
  PasswordModel modelP = PasswordModel(Password1: '', UserID1: -1);

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: modelU != null ? modelU.UserName.toString() : '');

    phoneController = TextEditingController(
        text: modelU != null ? modelU.Phone.toString() : '');

    emailController = TextEditingController(
        text: modelU != null ? modelU.Email.toString() : '');

    typeController = TextEditingController(
        text: modelU != null ? modelU.UserType.toString() : '');

    imageController = TextEditingController(
        text: modelU != null ? modelU.UserImage.toString() : '');

    passwordController = TextEditingController(
        text: modelP != null ? modelP.Password.toString() : '');

    confirmPasswordController = TextEditingController(text: '');
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
                  'Registration Form',
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
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 30,
                        child: Text(
                          'User Name :',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 150, 166, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 75,
                          child: MyTextField(
                              controller: nameController,
                              hintText: 'User name',
                              obscureText: false,
                              onChange: (value) {})),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 30,
                        child: Text(
                          'Phone :',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 150, 166, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 75,
                          child: MyTextField(
                              controller: phoneController,
                              hintText: 'Phone',
                              obscureText: false,
                              onChange: (value) {})),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 30,
                        child: Text(
                          'Email :',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 150, 166, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 75,
                          child: MyTextField(
                              controller: emailController,
                              hintText: 'Email',
                              obscureText: false,
                              onChange: (value) {})),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 30,
                        child: Text(
                          'User Type :',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 150, 166, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 75,
                          child: MyTextField(
                              controller: typeController,
                              hintText: 'User Type',
                              obscureText: false,
                              onChange: (value) {})),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 30,
                        child: Text(
                          'Password :',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 150, 166, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 75,
                          child: MyTextField(
                              controller: passwordController,
                              hintText: 'password',
                              obscureText: false,
                              onChange: (value) {})),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 30,
                        child: Text(
                          'Confirm Password :',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 150, 166, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          flex: 75,
                          child: MyTextField(
                              controller: confirmPasswordController,
                              hintText: 'Confirm password',
                              obscureText: false,
                              onChange: (value) {})),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        print(':::::Password:::::::${passwordController}');
                        print(
                            ':::::Confirm password:::::::${confirmPasswordController}');

                        if (passwordController.text.toString() ==
                            confirmPasswordController.text.toString()) {
                          print(':::::CALLING 2:::::::');
                          print(':::::USER ID BEFORE:::::::${modelU!.UserID}');

                          modelU.UserID = await db.upsertIntoUserTable(
                            UserID: modelU!.UserID,
                            UserName: nameController.text.toString(),
                            Email: emailController.text.toString(),
                            Phone: phoneController.text,
                            UserType: typeController.text.toString(),
                            UserImage: imageController.text.toString(),
                          );

                          print(':::::USER ID AFTER:::::::${modelU.UserID}');

                          db.upsertIntoPasswordTable(
                              PasswordID: modelP.PassworID,
                              UserID: modelU.UserID,
                              Password: passwordController.text.toString());

                          print(':::::CALLING SHARED PREFERANCE:::::::');

                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setInt('UserID', modelU.UserID as int);
                          await prefs.setString(
                              'UserName', nameController.text.toString());
                          await prefs.setString(
                              'Email', emailController.text.toString());
                          await prefs.setString('Phone', phoneController.text);
                          await prefs.setString(
                              'UserType', typeController.text.toString());
                          await prefs.setString(
                              'UserImage', imageController.text.toString());

                          prefs.setBool(SplashScreenState.KEYLOGIN, true);

                          print(':::::CALLED SHARED PREFERANCE:::::::');

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Dashboard(model: modelU),
                            ),
                          );
                        } else {
                          showAlertDialogNotMatchPassword(context);
                        }
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
                          'Sign in',
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

  showAlertDialogNotMatchPassword(BuildContext context) {
    Widget okButton = TextButton(
      child: Text(
        "Close",
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
      content: Text("Password and ConfirmPassword not matched.",
          style: TextStyle(color: Colors.white)),
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
}
