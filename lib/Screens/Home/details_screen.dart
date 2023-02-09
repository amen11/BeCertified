import 'package:becertified/controllers/globalController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'details_icons.dart';

class DetailsScreen extends StatefulWidget {
  final String categoryID;
  const DetailsScreen({required this.categoryID, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  GlobalController globalController = Get.put(GlobalController());
  int selectBtn = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Color(0xFF113F67),
      body: Stack(children: [
        Transform.rotate(
          origin: Offset(30, -60),
          angle: 2.4,
          child: Container(
            margin: EdgeInsets.only(
              left: 75,
              top: 40,
            ),
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                colors: [Color(0xFF113F67), Color(0xFF87C0CD)],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Certifications',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Get Certified with Tek-up',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('certifs')
                      .where('categoryID', isEqualTo: widget.categoryID)
                      .get(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Container()
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: CatigoryW2(
                                      image: snapshot.data!.docs[index]
                                          ['image'],
                                      text: snapshot.data!.docs[index]['text'],
                                      color: Color(0xFF191555),
                                      desc: snapshot.data!.docs[index]['desc'],
                                      id: snapshot.data!.docs[index].id,
                                    ),
                                  ),
                                ),
                              );
                            });
                  }),
            ),
          ]),
        )
      ]));
}
