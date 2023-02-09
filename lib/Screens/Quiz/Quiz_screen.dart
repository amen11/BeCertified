import 'package:becertified/Screens/Quiz/next_button.dart';
import 'package:becertified/Screens/Quiz/question_model.dart';
import 'package:becertified/Screens/Quiz/question_model.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'question_widget.dart';
import 'next_button.dart';
import 'option_card.dart';
import '../Quiz/result_box.dart';
import '../Quiz/db_connection.dart';

class Quizscreen extends StatefulWidget {
  const Quizscreen({super.key});

  @override
  State<Quizscreen> createState() => _QuizscreenState();
}

class _QuizscreenState extends State<Quizscreen> {
  var db = DBconnect();
  //List<Question> _questions = [
  //Question(
  //id: '10',
  //title:
  //  'Which tool can be used to find compliance information that relates to the AWS Cloud platform?',
  //options: {
  //'Amazon Inspector': false,
  //'AWS Trusted Advisor': false,
  //'AWS Artifact': true,
  //'AWS Personal Health Dashboard': false,
  // },
  //),
  // Question(
  //  id: '11',
  // title:
  //   'Which service can assist with protecting against common web-based exploits?',
  //options: {
  //'AWS Web Application Firewall (WAF) ': true,
  //'AWS Shield': false,
  //'Amazon Route': false,
  //'AWS CloudHSM': false
  //},
  //),
  //];
  late Future _questions;

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  int index = 0;
  int score = 0;
  bool check = false;
  bool isAlreadySelected = false;
  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) => ResultBox(
                result: score,
                questionLength: questionLength,
                onPressed: startOver,
              )));
    } else {
      if (check) {
        setState(() {
          index++;
          check = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please select any option'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20.0)));
      }
    }
  }

  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        check = true;
        isAlreadySelected = true;
      });
    }
  }

  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      check = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  int selectBtn = 0;
  Widget build(BuildContext context) => FutureBuilder(
        future: _questions as Future<List<Question>>,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              var extractedData = snapshot.data as List<Question>;
              return Scaffold(
                backgroundColor: bgColor,
                body: SingleChildScrollView(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 40, 40, 10),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(
                          fontSize: 25.0, color: Color(0xFFF8F1F1)),
                    ),
                  ),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 200),
                      child: Column(
                        children: [
                          QuestionWidget(
                              indexAction: index,
                              question: extractedData[index].title,
                              totalQuestions: extractedData.length),
                          const Divider(
                            color: Color(0xFFF8F1F1),
                          ),
                          const SizedBox(height: 25.0),
                          for (int i = 0;
                              i < extractedData[index].options.length;
                              i++)
                            GestureDetector(
                              onTap: () => checkAnswerAndUpdate(
                                  extractedData[index]
                                      .options
                                      .values
                                      .toList()[i]),
                              child: OptionCard(
                                option: extractedData[index]
                                    .options
                                    .keys
                                    .toList()[i],
                                color: check
                                    ? extractedData[index]
                                                .options
                                                .values
                                                .toList()[i] ==
                                            true
                                        ? correct
                                        : incorrect
                                    : neutre,
                              ),
                            )
                        ],
                      )),
                ])),
                floatingActionButton: GestureDetector(
                  onTap: () => nextQuestion(extractedData.length),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: NextButton(),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: Text('No data'),
          );
        }),
      );
}
