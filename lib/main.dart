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

  void checkAnswer(bool userChoice) {
    if (quizBrint.isFinished()) {
      print("Finished");
      Alert(context: context, title: "FINISHRD", desc: "you are done.").show();
      setState(() {
        quizBrint.reset();
        scorekeeper.clear();
      });
    } else {
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
        quizBrint.nextQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black87,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
