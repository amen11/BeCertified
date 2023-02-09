import 'package:becertified/Screens/Home/background.dart';
import 'package:becertified/controllers/authController.dart';
import 'package:becertified/Screens/Profile/profile.dart';
import 'cahtPage.dart';
//import 'package:chatapp/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var data;
  var msgname;
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    AuthController().getMyInfo().then((value) {
      data = value;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  var search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Stack(children: [
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
          Scaffold(
            backgroundColor: Colors.transparent,
            /*  appBar: AppBar(
              backgroundColor: const Color.fromRGBO(18, 38, 67, 1),
              title: const Text('Chat App'),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      /* Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const ProfilePage();
                      })); */
                    },
                    child: data == null
                        ? Container()
                        : CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(data['image']),
                          ),
                  ),
                ),
              ],
            ), */
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromRGBO(18, 38, 67, 1),
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Create Group'),
                        content: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Enter Name',
                          ),
                          onChanged: (a) {
                            setState(() {
                              msgname = a;
                            });
                          },
                        ),
                        actions: [
                          OutlinedButton(
                              onPressed: () {
                                firestore
                                    .collection('Chat Rooms')
                                    .doc(msgname)
                                    .collection('messages')
                                    .doc(DateTime.now().toString())
                                    .set({
                                  'sender': auth.currentUser!.email,
                                  'msg': 'Hi! , New Chat Room Created',
                                  'time':
                                      DateFormat('hh:mm').format(DateTime.now())
                                });
                                firestore
                                    .collection('Chat Rooms')
                                    .doc(msgname)
                                    .set({'status': 'active'});
                                Navigator.pop(context);
                              },
                              child: const Text('Create'))
                        ],
                      );
                    });
              },
            ),
            drawer: const Drawer(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(214, 224, 239, 1),
                        borderRadius: BorderRadius.circular(14)),
                    child: TextField(
                      onChanged: (l) {
                        setState(() {
                          search = l;
                        });
                      },
                      decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search)),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Groups', //people
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: white),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: StreamBuilder(
                      stream: firestore.collection('Chat Rooms').snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return !snapshot.hasData
                            ? Container()
                            : ListView.builder(
                                itemCount: snapshot.data!.docs.where((element) {
                                  return element.id.contains(search);
                                }).length,
                                itemBuilder: (context, i) {
                                  return GroupCard(
                                    title: snapshot.data!.docs
                                        .where((element) {
                                          return element.id.contains(search);
                                        })
                                        .toList()[i]
                                        .id,
                                    snap: snapshot.data!.docs
                                        .where((element) {
                                          return element.id.contains(search);
                                        })
                                        .toList()[i]
                                        .reference
                                        .collection('messages')
                                        .snapshots(),
                                  );
                                });
                      }),
                ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final title;
  final snap;

  const GroupCard({
    Key? key,
    this.title,
    this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatPage(
              group: title,
            );
          }));
        },
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(214, 224, 239, 1),
              borderRadius: BorderRadius.circular(11)),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(18, 38, 67, 1),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: const Color.fromRGBO(18, 38, 67, 1),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  StreamBuilder(
                      stream: snap,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return !snapshot.hasData
                            ? Container()
                            : Text(
                                snapshot.data!.docs.last['msg'],
                                style: const TextStyle(
                                    color: Color.fromRGBO(18, 38, 67, 1),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400),
                              );
                      }),
                ],
              ),
              const Spacer(),
              StreamBuilder(
                  stream: snap,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.hasData
                        ? Text(
                            snapshot.data!.docs.last['time'].toString(),
                            style: const TextStyle(
                                color: const Color.fromRGBO(18, 38, 67, 1),
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          )
                        : Container();
                  }),
              const SizedBox(
                width: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
