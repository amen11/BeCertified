import 'dart:developer';

import 'package:becertified/controllers/globalController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'background.dart';
import 'searchbar.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  GlobalController globalController = Get.put(GlobalController());

  bool isResultVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      log(controller.text);
      if (controller.text.isEmpty) {
        setState(() {
          isResultVisible = false;
        });
      } else {
        setState(() {
          isResultVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

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
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 50, 0, 0),
          ),
          const SizedBox(height: 150),
          Padding(
            padding: EdgeInsets.only(top: 150),
            child: CustomSearchField(
              hintField: 'Try "RedHat..."',
              backgroundColor: Colors.white70,
              controller: controller,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.size.width / 1.5, left: 10),
            child: Visibility(
              visible: isResultVisible,
              child: FutureBuilder<QuerySnapshot>(
                  future:
                      globalController.getFilteredSeachResult(controller.text),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Container()
                        : ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(snapshot.data!.docs[index]['name'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        snapshot.data!.docs[index]['image'])),
                              );
                            });
                  }),
            ),
          ),
        ]));
  }
}
