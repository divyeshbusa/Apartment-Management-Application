import 'package:apartment_management/Componets/my_button.dart';
import 'package:apartment_management/Componets/my_textfield.dart';
import 'package:apartment_management/Componets/sqare_tile.dart';
import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/login/splashscreen.dart';
import 'package:apartment_management/models/user_model.dart';
import 'package:apartment_management/pages/add_user.dart';
import 'package:apartment_management/pages/dashboard.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usernameController = TextEditingController();
  final passwordController = TextEditingController();
  MyDatabase db = MyDatabase();

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
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                    child: Image.asset('assets/images/intro1.png'),
                    height: 230),
                SizedBox(height: 20),
                Text(
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
                  children: [
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
                MyTextField(
                    controller: usernameController,
                    hintText: "Username",
                    obscureText: false,
                    onChange: (value) {
                      return Container();
                    }),
                SizedBox(height: 15),
                MyTextField(
                    controller: passwordController,
                    hintText: "Password",
                    obscureText: true,
                    onChange: (value) {
                      return Container();
                    }),
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
                  onTap: () async {
                    UserModel? modelU = await db.getLoginDetail(usernameController.text.toString(),
                        passwordController.text.toString());
                    final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    await prefs.setInt('UserID', modelU!.UserID as int);
                    await prefs.setString(
                        'UserName', modelU.UserName.toString());
                    await prefs.setString(
                        'Email', modelU.Email.toString());
                    await prefs.setString('Phone', modelU.Phone.toString());
                    await prefs.setString(
                        'UserType', modelU.UserType.toString());
                    await prefs.setString(
                        'UserImage', modelU.UserImage.toString());

                    prefs.setBool(SplashScreenState.KEYLOGIN, true);

                    if(modelU != null){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Dashboard(model: modelU),
                        ),
                      );

                      usernameController.clear();
                      passwordController.clear();
                    }
                    else{
                      showAlertDialogForInvalidLogin(context);
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
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => AddUser(),
                            ),
                          );
                        },
                        child:
                        SquareTile(imagepath: 'assets/images/google.png')),
                    SizedBox(width: 25),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => AddUser(),
                            ),
                          );
                        },
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


}
