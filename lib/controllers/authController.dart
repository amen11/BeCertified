import 'dart:developer';

import 'package:becertified/Screens/Auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/Home/home_page.dart';
import '../Screens/Home/navbar.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  void showAuthErreur(String errorMessage) {
    Get.snackbar(
      'Erreur',
      errorMessage,
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(Icons.error, color: Colors.white),
      colorText: Colors.white,
      backgroundColor: Colors.red,
      padding: const EdgeInsets.all(8),
    );
  }

  Future<void> signIn(String email, String password) async {
    if ((email.isNotEmpty) && (password.isNotEmpty)) {
      try {
        await auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then(
                (value) => {log(value.toString()), Get.off(() => NavPage())});
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showAuthErreur('Utilisateur non trouvé');
        } else if (e.code == 'wrong-password') {
          showAuthErreur('Incorrect mot de passe');
        } else if (e.code == "user-disabled") {
          showAuthErreur('Le compte est désactivé');
        }
      }
    } else {
      showAuthErreur('Email ou mot de passe invalide');
    }
  }
 

  Future<void> signOut() async {
    await auth.signOut().then((value) {
      Get.offAll(LoginScreen());
    });
    update();
  }

  Future<DocumentSnapshot> getMyInfo() async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid)
        .get();
  }

  Future<void> createAccount(String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(value.user?.uid)
            .set({"email": email,
            "imageURL":""
            
            }).then((value) {
          Get.off(() => NavPage());
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showAuthErreur('Faible Mot de passe');
      } else if (e.code == 'email-already-in-use') {
        showAuthErreur('Email déjà exist');
      }
    }
  }
}
