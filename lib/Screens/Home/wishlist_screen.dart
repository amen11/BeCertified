import 'package:becertified/controllers/globalController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'background.dart';

// ignore: must_be_immutable
class WishlistPage extends StatelessWidget {
  WishlistPage({super.key});

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
            padding: const EdgeInsets.only(top: 50, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Wishlist",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(
                  thickness: 1,
                  indent: 0,
                  endIndent: 50,
                  color: Colors.black,
                ),
                Expanded(
                  child: FutureBuilder<QuerySnapshot>(
                      future: globalController.getMyWishList(),
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? Container()
                            : ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (_, index) {
                                  return Dismissible(
                                    key:
                                        ValueKey(snapshot.data!.docs[index].id),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (drt) async {
                                      try {
                                        await globalController
                                            .removeFromMyWishList(
                                                snapshot.data!.docs[index].id);
                                      } catch (e) {
                                        print('error is ' + e.toString());
                                      }
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                          backgroundImage: NetworkImage(snapshot
                                              .data!.docs[index]['imageURL'])),
                                      title: Text(
                                          snapshot.data!.docs[index]['name'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  );
                                },
                              );
                      }),
                )
              ],
            ),
          )
        ]));
  }
}
