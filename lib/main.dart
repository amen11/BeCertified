import 'package:becertified/Screens/Home/home_page.dart';
import 'package:becertified/Screens/Home/navbar.dart';
import 'package:becertified/Screens/Quiz/db_connection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/Auth/login.dart';
import 'Screens/Home/wishlist_screen.dart';

void main() async {
  var db=DBconnect();

  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCT0lZQLPgsE1laTSsiMUeuem1fP-Fbq3s",
      appId: "1:314913859858:android:71962a24acee9667c66bcb",
      messagingSenderId: "314913859858",
      projectId: "becertified-6cbee",
      storageBucket: "com.example.flutter_project",
    ),
  );
  db.fetchQuestions;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return GetMaterialApp(
            title: 'Getcertified',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: const Color(0xff4C53FB),
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
            // home: const RootPage(),
            home: NavPage(),
            // home: WishlistPage(),
            // home: NavPage(),
            // home: const DetailsScreen(),
          );
        });
  }
}
