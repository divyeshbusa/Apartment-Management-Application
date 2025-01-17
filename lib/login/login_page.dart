import 'package:apartment_management/Componets/Gmail_login.dart';
import 'package:apartment_management/Componets/my_button.dart';
import 'package:apartment_management/Componets/my_textfield.dart';
import 'package:apartment_management/Componets/sqare_tile.dart';
import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/login/splashscreen.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:apartment_management/pages/add_user.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/userwise_apartment_list.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usernameController = TextEditingController();
  final passwordController = TextEditingController();
  MyDatabase db = MyDatabase();
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isGetData = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                      child: Image.asset('assets/images/intro1.png'),
                      height: 230),
                  SizedBox(height: 20),
                  const Text(
                    'APARTMENT MANAGEMENT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Make it ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '" SIMPLE "',
                        style: TextStyle(
                          color: Color.fromRGBO(174, 143, 60, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "please enter username.";
                        } else {
                          return null;
                        }
                      },
                      controller: usernameController,
                      obscureText: false,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(237, 192, 80, 1),
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Username",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(67, 89, 101, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "please enter password.";
                        } else {
                          return null;
                        }
                      },
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration:  InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(237, 192, 80, 1),
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(67, 89, 101, 1),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          child: Icon(
                            CupertinoIcons.eye,
                            color: hidePassword ? Colors.black : Colors.deepOrange,
                          ),
                        ),

                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: InkWell(
                      // onTap: () {
                      //   Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //       builder: (context) => ForgotScreen(true),
                      //     ),
                      //   );
                      // },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Color.fromRGBO(174, 143, 60, 1)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  MyButton(
                    name: 'Sign in',
                    fontsize: 20,
                    ContainerColor: Color.fromRGBO(174, 143, 60, 1),
                    padding: 20,
                    // onTap: () async {
                    //   if (_formKey.currentState!.validate()) {
                    //     UserModel? modelU = await db.getLoginDetail(
                    //       usernameController.text.toString(),
                    //       passwordController.text.toString(),
                    //     );
                    //     final SharedPreferences prefs =
                    //         await SharedPreferences.getInstance();
                    //     await prefs.setInt('UserID', modelU!.UserID as int);
                    //     await prefs.setString(
                    //         'UserName', modelU.UserName.toString());
                    //     await prefs.setString('Email', modelU.Email.toString());
                    //     await prefs.setString('Phone', modelU.Phone.toString());
                    //     await prefs.setString(
                    //         'UserType', modelU.UserType.toString());
                    //     await prefs.setString(
                    //         'UserImage', modelU.UserImage.toString());
                    //
                    //     prefs.setBool(SplashScreenState.KEYLOGIN, true);
                    //
                    //     if (modelU != null) {
                    //       Navigator.of(context).pushReplacement(
                    //         MaterialPageRoute(
                    //           builder: (context) => Dashboard(model: modelU),
                    //         ),
                    //       );
                    //
                    //       usernameController.clear();
                    //       passwordController.clear();
                    //     } else {
                    //       showAlertDialogForInvalidLogin(context);
                    //     }
                    //   }
                    // },
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        print(
                            "::::::::::::::::before model::::::::::::::::::::");
                        UserModel? modelU = await db.getLoginDetail(
                          usernameController.text.toString(),
                          passwordController.text.toString(),
                        );
                        // print("::::::::::::::::after model::::::::::::::::::::${modelU!.UserName}");
                        if (modelU != null) {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setInt('UserID', modelU!.UserID as int);
                          await prefs.setString(
                              'UserName', modelU.UserName.toString());
                          await prefs.setString(
                              'Email', modelU.Email.toString());
                          await prefs.setString(
                              'Phone', modelU.Phone.toString());
                          await prefs.setString(
                              'UserType', modelU.UserType.toString());
                          await prefs.setString(
                              'UserImage', modelU.UserImage.toString());

                          prefs.setBool(SplashScreenState.KEYLOGIN, true);

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserwiseApartmentList(id: modelU.UserID),
                            ),
                          );
                        } else {
                          showAlertDialogForInvalidLogin(context);
                        }
                        ;

                        usernameController.clear();
                        passwordController.clear();
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Color.fromRGBO(174, 143, 60, 1),
                        )),
                        Text(
                          'Or Continue With',
                          style: TextStyle(
                              color: Color.fromRGBO(174, 143, 60, 1),
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Color.fromRGBO(174, 143, 60, 1),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            showAlertDialogForGoogleLogin(context);
                          },
                          child: SquareTile(
                              imagepath: 'assets/images/google.png')),
                      SizedBox(width: 25),
                      GestureDetector(
                          // onTap: () async {
                          //   print(
                          //       "::::::::::::::::before model::::::::::::::::::::");
                          //   UserModel? modelU = await db.getLoginDetail(
                          //     'abc@gmail.com',
                          //     'admin',
                          //   );
                          //   print(
                          //       "::::::::::::::::after model::::::::::::::::::::${modelU!.UserName}");
                          //
                          //   final SharedPreferences prefs =
                          //       await SharedPreferences.getInstance();
                          //   await prefs.setInt('UserID', modelU!.UserID as int);
                          //   await prefs.setString(
                          //       'UserName', modelU.UserName.toString());
                          //   await prefs.setString(
                          //       'Email', modelU.Email.toString());
                          //   await prefs.setString(
                          //       'Phone', modelU.Phone.toString());
                          //   await prefs.setString(
                          //       'UserType', modelU.UserType.toString());
                          //   await prefs.setString(
                          //       'UserImage', modelU.UserImage.toString());
                          //
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           UserwiseApartmentList(id: modelU.UserID),
                          //     ),
                          //   );
                          // },
                          child:
                              SquareTile(imagepath: 'assets/images/apple.png')),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member ?',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddUser(),
                            ),
                          );
                        },
                        child: Text(
                          ' Register Now',
                          style: TextStyle(
                              color: Color.fromRGBO(174, 143, 60, 1),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialogForInvalidLogin(BuildContext context) {
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
      backgroundColor: Color.fromRGBO(174, 143, 60, 1),
      shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      title: Text(
        "",
        style: TextStyle(color: Colors.white),
      ),
      content: Text("INVALID USERNAME OR PASSWORD.",
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

  showAlertDialogForGoogleLogin(BuildContext context) {
    AlertDialog alert = AlertDialog(
        backgroundColor: Colors.white,
        shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        title: Text(
          "G-mail Login",
          style: TextStyle(color: Colors.black),
        ),
        content: Column(
          children: [
            InkWell(
              onTap: () async {
                print("::::::::::::::::before model::::::::::::::::::::");
                UserModel? modelU = await db.getLoginDetail(
                  'abc@gmail.com',
                  'admin',
                );
                print(
                    "::::::::::::::::after model::::::::::::::::::::${modelU!.UserName}");

                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setInt('UserID', modelU!.UserID as int);
                await prefs.setString('UserName', modelU.UserName.toString());
                await prefs.setString('Email', modelU.Email.toString());
                await prefs.setString('Phone', modelU.Phone.toString());
                await prefs.setString('UserType', modelU.UserType.toString());
                await prefs.setString('UserImage', modelU.UserImage.toString());

                prefs.setBool(SplashScreenState.KEYLOGIN, true);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        UserwiseApartmentList(id: modelU.UserID),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.blue.shade900),
                    borderRadius: BorderRadius.circular(10)),
                width: double.maxFinite,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset("assets/images/google.png", width: 20),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'abc@gmail.com',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            // GmailLogin(Gmail: 'dk@gmail.com',Password: 'passwd'),
            // SizedBox(height: 10),
            // InkWell(
            //   onTap: () async {
            //     print("::::::::::::::::before model::::::::::::::::::::");
            //     UserModel? modelU = await db.getLoginDetail(
            //       'dk@gmail.com',
            //       'passwd',
            //     );
            //     print(
            //         "::::::::::::::::after model::::::::::::::::::::${modelU!.UserName}");
            //
            //     final SharedPreferences prefs =
            //         await SharedPreferences.getInstance();
            //     await prefs.setInt('UserID', modelU!.UserID as int);
            //     await prefs.setString('UserName', modelU.UserName.toString());
            //     await prefs.setString('Email', modelU.Email.toString());
            //     await prefs.setString('Phone', modelU.Phone.toString());
            //     await prefs.setString('UserType', modelU.UserType.toString());
            //     await prefs.setString('UserImage', modelU.UserImage.toString());
            //
            //     prefs.setBool(SplashScreenState.KEYLOGIN, true);
            //
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             UserwiseApartmentList(id: modelU.UserID),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     padding: EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //         border: Border.all(width: 2, color: Colors.blue.shade900),
            //         borderRadius: BorderRadius.circular(10)),
            //     width: double.maxFinite,
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Image.asset("assets/images/google.png", width: 20),
            //         SizedBox(
            //           width: 25,
            //         ),
            //         Text(
            //           'dk@gmail.com',
            //           style: TextStyle(
            //               fontWeight: FontWeight.w500,
            //               color: Colors.black,
            //               fontSize: 18),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10),
            // InkWell(
            //   onTap: () async {
            //     print("::::::::::::::::before model::::::::::::::::::::");
            //     UserModel? modelU = await db.getLoginDetail(
            //       'nk@gmail.com',
            //       'passwd',
            //     );
            //     print(
            //         "::::::::::::::::after model::::::::::::::::::::${modelU!.UserName}");
            //
            //     final SharedPreferences prefs =
            //         await SharedPreferences.getInstance();
            //     await prefs.setInt('UserID', modelU!.UserID as int);
            //     await prefs.setString('UserName', modelU.UserName.toString());
            //     await prefs.setString('Email', modelU.Email.toString());
            //     await prefs.setString('Phone', modelU.Phone.toString());
            //     await prefs.setString('UserType', modelU.UserType.toString());
            //     await prefs.setString('UserImage', modelU.UserImage.toString());
            //
            //     prefs.setBool(SplashScreenState.KEYLOGIN, true);
            //
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             UserwiseApartmentList(id: modelU.UserID),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     padding: EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //         border: Border.all(width: 2, color: Colors.blue.shade900),
            //         borderRadius: BorderRadius.circular(10)),
            //     width: double.maxFinite,
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Image.asset("assets/images/google.png", width: 20),
            //         SizedBox(
            //           width: 25,
            //         ),
            //         Text(
            //           'nk@gmail.com',
            //           style: TextStyle(
            //               fontWeight: FontWeight.w500,
            //               color: Colors.black,
            //               fontSize: 18),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10),
            // InkWell(
            //   onTap: () async {
            //     print("::::::::::::::::before model::::::::::::::::::::");
            //     UserModel? modelU = await db.getLoginDetail(
            //       'kp@gmail.com',
            //       'passwd',
            //     );
            //     print(
            //         "::::::::::::::::after model::::::::::::::::::::${modelU!.UserName}");
            //
            //     final SharedPreferences prefs =
            //     await SharedPreferences.getInstance();
            //     await prefs.setInt('UserID', modelU!.UserID as int);
            //     await prefs.setString('UserName', modelU.UserName.toString());
            //     await prefs.setString('Email', modelU.Email.toString());
            //     await prefs.setString('Phone', modelU.Phone.toString());
            //     await prefs.setString('UserType', modelU.UserType.toString());
            //     await prefs.setString('UserImage', modelU.UserImage.toString());
            //
            //     prefs.setBool(SplashScreenState.KEYLOGIN, true);
            //
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             UserwiseApartmentList(id: modelU.UserID),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     padding: EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //         border: Border.all(width: 2, color: Colors.blue.shade900),
            //         borderRadius: BorderRadius.circular(10)),
            //     width: double.maxFinite,
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Image.asset("assets/images/google.png", width: 20),
            //         SizedBox(
            //           width: 25,
            //         ),
            //         Text(
            //           'kp@gmail.com',
            //           style: TextStyle(
            //               fontWeight: FontWeight.w500,
            //               color: Colors.black,
            //               fontSize: 18),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10),
            // InkWell(
            //   onTap: () async {
            //     print("::::::::::::::::before model::::::::::::::::::::");
            //     UserModel? modelU = await db.getLoginDetail(
            //       'rv@gmail.com',
            //       'passwd',
            //     );
            //     print(
            //         "::::::::::::::::after model::::::::::::::::::::${modelU!.UserName}");
            //
            //     final SharedPreferences prefs =
            //     await SharedPreferences.getInstance();
            //     await prefs.setInt('UserID', modelU!.UserID as int);
            //     await prefs.setString('UserName', modelU.UserName.toString());
            //     await prefs.setString('Email', modelU.Email.toString());
            //     await prefs.setString('Phone', modelU.Phone.toString());
            //     await prefs.setString('UserType', modelU.UserType.toString());
            //     await prefs.setString('UserImage', modelU.UserImage.toString());
            //
            //     prefs.setBool(SplashScreenState.KEYLOGIN, true);
            //
            //     Navigator.of(context).pushReplacement(
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             UserwiseApartmentList(id: modelU.UserID),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     padding: EdgeInsets.all(10),
            //     decoration: BoxDecoration(
            //         border: Border.all(width: 2, color: Colors.blue.shade900),
            //         borderRadius: BorderRadius.circular(10)),
            //     width: double.maxFinite,
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Image.asset("assets/images/google.png", width: 20),
            //         SizedBox(
            //           width: 25,
            //         ),
            //         Text(
            //           'rv@gmail.com',
            //           style: TextStyle(
            //               fontWeight: FontWeight.w500,
            //               color: Colors.black,
            //               fontSize: 18),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10),
          ],
        ));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<UserModel> userDetail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel modelU = UserModel(
      UserID1: prefs.getInt('UserID') as int,
        UserName1: prefs.getString('UserName').toString(),
        Phone1: prefs.getString('Phone'),
        Email1: prefs.getString('Email').toString(),
        UserType1: prefs.getString('UserType').toString(),
        UserImage1: prefs.getString('UserImage').toString());
    modelU.UserID = prefs.getInt('UserID');

    return modelU;
  }
}
