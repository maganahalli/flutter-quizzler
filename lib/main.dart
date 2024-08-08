import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'questionBank.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  QuestionBank questionBank = QuestionBank();

  String buildQuestion() {
    return questionBank.getQuestionText();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
              ),
              onPressed: () {
                checkAnswer(context, true);
              },
              child: Text('True',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                checkAnswer(context, false);
              },
              child: Text('False',
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          ),
        ),
        //Add a Row here as your score keeper
        Row(children: scoreKeeper)
      ],
    );
  }

  void checkAnswer(BuildContext context, bool userPickedAnswer) {
    if (questionBank.getQuestionText().contains('Quiz Ended')) {
      _onBasicAlertPressed(context);
      return;
    }
    bool correctAnswer = questionBank.getQuestionAnswer();
    print('Used clicked false button & Correct Answer is => ${correctAnswer}');
    if (userPickedAnswer == correctAnswer) {
      scoreKeeper.add(Icon(Icons.check, color: Colors.green));
    } else {
      scoreKeeper.add(Icon(Icons.close, color: Colors.red));
    }
    setState(() {
      questionBank.nextQuestion();
    });
  }

  // The easiest way for creating RFlutter Alert
  _onBasicAlertPressed(context) {
    Alert(
      context: context,
      title: "QUIZ ENDED",
      desc: "Flutter is more awesome with RFlutter Alert.",
    ).show();
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
