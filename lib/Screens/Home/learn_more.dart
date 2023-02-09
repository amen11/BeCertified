import 'package:becertified/Screens/Quiz/Quiz_screen.dart';
import 'package:becertified/controllers/globalController.dart';
import 'package:get/get.dart';

import '../Widgets/lesson_card.dart';
import 'background.dart';
import '../Models/lesson.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Learnmore extends StatefulWidget {
  String text;
  String desc;
  String image;
  String id;
  Learnmore(
      {required this.text,
      required this.desc,
      required this.image,
      required this.id});

  @override
  _LearnmoreState createState() => _LearnmoreState();
}

class _LearnmoreState extends State<Learnmore> {
  int _selectedTag = 0;

  void changeTab(int index) {
    setState(() {
      _selectedTag = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Stack(children: [
          Transform.rotate(
            origin: const Offset(30, -60),
            angle: 2.4,
            child: Container(
              margin: const EdgeInsets.only(
                left: 75,
                top: 20,
              ),
              height: 300,
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
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Stack(
                          children: [
                            Align(
                              child: Text(
                                "",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Center(
                          child: Image(
                            height: 200,
                            image: NetworkImage(widget.image),
                          ),
                        ),
                      ),
                      Text(
                        widget.text,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: white),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        widget.desc,
                        style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: white,
                          ),
                          const Text(
                            " 4.8",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Icon(
                            Icons.timer,
                            color: Colors.grey,
                          ),
                          const Text(
                            " 72 Hours",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            " \$40",
                            style: TextStyle(
                              color: white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTabView(
                        index: _selectedTag,
                        changeTab: changeTab,
                      ),
                      _selectedTag == 0
                          ? const PlayList()
                          : const Description(),
                    ],
                  ),
                ),
              ),
              bottomSheet: BottomSheet(
                onClosing: () {},
                backgroundColor: Colors.white,
                enableDrag: false,
                builder: (context) {
                  return SizedBox(
                    height: 80,
                    child:
                        EnrollBottomSheet(widget.id, widget.text, widget.image),
                  );
                },
              ),
            ),
          ),
        ]));
  }
}

class PlayList extends StatelessWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 20,
          );
        },
        padding: const EdgeInsets.only(top: 20, bottom: 40),
        shrinkWrap: true,
        itemCount: lessonList.length,
        itemBuilder: (_, index) {
          return LessonCard(lesson: lessonList[index]);
        },
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Text(""),
    );
  }
}

class CustomTabView extends StatefulWidget {
  final Function(int) changeTab;
  final int index;
  const CustomTabView({Key? key, required this.changeTab, required this.index})
      : super(key: key);

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  final List<String> _tags = ["Playlist (22)", "Description"];

  Widget _buildTags(int index) {
    return GestureDetector(
      onTap: () {
        widget.changeTab(index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .08, vertical: 15),
        decoration: BoxDecoration(
          color: widget.index == index ? Color(0xFF113F67) : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          _tags[index],
          style: TextStyle(
            color: widget.index != index ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: _tags
            .asMap()
            .entries
            .map((MapEntry map) => _buildTags(map.key))
            .toList(),
      ),
    );
  }
}

class EnrollBottomSheet extends StatefulWidget {
  String id;
  String name;
  String imageURL;

  EnrollBottomSheet(this.id, this.name, this.imageURL, {Key? key})
      : super(key: key);

  @override
  _EnrollBottomSheetState createState() => _EnrollBottomSheetState();
}

class _EnrollBottomSheetState extends State<EnrollBottomSheet> {
  GlobalController globalController = Get.put(GlobalController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Row(
        children: [
          FutureBuilder<bool>(
              future: globalController.isAddedToMyWishList(widget.id),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? CustomIconButton(
                        onTap: () async {
                          print("hey");

                          await globalController
                              .addToMyWishList("nabeel", "imageURL", "id")
                              .then((value) => setState(() {}));
                        },
                        height: 45,
                        width: 45,
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.grey,
                          size: 30,
                        ),
                      )
                    : snapshot.data ?? true
                        ? CustomIconButton(
                            onTap: () async {
                              await globalController
                                  .addToMyWishList(
                                      widget.name, widget.imageURL, widget.id)
                                  .then((value) => setState(() {}));
                            },
                            height: 45,
                            width: 45,
                            child: const Icon(
                              Icons.favorite,
                              // color: Colors.pink,
                              color: Colors.grey,

                              size: 30,
                            ),
                          )
                        : CustomIconButton(
                            onTap: () async {
                              print("hey");
                              // await globalController.removeFromMyWishList(widget.id).then((value) => setState((){}));
                              await globalController
                                  .removeFromMyWishList(widget.id)
                                  .then((value) => setState(() {}));
                            },
                            height: 45,
                            width: 45,
                            child: const Icon(
                              Icons.favorite,
                              // color: Colors.grey,
                              color: Colors.pink,
                              size: 30,
                            ),
                          );
              }),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: CustomIconButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Quizscreen()),
                );
              },
              color: black,
              height: 45,
              width: 45,
              child: const Text(
                "Pass Quiz !",
                style: TextStyle(
                  color: white,
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final Color? color;
  final VoidCallback onTap;

  const CustomIconButton({
    Key? key,
    required this.child,
    required this.height,
    required this.width,
    this.color = Colors.white,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(child: child),
      ),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Color(0xFF113F67),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 2.0,
            spreadRadius: .05,
          ), //BoxShadow
        ],
      ),
    );
  }
}
