import 'dart:io';

import 'package:becertified/Screens/Chat/dashboard.dart';
import 'package:becertified/controllers/authController.dart';
import 'package:becertified/controllers/globalController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Home/background.dart';
import 'ProfileMenu.dart';
import 'constant.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthController authController = Get.put(AuthController());
  GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: NavPage(),

        backgroundColor: bgColor,
        body: Stack(children: [
          Transform.rotate(
            origin: const Offset(30, -60),
            angle: 2.4,
            child: Container(
              margin: const EdgeInsets.only(
                left: 75,
                top: 40,
              ),
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  colors: [Color(0xFF113F67), Color(0xFF87C0CD)],
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 70),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    /* Container(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                          child: IconButton(
                        onPressed: () {
                          //Navigator.of(context).push(
                          //MaterialPageRoute(builder: (context) =>));
                        },
                        icon: SvgPicture.asset(
                          "assets/send.svg",
                          color: kLightSecondaryColor,
                        ),
                        color: Color(0xFF25316D),
                      )),
                    ),
                     */
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: SizedBox(
                          height: 115,
                          width: 115,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              FutureBuilder<DocumentSnapshot>(
                                  future: authController.getMyInfo(),
                                  builder: (context, snapshot) {
                                    return !snapshot.hasData
                                        ? Container()
                                        : snapshot.data!['imageURL'] == ""
                                            ? CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    "assets/fatma.jpg"))
                                            : CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    snapshot
                                                        .data!['imageURL']));
                                  }),
                              Positioned(
                                right: -10,
                                bottom: 0,
                                child: SizedBox(
                                  height: 115,
                                  width: 115,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                          top: 85,
                                          bottom: 0,
                                          right: 10,
                                          left: 60,
                                          child: IconButton(
                                            onPressed: () async {
                                              final ImagePicker _picker =
                                                  ImagePicker();
                                              // Pick an image
                                              final XFile? image =
                                                  await _picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              await globalController
                                                  .uploadImage(
                                                      File(image!.path))
                                                  .then((value) =>
                                                      {setState(() {})});
                                            },
                                            icon:
                                                const Icon(Icons.photo_camera),
                                            color: Color(0xFF226597),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    ProfileMenu(
                      text: "My Account",
                      icon: "assets/User Icon.svg",
                      press: () => {},
                    ),
                    ProfileMenu(
                      text: "Inbox",
                      icon: "assets/mail.svg",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()),
                        );
                      },
                    ),
                    ProfileMenu(
                      text: "Report a problem",
                      icon: "assets/Question mark.svg",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()),
                        );
                      },
                    ),
                    ProfileMenu(
                      text: "Log Out",
                      icon: "assets/Log out.svg",
                      press: () async {
                        await authController.signOut();
                      },
                    ),
                  ])),
        ]));
  }
}
