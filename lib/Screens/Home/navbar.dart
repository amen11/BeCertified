import 'package:becertified/Screens/Home/home_page.dart';
import 'package:becertified/Screens/Home/search_screen.dart';
import 'package:becertified/Screens/Home/wishlist_screen.dart';
import 'package:becertified/Screens/Profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  List<Widget> screens = [
    HomePage(),
    WishlistPage(),
    SearchPage(),
    ProfilePage(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: GNav(
        rippleColor: Color(0xFF87C0CD),
        hoverColor: Color(0xFF113F67),
        gap: 5,
        onTabChange: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        activeColor: Color(0xFF113F67),
        iconSize: 20,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: Color(0xFF87C0CD),
        color: Colors.black,
        tabs: [
          GButton(
              icon: LineIcons.home,
              text: 'Home',
              onPressed: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => HomePage(),
                //   ),
                // );
              }),
          GButton(
              icon: LineIcons.heart,
              text: 'Likes',
              onPressed: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => WishlistPage(),
                //   ),
                // );
              }),
          GButton(
              icon: LineIcons.search,
              text: 'Search',
              onPressed: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SearchPage(),
                //   ),
                // );
              }),
          GButton(
              icon: LineIcons.user,
              text: 'Profile',
              onPressed: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ProfilePage(),
                //   ),
                // );
              }),
        ],
      ),
    );
  }
}
