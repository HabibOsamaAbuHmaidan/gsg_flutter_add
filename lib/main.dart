import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_flutter/question.dart';
import 'package:gsg_flutter/quizbrian.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Quizpage(),
        ),
      ),
    );
  }
}

class Quizpage extends StatefulWidget {
  const Quizpage({Key? key}) : super(key: key);

  @override
  State<Quizpage> createState() => _QuizpageState();
}

class _QuizpageState extends State<Quizpage> {
  QuizBrint quizBrint = QuizBrint();

  List<Widget> scorekeeper = [];
  int? _choice;

  void checkAnswer(bool userChoice) {
    bool correctAnwer = quizBrint.getquestionAnswer();
    setState(() {
      if (correctAnwer = userChoice) {
        scorekeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scorekeeper.add(Icon(Icons.close, color: Colors.red));
      }
    });

    if (quizBrint.isFinished()) {
      print("Finished");
      Timer(Duration(seconds: 2), () {
        Alert(context: context, title: "FINISHRD", desc: "you are done.")
            .show();
        setState(() {
          quizBrint.reset();
          scorekeeper.clear();
        });
      });
    } else {
      quizBrint.nextQuestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.green.shade400,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                        child: Text(
                      quizBrint.getQuestionText(),
                      style:
                          TextStyle(fontSize: 25.0, color: Color(0xFFFAFAFA)),
                    ))),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFF004D40)),
                    ),
                    child: Text(
                      "True",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      checkAnswer(true);
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ButtonStyle().copyWith(
                      backgroundColor:
                          MaterialStatePropertyAll(Color(0xFFB71C1C)),
                    ),
                    child: Text(
                      "false",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      checkAnswer(false);
                    },
                  ),
                ),
              ),

              // TODO: Add your own signing config for the release build.
              Wrap(
                children: scorekeeper,
              ),
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Thomas Jefferson'),
                      leading: Radio<int>(
                        value: 1,
                        groupValue: _choice,
                        onChanged: (value) {
                          print(value);

                          setState(() {
                            _choice = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Thomas Jefferson'),
                      leading: Radio<int>(
                        value: 2,
                        groupValue: _choice,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            _choice = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Thomas Jefferson'),
                      leading: Radio<int>(
                        value: 3,
                        groupValue: _choice,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            _choice = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
