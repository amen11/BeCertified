import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GlobalController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addToMyWishList(String name, String imageURL, String id) async {
    await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(auth.currentUser!.uid)
        .collection('myWishList')
        .doc(id)
        .set({"name": name, "imageURL": imageURL, "id": id});
  }

  Future<bool> isAddedToMyWishList(String id) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(auth.currentUser!.uid)
        .collection('myWishList')
        .where('id', isEqualTo: id)
        .get();
    return result.docs.isEmpty;
  }

  Future<void> removeFromMyWishList(String id) async {
    await FirebaseFirestore.instance
        .collection('wishlist')
        .doc(auth.currentUser!.uid)
        .collection('myWishList')
        .doc(id)
        .delete();
  }

  Future<QuerySnapshot> getMyWishList() async {
    return FirebaseFirestore.instance
        .collection('wishlist')
        .doc(auth.currentUser!.uid)
        .collection('myWishList')
        .get();
  }

  Future<QuerySnapshot> getFilteredSeachResult(String text) async {
    print("called");
    return FirebaseFirestore.instance
        .collection('category')
        .where('name', isEqualTo: text)
        .get();
  }

  Future<void> uploadImage(File file) async {
    try {
      final ref = FirebaseStorage.instance.refFromURL(
          "https://firebasestorage.googleapis.com/v0/b/becertified-6cbee.appspot.com/o/avatars/${auth.currentUser!.uid}?alt=media&token=b54c1a59-d3ab-4e2c-bbae-9f46ee569c87");

      await ref.putFile(file).then((p0) async => {
            await FirebaseStorage.instance
                .refFromURL(
                    "https://firebasestorage.googleapis.com/v0/b/becertified-6cbee.appspot.com/o/avatars/${auth.currentUser!.uid}?alt=media&token=b54c1a59-d3ab-4e2c-bbae-9f46ee569c87")
                .getDownloadURL()
                .then((value) async => {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(auth.currentUser!.uid)
                          .update({
                        "imageURL": value,
                      })
                    })
          });
    } catch (e) {
      log(e.toString());
    }
  }
}
