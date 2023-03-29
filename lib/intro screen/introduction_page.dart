
import 'package:apartment_management/Database/database.dart';
import 'package:apartment_management/intro%20screen/intro1.dart';
import 'package:apartment_management/intro%20screen/intro2.dart';
import 'package:apartment_management/intro%20screen/intro3.dart';
import 'package:apartment_management/login/login_page.dart';
import 'package:apartment_management/login/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {


  @override
  void initState() {
    super.initState();
    MyDatabase().copyPasteAssetFileToRoot();
    MyDatabase().initDatabase();
  }
  // rgba(122,96,29,255)


  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            controller: _controller,
            children: [
              Intro1(),
              Intro2(),
              Intro3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                        color: Color.fromRGBO(237,192,80,1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ColorTransitionEffect(
                    dotColor: Colors.white,
                      activeDotColor: Color.fromRGBO(237,192,80,1)),
                ),
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoginPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'DONE',
                          style: TextStyle(
                              color: Color.fromRGBO(237,192,80,1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          'NEXT',
                          style: TextStyle(
                              color: Color.fromRGBO(237,192,80,1),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
