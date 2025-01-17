import 'package:apartment_management/About_Us/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Scaffold(
        appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle( //<-- SEE HERE
              // Status bar color
              statusBarColor: kPrimaryBackgroundColor,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(174, 143, 60, 1),
          title: const Text(
            "About Us",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),
          ),
        ),
        body: Container(

          color: Colors.grey.shade200,
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          //(x,y)
                          blurRadius: 3,
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.grey.shade300,
                        ],
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40, // Image radius
                        backgroundImage: AssetImage("assets/images/logo.png"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Apartment Management",
                      style: TextStyle(
                          fontSize: 15,
                          color: kPrimaryBackgroundColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        color: Color.fromRGBO(174, 143, 60, 1)),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: const Text(
                      "Meet Our Team",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 0, bottom: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryBackgroundColor),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.grey.shade50,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              flex: 2,
                              child: Text(
                                "Devloped by",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: kPrimaryBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Expanded(
                              child: Text(
                                ":",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: kPrimaryBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                children: const [
                                  Text(
                                    "Divyesh Busa (200540107028)  ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Mentored by",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: kPrimaryBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ":",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: kPrimaryBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                "Prof. Mehul Bhundiya, Computer Engineering Department",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Explored by",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: kPrimaryBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ":",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: kPrimaryBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                "ASWDC, School Of Computer Science",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: const [
                            Expanded(
                              flex: 2,
                              child: Text(
                                "Eulogized by",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: kPrimaryBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ":",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: kPrimaryBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                "Darshan University, Rajkot, Gujarat - INDIA",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        color:Color.fromRGBO(174, 143, 60, 1)),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: const Text(
                      "About ASWDC",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 0, bottom: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryBackgroundColor),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.grey.shade50,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.asset(
                                "assets/images/du_logo.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Image.asset(
                                "assets/images/logo_aswdc.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          textAlign: TextAlign.justify,
                          "ASWDC is Application, Software and Website Development Center @ Darshan Engineering College run by Students and Staff of Computer Engineering Department.",
                          style: TextStyle(fontSize: 11),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          textAlign: TextAlign.justify,
                          "Sole purpose of ASWDC is to bridge gap between university curriculum & industry demands. Students learn cutting edge technologies, develop real world application & experiences professional environment @ ASWDC under guidance of industry experts & faculty members.",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        color: Color.fromRGBO(174, 143, 60, 1)),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: const Text(
                      "Contact Us",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: kPrimaryBackgroundColor),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.grey.shade50,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.mail_outline_rounded,
                              size: 15,
                              color: kPrimaryBackgroundColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse('mailto:aswdc@darshan.ac.in'));
                              },
                              child: const Text(
                                "aswdc@darshan.ac.in",
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.call_rounded,
                              size: 15,
                              color: kPrimaryBackgroundColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse('tel:79849 91167'));
                              },
                              child: const Text(
                                "+91 79849 91167",
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.public_rounded,
                              size: 15,
                              color: kPrimaryBackgroundColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                launchUrl(Uri.parse("https://www.darshan.ac.in/"));
                              },
                              child: const Text(
                                "www.darshan.ac.in",
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "\u00a9 2023 Darshan University",
                        style: TextStyle(fontSize: 12),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "All Rights Reversed - ",
                            style: TextStyle(fontSize: 12),
                          ),
                          GestureDetector(
                            onTap: () {
                              launchUrl(
                                  Uri.parse("http://www.darshan.ac.in/DIET/ASWDC-Mobile-Apps/Privacy-Policy-General"));
                            },
                            child: const Text(
                              "Privacy Policy",
                              style: TextStyle(
                                  color: Colors.deepPurple, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Made with ♥️ in India ",
                        style: TextStyle(fontSize: 12),
                      ),
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
}
