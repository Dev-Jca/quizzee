import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';
import 'expanded_button_widget.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    ),
  );
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();

  List<Icon> scoreKeeper = [];

//method checking answers
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else if (userPickedAnswer != correctAnswer) {
        scoreKeeper.add(
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }

      quizBrain.nextQuestion();
    });
  }

//method for alert
  showAlert(context) {
    Alert(
      context: context,
      title: "ALERT",
      desc: "You have reached the end of the quiz.",
    ).show();
  }

  //method to end the questions
  void checkQuestionsEnd() {
    if (quizBrain.isFinished() == true) {
      setState(() {
        showAlert(context);
        quizBrain.reset();
        scoreKeeper.clear();
      });
    }
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
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        ExpandedButtonWidget(
          text: 'True',
          onPressed: () {
            checkAnswer(true);
            checkQuestionsEnd();
          },
          backgroundColor: Colors.green,
        ),
        ExpandedButtonWidget(
          text: 'False',
          onPressed: () {
            checkAnswer(false);
            checkQuestionsEnd();
          },
          backgroundColor: Colors.red,
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
