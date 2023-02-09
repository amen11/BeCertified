import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'background.dart';
import 'details_screen.dart';
import 'home_icon_buttoms.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          /* appBar: new AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ), */
          backgroundColor: bgColor,
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
              ),
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome,',
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
                      'Change your life through learning! ',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Expanded(
                      child: FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('category')
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
                                        padding: const EdgeInsets.all(5),
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Align(
                                            alignment: Alignment.topCenter,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return DetailsScreen(
                                                    categoryID: snapshot
                                                        .data!.docs[index].id,
                                                  );
                                                }));
                                              },
                                              child: CatigoryW(
                                                image: snapshot
                                                    .data!.docs[index]['image'],
                                                text: snapshot.data!.docs[index]
                                                    ['text'],
                                                color: Colors.white,
                                                OnPressed: () {},
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
