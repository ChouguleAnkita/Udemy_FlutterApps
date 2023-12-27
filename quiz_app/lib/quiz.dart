import 'package:flutter/material.dart';
import 'package:quiz_app/question_screen.dart';
import 'package:quiz_app/start_screen.dart';
import 'package:quiz_app/result_screen.dart';
import 'package:quiz_app/data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

//private class
class _QuizState extends State<Quiz> {
  List<String> selectAnswers = [];
  var activeScreen = "start-screen";

  void switchScreen() {
    setState(() {
      activeScreen = "question-screen";
    });
  }

  void chooseAnswer(String answer) {
    selectAnswers.add(answer);
    setState(() {
      if (selectAnswers.length == questions.length) {
        activeScreen = "result-screen";
      }
    });
  }

  void restartQuiz() {
    setState(() {
      selectAnswers = [];
      activeScreen = "question-screen";
    });
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == "question-screen") {
      screenWidget = QuestionScreen(onSelectAnswer: chooseAnswer);
    }

    if (activeScreen == "result-screen") {
      screenWidget = ResultScreen(
        chosenAnswers: selectAnswers,
        onRestart: restartQuiz,
      );
    }
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.purple,
              Color.fromRGBO(184, 144, 191, 1),
            ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          ),
          child: Center(
            child: screenWidget,
          ),
        ),
      ),
    );
  }
}

//=======================Using ternary operator or initstate method
// class _QuizState extends State<Quiz> {
//   var activeScreen = "start-screen";
//   // Widget? activeScreen;
//   // @override
//   // void initState() {
//   //   activeScreen= StartScreen(switchScreen);
//   //   super.initState();
//   // }

//   void switchScreen() {
//     setState(() {
//       // activeScreen=const QuestionScreen();
//       activeScreen = "question-screen";
//     });
//   }

//   @override
//   Widget build(context) {
//     return MaterialApp(
//       home: Scaffold(
//         // backgroundColor: Colors.purple,
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(colors: [
//               Colors.purple,
//               Color.fromRGBO(184, 144, 191, 1),
//             ], begin: Alignment.bottomLeft, end: Alignment.topRight),
//           ),
//           child: Center(
//             // child:activeScreen,
//             child: activeScreen == 'start-screen'
//                 ? StartScreen(switchScreen)
//                 : const QuestionScreen(),
//           ),
//         ),
//       ),
//     );
//   }
// }

